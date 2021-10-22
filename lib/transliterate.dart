library transliterate;

import 'allMap.dart';

/// Class to convert english to hindi
class Transliterate {
  // String consonants="bcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ";
  // var vowels = "AaEeIiOoUu";
  // var punctuation = ",.><?/+=-_}{[]*&^%\$#@!~`\"\\|:;()";
  // var digits = "0123456789";
  String lastWordOfName="";
  String reten="";

 // consonants.split("").for

    String englishToHindi(String str) {
      str=str.toLowerCase();
    var hindi = _transliterateEnglishToHindi(str);
    return hindi;
  }
  

  List suggestions ({required String name ,required String sugg}) {
      name=name.toLowerCase();
      print("name in pac "+name);

    lastWordOfName=lastWordOf(name);

    reten=ret(name: name);


    String lst= "${englishToHindi(lastWordOfName)}";

    List sug=[];


    if(lst.isNotEmpty){
      sug.add(lst);        //1st list
    }


    if(name.isEmpty){
      return [" "];        //2nd list
    }



    if(reten.isNotEmpty){     //3rd list
      sug.add(reten);
    }


    if(sugges[lastWordOfName]!=null)
    {sug.addAll(sugges[lastWordOfName]);}        //4th list



    if(sugges[lastWordOf(word(name))]!=null)                //5th list
        { sug.addAll(sugges[lastWordOf(word(name))]);}     //suggestion of remaining characters
                                                            //after suggestion selection



    if(sugges[name[name.length-1]]!=null){
      sug.addAll(sugges[name[name.length-1]]);            //6th list
    }


    if(sugges[name[name.length-1]]!=null){
      sug.add(" ");            //7th list
    }

      return sug;}



String lastWordOf(String name){
  String ss = "";
  print("name in lastWord $name");
  ss = name
      .split(" ")
      .last;
print("ss "+ss);
  return ss;
}


  String patt0(String patt0){

    if(sugges[patt0]!=null){
    patt0=sugges[patt0][0];
    }
      return patt0;
  }


      String ret({required String name}){
        String reten="",reten2="";
        name=name.split(" ").last;
      int i=0;
      int start=0,last=1;
        print(name.length);
           while(i<name.length){
             if(patt0(name.substring(start,last))!=""){
               reten+=patt0(name.substring(start,last));

              start=last;
              last++;
              i++;
            }
           }
           print("reten $reten");
           print("reten2 $reten2");
      return reten;
      }



    String word(String input){
      String ans="",
          wrd=input.split(" ").last;
      int i=wrd.length-1;
      while(i>=0&&(_isConsonant(wrd[i])||_isVowel(wrd[i])||_isPunct(wrd[i])||_isDigit(wrd[i]))){
        ans=wrd[i]+ans;
        i--;
      }
      return ans;

    }


    bool isVC(String testName){
      String last=testName.split("")[testName.length-2]; //Check last character excluding space of
                                                         //inputController if consonant or not
      if(_isConsonant(last)||_isVowel(last)||_isPunct(last)||_isDigit(last)){
        return true;
      }
      return false;
    }





  bool _findstr(String str, String tofind) {
    for (var i = 0; i < str.length; i++)
      if (str[i] == tofind)
        return true;
    return false;
  }

  bool _isDigit(String a) {
    var str = "0123456789";
    return _findstr(str, a);
  }

  bool _isPunct(String a) {
    var str = ",.><?/+=-_}{[]*&^%\$#@!~`\"\\|:;()";
    return _findstr(str, a);
  }

  bool _isVowel(String a) {
    var str = "AaEeIiOoUu";
    return _findstr(str, a);
  }

  bool _isConsonant(String a) {
    var str =
        "bcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ";
    return _findstr(str, a);
  }

