import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transliterate/transliterate.dart';
import 'package:flutter/cupertino.dart';



class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);


  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  TextEditingController inputController = TextEditingController();
  FocusNode focusNode=new FocusNode();

  String name = "",
      sugSelected = "",
      constructorString = "",
      inputChar = "",
      sugFirst="";

  int start=0,end=0;
  bool showSuggestion=false;
  List totalSuggestions = [], totalSug= [];
  var transliterate = Transliterate();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode.addListener(() {
      print("show sug $showSuggestion");
      if(focusNode.hasFocus){
        print(focusNode.hasFocus.toString()+" has");
        setState(() {
          showSuggestion=true;


        });
      }
      else{
        setState(() {
          showSuggestion=false;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {


    inputController.text=name;
    final val = TextSelection.collapsed(offset: name.length);

    inputController.selection = val;
    print("BUILD");

    double width(double sugLen){
      print("sugLen txt $sugLen");


      if(sugLen<0)
      {sugLen=0;}

      else if (sugLen==1){sugLen=sugLen*45;}

      else if(sugLen%2==0){
        sugLen=60+((sugLen/2)-1)*25;
      }
      else if(sugLen%2!=0){
        sugLen=70+((sugLen~/2)-1)*25;
      }

      return sugLen;

    }


    onSuggsnSelected( suggestion) {
      print("On sug selected");
      print(suggestion);
      sugSelected = suggestion.toString();
      String attach=transliterate.word(name);
      start=name.length-attach.length;
      end=name.length;
      setState(() {
        name = name.replaceRange(start, end, suggestion);


      });
    }


    suggsnCallBack() {
      print("Sug CallBack");



      if(name!=""){

        if(totalSuggestions.length>0&&totalSuggestions.first!=""){
          // print("suggestion.first "+totalSuggestions.first);
          sugFirst=totalSuggestions.first;
          // print("sugFirst "+totalSuggestions.first);
        }

        start=name.length-(inputChar.length+1);
        end=name.length;

        if(name.length>1
            &&(name.split("").last==" ")
            &&(transliterate.isVC(name))){
          if(sugFirst!=" "){
            name = name.replaceRange(start, end, sugFirst)+" ";

          }

          final val = TextSelection.collapsed(offset: name.length);
          inputController.selection = val;                 //CURSOR POSITION CODE
        }
      }




      totalSuggestions = transliterate.suggestions(
          name: name, sugg: sugSelected
      );

      return totalSuggestions;
    }



    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.green,
        title: Text(
          "TxtFieldPage",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                SizedBox(
                  height: 60,
                ),
                // TextField( style: TextStyle(),
                //     decoration: InputDecoration(
                //
                //         hintText: "Enter Text",
                //         border: OutlineInputBorder())),


                TextField(
                    focusNode: focusNode,
                    autofocus: false,

                    onChanged: (value){
                      name=value;
                      inputChar=transliterate.word(name.trim());
                      setState(() {
                        totalSug= suggsnCallBack();
                      });


                    },

                    controller: inputController,
                    style: TextStyle(),
                    decoration: InputDecoration(

                        hintText: "Enter Text",
                        border: OutlineInputBorder())
                ),

                showSuggestion?
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child:
                  Row(
                    children:
                    List.generate(totalSug.length, (index) => Container(
                      height: 50,
                      width: width(totalSug[index].toString().length+0.0),
                      child: ListTile(
                        onTap: ()=>onSuggsnSelected(totalSug[index]),
                        title: Text(totalSug[index],
                          style: TextStyle(),),
                        tileColor: Colors.white,

                      ),
                    ),
                    ),

                  ),
                ):Container()



              ]
          ),
        ),
      ),

    );
  }
}

