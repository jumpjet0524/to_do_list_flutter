import 'package:flutter/material.dart';

showHasInputDialog() {
  var widget = Center(
    child: Container(
      height: 40,
      width: double.infinity,
      child: Material(
        child: TextField(),
      ),
    ),
  );
}