  //To get matra for consonants
  String _getMatra(String str) {
    var i = 0;

     if(str=="a"){
      return "ा";
    }else if(str=="i"){
      return "ि";
    }else if(str=="ee"){
      return "ई";
    }else if(str=="ii"){
      return "ी";
    }else if(str=="u"){
      return "ु";
    }else if(str=="uu"){
      return "ू";
    }else if(str=="e"){
      return "े";
    }else if(str=="ae"){
      return "ै";
    }else if(str=="o"){
      return "ो";
    }else if(str=="ou"){
      return "ौ";}
      else if(str=="au"){
      return "ौ";
    }else if(str=="n"){
      return "ा";
    }else if(str=="ah"){
      return "ा";
    }

    if (str.length < 1) {
      return "";
    }
    while (str[i] == ' ') {
      i++;
      if (i >= str.length) {
        break;
      }
    }
    if (i < str.length) {
      str = str.substring(i);
    }

    if (matraHindiEnglish1[str] != null) {
      return "${matraHindiEnglish1[str]}";
    }
    return "";
  }


  CoreSound _getShift(String str) {
    str = str.toLowerCase();

              //VOWELS DEFINITION
    if (str.indexOf("a") == 0) {
      if (str.indexOf("aa") == 0) {
        return CoreSound(coreSound: "आ", len: 2);
      }
      else if (str.indexOf("ao") == 0) {
       if (str.indexOf("aoo") == 0) {
        return CoreSound(coreSound: "औ", len: 3);
      }
        return CoreSound(coreSound: "ओ", len: 2);
      }
      return CoreSound(coreSound: "अ", len: 1);
    }
    else if (str.indexOf("ee") == 0) {
      return CoreSound(coreSound: "ई", len: 2);
    }
    else if (str.indexOf("e") == 0) {
      return CoreSound(coreSound: "इ", len: 1);
    }
    else if (str.indexOf("u") == 0) {
      if (str.indexOf("uu") == 0) {
        return CoreSound(coreSound: "ऊ", len: 2);
      }
      return CoreSound(coreSound: "उ", len: 1);
    }

     if (str.indexOf("rri") == 0) {
      return CoreSound(coreSound: "ऋ", len: 3);
    }



    if (str.indexOf("k") == 0) {

      if (str.indexOf("kh") == 0) {

        return CoreSound(coreSound: "ख", len: 2);
      }
      return CoreSound(coreSound: "क", len: 1);
    }
    //
    // else if (str.indexOf("g") == 0) {
    //   if (str.indexOf("gh") == 0) {
    //     return CoreSound(coreSound: "घ", len: 1);
    //   }
    //   return CoreSound(coreSound: "ग", len: 1);
    // }
    //
    //
    // else if (str.indexOf("c") == 0) {
    //   if (str.indexOf("ch") == 0) {
    //     if (str.indexOf("cha") == 0) {
    //       return CoreSound(coreSound: "छ", len: 3);
    //     }
    //     return CoreSound(coreSound: "च", len: 2);
    //   }
    //   return CoreSound(coreSound: "च", len: 1);
    // }
    //
    // else if (str.indexOf("j") == 0) {
    //   if (str.indexOf("jh") == 0) {
    //     return CoreSound(coreSound: "झ", len: 1);
    //   }
    //   return CoreSound(coreSound: "ज", len: 1);
    // }
    //
    //
    //
    // else if (str.indexOf("t") == 0) {
    //
    // if (str.indexOf("ta") == 0) {
    // return CoreSound(coreSound: "ट", len: 2);
    // }
    //   return CoreSound(coreSound: "त", len: 1);
    // }
    // else if (str.indexOf("tha") == 0) {
    //   if (str.indexOf("thaa") == 0) {
    //     return CoreSound(coreSound: "थ", len: 4);
    //   }
    //   return CoreSound(coreSound: "ठ", len: 1);
    // }
    // else if (str.indexOf("dda") == 0) {
    //   return CoreSound(coreSound: "ड", len: 1);
    // }
    // else if (str.indexOf("dha") == 0) {
    //   return CoreSound(coreSound: "ढ", len: 1);
    // }
    // else if (str.indexOf("nya") == 0) {
    //   return CoreSound(coreSound: "ण", len: 1);
    // }
    //
    // else if (str.indexOf("p") == 0) {
    //   if (str.indexOf("ph") == 0) {
    //     return CoreSound(coreSound: "फ", len: 2);
    //   }
    //   return CoreSound(coreSound: "प", len: 1);
    // }
    // // else if (str.indexOf("b") == 0) {
    // //   if (str.indexOf("ba") == 0) {
    // //
    // //     return CoreSound(coreSound: "ब", len: 2);
    // //   }
    // //   return CoreSound(coreSound: "ब", len: 1);
    // // }
    // else if (str.indexOf("sh") == 0) {
    //   //sh (aksara murda)
    //   return CoreSound(coreSound: "श", len: 2);
    // }
    //
    //
    // else if (str.indexOf("d") == 0) {
    // if (str.indexOf("dha") == 0) {
    // return CoreSound(coreSound: "ध", len: 3);
    // }
    //   return CoreSound(coreSound: "द", len: 1);
    // }
    // else if (str.indexOf("n") == 0) {
    //   return CoreSound(coreSound: "न", len: 1);
    // }
    // else if (str.indexOf("k") == 0) {
    //   return CoreSound(coreSound: "क", len: 1);
    // }
    // else if (str.indexOf("k") == 0) {
    //   return CoreSound(coreSound: "क", len: 1);
    // }
    // else if (str.indexOf("k") == 0) {
    //   return CoreSound(coreSound: "क", len: 1);
    // }
    // else if (str.indexOf("k") == 0) {
    //   return CoreSound(coreSound: "क", len: 1);
    // }
    // else if (str.indexOf("k") == 0) {
    //   return CoreSound(coreSound: "क", len: 1);
    // }
    // else if (str.indexOf("k") == 0) {
    //   return CoreSound(coreSound: "क", len: 1);
    // }
    // else if (str.indexOf("k") == 0) {
    //   return CoreSound(coreSound: "क", len: 1);
    // }
    // else if (str.indexOf("k") == 0) {
    //   return CoreSound(coreSound: "क", len: 1);
    // }
    // else if (str.indexOf("k") == 0) {
    //   return CoreSound(coreSound: "क", len: 1);
    // }
    // else if (str.indexOf("k") == 0) {
    //   return CoreSound(coreSound: "क", len: 1);
    // }
    // else if (str.indexOf("k") == 0) {
    //   return CoreSound(coreSound: "क", len: 1);
    // }
    // else if (str.indexOf("k") == 0) {
    //   return CoreSound(coreSound: "क", len: 1);
    // }
    //
    //
    // if (str.indexOf("s") == 0) {
    //   return CoreSound(coreSound: "स", len: 1);
    // }

    return CoreSound(coreSound: " ", len: 1);
  }


