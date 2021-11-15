### Phonetic typing

A phonetic hindi typing package with regular english keyboard on desktop and on phones.

<img src="https://user-images.githubusercontent.com/92981536/141763682-3ab95997-84a8-42c9-8571-0b63b2ffad0e.gif" alt="gif" width="250"/>


## Getting Started

Flutter project to transliterate english to hindi language.

## Features

Transliterates english words to hindi. For convenience suggestions are also added to the TextField.

## Features in example project:

It will automatically select and transliterate your typed word when spaceBar is pressed. As you type
words and don't select a suggestion it will automatically pick and replace first word of suggestion
as you hit spaceBar. You can create your own complex words by clicking on suggestions and appending
string with the last selected words. For eg. सामा +न्+य will give you सामान्य

## Installation

See the [installation instructions on pub](https://pub.dev/packages/transliterate/install)

## Use it as follows:

* `totalSuggestions` = `transliterate.suggestions(`
  `name:` `name,` `sugg:` `sugSelected`
  ); //This function will execute with a average time of 30ms.

  Where `totalSuggestions` will give you a list of suggestions,In which two parameters have to be
  passed i.e `name`(your TextField text or controller text)
  and `sugg` i.e the suggestion which user have selected.

* Or you can directly pass string to String abc=`transliterate.englishToHindi(String str);`

  It is recommended to use `totalSuggestions` as some of the words are difficult to transliterate so
  you can construct your own words.

* `isWord()` function is used to check last remained string which has not being transliterated(Words
  that are in english language).

## Material Example 1:


```dart
    onSuggsnSelected(suggestion) {
  print("On sug selected");
  sugSelected = suggestion.toString();
  String attch=transliterate.word(name);

  start=name.length-attch.length;
  end=name.length;

  inputController.text = name.replaceRange(start, end, sugSelected);
}
```
In this onSuggestionSelected method it will replace your english characters present at the end of
your controller WITH selected suggestion. word(name)-> is checking for the english characters
present at end of your TextField.
```dart
    suggsnCallBack(pattern) {

  if(name!=""){
    if(totalSuggestions.first!=""){
      sugFirst=totalSuggestions.first;
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
  totalSuggestions = transliterate.suggestions(
          name: name, sugg: sugSelected
  );

  return totalSuggestions;
}
```
In this suggestionsCallback method it will return you the desired list of suggestion, from which if
you found your word you can select it or click space or you can construct your own words by
selecting individual matras and halants of characters. In the starting sugFirst is a variable which
will be storing your first word of suggestion and totalSuggestions is list of your total
suggestions. Again it will check for the condition that if you click space without selecting any
word you will be given the first word of the list. isVC() func is checking if the last character of
the TextField is english or not.If it is it will replace your word and if it isn't it will stay as
it is.

At last name is the string of text that will be present in your textField or controller.
totalSuggestions will give us all the list of the suggestions for your last word typed.

For any other issue take reference from the example folder.

## Common Fixes
If desktop app is not rendering the hindi words properly
Insert a <script> tag in web/index.html file before the main.dart.js script.
Set window.flutterWebRenderer to "html":
```html
<script type="text/javascript">
    let useHtml = // ...
    if(useHtml) {
      window.flutterWebRenderer = "html";
    } else {
      window.flutterWebRenderer = "canvaskit";
    }
  </script>
<script src="main.dart.js" type="application/javascript"></script>
```
      
      
     
