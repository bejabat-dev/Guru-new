import 'package:flutter/material.dart';

class Styles {
  InputDecoration normalInput(String title, Icon? icon) {
    var i = InputDecoration(labelText: title, prefixIcon: icon);
    return i;
  }

  InputDecoration dropDownInput(String title, Icon? icon) {
    var i = InputDecoration(
        labelText: title, prefixIcon: icon, fillColor: Colors.blue);
    return i;
  }

  InputDecoration errorInput(String title, Icon icon) {
    var i = InputDecoration(
        labelText: title,
        labelStyle: const TextStyle(color: Colors.red),
        prefixIcon: icon,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none));
    return i;
  }

  AppBar customAppBar(BuildContext context, String? title) {
    AppBar a = AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 18,
            color: Colors.black,
          )),
    );
    return a;
  }

  AppBar customAppBarWithoutLeading(BuildContext context, String title) {
    AppBar a = AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          title,
          style: const TextStyle(fontSize: 16),
        ));
    return a;
  }

  Text authText(String title) {
    Text t = Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
    return t;
  }

  Text authButtonText(String title) {
    Text t = Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
    );
    return t;
  }

  Text linkText(String title) {
    Text t = Text(
      title,
      style: const TextStyle(color: Colors.blue),
    );
    return t;
  }

  Text coloredText(String text, Color color) {
    Text t = Text(
      text,
      style: TextStyle(color: color),
    );
    return t;
  }
}