  CoreSound _getcoreSound(String str) {
    Map<String, String> hindiEnglish1 = {
      "A": "अ", //A
      "म्": "म्", //A
      "B": "ब", //B
      "C": "च", //C
      "D": "द", //D
      "E": "इ", //E
      "F": "फ", //F
      "G": "ग", //G
      "H": "ह", //H
      "I": "इ", //I
      "J": "ज", //J
      "K": "क", //K
      "Kh": "ख", //K
      "kh": "ख", //K
      "L": "ल", //L
      "M": "म", //M
      "N": "न", //N
      "O": "ओ", //O
      "P": "प", //P
      "Q": "क्यों ", //Q
      "R": "र", //R
      "S": "स", //S
      "T": "त", //T
      "U": "ऊ", //U
      "V": "व", //V
      "W": "व", //W
      "X": "ऎ", //X
      "Y": "य", //Y
      "Z": "ज", //Z
      "a": "ह", //a
      "b": "ब", //b
      "c": "च", //c
      "d": "द", //d
      "e": "ई", //e
      "f": "फ", //f
      "g": "ग", //g
      "h": "ह", //h
      "i": "इ", //i
      "j": "ज", //j
      "k": "क", //k
      "l": "ल", //l
      "m": "म", //m
      "n": "न", //n
      "o": "ओ", //o
      "p": "प", //p
      "q": "क्यों", //q
      "r": "र", //r
      "s": "स", //s
      "t": "त", //t
      "u": "उ", //u
      "v": "व", //v
      "w": "व", //w
      "x": "हऎ", //x
      "y": "य", //y
      "z": "ज", //z

    };

    var ftr = _getShift(str);
    var core = str;

    if (ftr.coreSound == " " ) {
      if (hindiEnglish1[str[0]] != null)
        core = "${hindiEnglish1[str[0]]}";
      return CoreSound(coreSound: core, len: 1);
    }
    else {
      return ftr;
    }
  }



