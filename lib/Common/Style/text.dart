import 'package:flutter/material.dart';

class BoldNameText{
  static TextStyle boldNameTextFieldStyle(){
    return const TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w500,
      fontFamily: "Pacifico",
    );
  }

}

class BoldText{
  static TextStyle boldTextFieldStyle(){
    return const TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      fontFamily: "SourceSans3-VariableFont_wght.ttf",
    );
  }
}


class ItalicText{
  static TextStyle italicTextFieldStyle(){
    return const TextStyle(
      color: Colors.black45,
      fontFamily: "SourceSans3-Italic-VariableFont_wght.ttf",
    );
  }
}


class TitleText{
  static TextStyle titleTextFieldStyle(){
    return const TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontFamily: "SourceSans3-VariableFont_wght.ttf",
    );
  }
}

class SubTitleText{
  static TextStyle subTitleTextFieldStyle(){
    return const TextStyle(
      color: Colors.black45,
      fontFamily: "SourceSans3-Italic-VariableFont_wght.ttf",
    );
  }
}
