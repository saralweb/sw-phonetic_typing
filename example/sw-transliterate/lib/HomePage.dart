
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:transliterate/transliterate.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController inputController = TextEditingController();

  String name = "",
      sugSelected = "",
      constructorString = "",
      inputChar = "",
  sugFirst="";
  int start=0,end=0;
  List totalSuggestions = [];
  var transliterate = Transliterate();


  @override
  Widget build(BuildContext context) {
    inputController.text=name;
    final val = TextSelection.collapsed(offset: name.length);
    inputController.selection = val;
    print("BUILD");


    onSuggsnSelected(suggestion) {
      print("On sug selected");
      sugSelected = suggestion.toString();
      String attch=transliterate.word(name);
      // if (sugSelected == " ") {
      //   name+=" ";
      // }
      start=name.length-attch.length;
      end=name.length;

        inputController.text = name.replaceRange(start, end, sugSelected);
    }


    suggsnCallBack(pattern) {
      print("Sug CallBack");


      if(name!=""){
        if(totalSuggestions.first!=""){
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
              setState(() {

              });
            }

          final val = TextSelection.collapsed(offset: name.length);
          inputController.selection = val;                 //CURSOR POSITION CODE

        }
      }



    print("inputctr "+name);
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
            "HomePage",
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

                  TypeAheadField(
                    debounceDuration: Duration(milliseconds: 100),
                    textFieldConfiguration: TextFieldConfiguration(

                        autofocus: true,
                        // onEditingComplete: (){val+=suggestion.toString();},
                        controller: inputController,


                        onChanged: (value) async {
                          name=value;

                          inputChar=transliterate.word(name.trim());

                        },


                        // autofocus: true,
                        style: TextStyle(),
                        decoration: InputDecoration(

                            hintText: "Enter Text",
                            border: OutlineInputBorder())),


                    suggestionsCallback: suggsnCallBack,
                    onSuggestionSelected: onSuggsnSelected,

                    itemBuilder: (context, suggestion) {
                      return Container(
                        height: 40,
                        width: 10,

                        alignment: Alignment.center,

                        child: ListTile(
                          // shape: ,

                          autofocus: true,
                          minLeadingWidth: 5,
                          minVerticalPadding: 0,
                          tileColor: Colors.yellow[200],
                          title: Text(
                            "$suggestion",),

                        ),
                      );
                    },

                  ),
                ]
            ),
          ),
        ),
      );
    }
  }