  String _characterSound(String c) {
    var str = c;

     if (_isConsonant(str[0])) {
      return  _getcoreSound(str).coreSound ;
    } else {
      if (_isVowel(str[0])) {
      return  _getcoreSound(str).coreSound;
    }
    return "";
    }

  }



  String _getSound(String str) {      //MAIN GETSOUND==TOTAL WORDS +TOTAL SOUND

    if (str == " ") {
      return " ";
     }
    if (str.length == 1) {
      return _characterSound(str[0]);
    }
    else {
      CoreSound coreSound = _getcoreSound(str);
      var matra = "";
      var consonant = "";
      if (coreSound.len >= 1) {
        matra = _getMatra(str.substring(coreSound.len));

      }
      else {
        matra = "";
      }
    consonant = coreSound.coreSound;
       //these lines were
      return consonant  + matra;    //at end of if else
    }
  }


  String _transliterateEnglishToHindi(String str) {
  var i = 0;
  var ret = "";
  var j = 0;

  bool vowelFlag = false;

  var numbers = {
    "0": '०', //NUMBERS HAIN ENG TO HINDI
    "1": '१',
    "2": '२',
    "3": '३',
    "4": '४',
    "5": '५',
    "6": '६',
    "7": '७',
    "8": '८',
    "9": '९',
  };

  while (i < str.length) {





// print("getsound "+str.substring(j,i));
// print("getsound vowelFlag "+"$vowelFlag");
// print("getsound isVowel "+ _isVowel(str[i]).toString());
// print("getsound isPuntch "+ _isPunct(str[i]).toString());
// print("getsound isConsonant "+ _isConsonant(str[i]).toString());
// print("getsound j i "+ "$j"+" $i");

     if ((str[i] == ' ' && vowelFlag) ||
          (!_isVowel(str[i]) && i > 0) ||
          //(!_isConsonant(str[i]) && i>0)||
        (str[i] == '') ||
         _isPunct(str[i]) ||
        _isDigit(str[i]) ||
        ((i - j) > 5)) {


     if(j<i){
       // print("getsound "+str.substring(j,i));
       // print("getsound j i "+ "$j"+" $i");

       ret += _getSound(str.substring(j, i));
     j=i+1;}      //FOR HINDI WORDS



      if (_isPunct(str[i])) { //FOR PUNCTUATION AND SPECIAL CHARACTERS CHECKING
        if (str[i] == '.') {
          ret += ".";
          j = i + 1;
        } else if (str[i] == ',') {
          ret += ",";
          j = i + 1;
        } else if (str[i] == '|') {
          ret += "|";
          j = i + 1;
        } else if (str[i] == '(') {
          ret += "(";
          j = i + 1;
        } else if (str[i] == ')') {
          ret += ")";
          j = i + 1; // with zws
        } else if (str[i] == '-') {
          //tanda hubung
          ret += "-";
          j = i + 1;
        } else if (str[i] == '?') {
          ret += "?";
          j = i + 1; // with zws
        } else if (str[i] == '!') {
          ret += "!";
          j = i + 1; // with zws
        } else if (str[i] == '"') {
          ret += "\"";
          j = i + 1;
        } else if (str[i] == "\'") {
          ret += "\\'"; //NOT WORKING
          j = i + 1;
        } else {
          ret += str[i];
          j = i + 1;
        }
      }
      else if (_isDigit(str[i])) { //FOR DIGIT CHECKING

         ret += "${numbers[str[i]]}";
       // ret += "${hindiEnglish[str[i]]}";
        //numbersFlag = true;
        j = i + 1;
      }

      else {
        j = i;
      }
       vowelFlag=true;
    }

    i++;
  } //end while loop
  if (j < i) {
    // print("getsound outOfLoop "+str.substring(j,i));
    // print("getsound outOfLoop j i "+ "$j"+" $i");
    ret += _getSound(str.substring(j, i));
    j=i+1;
  }
  return ret;
}
}

class CoreSound {
  String coreSound;
  int len;

  CoreSound({
    required this.coreSound,
    required this.len,
  });
}
