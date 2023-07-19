

import 'package:flutter/material.dart';

/// this method will calculate the size of widgets by passing the size of
/// the component in the ui design and return the width of the component in the app.

double getWidth(double designWidth, context) {
  Size size = MediaQuery.of(context).size;
  return (designWidth*size.width)/1440;
}


/// return the height of the component
double getHeight(double designHeight, context) {
  Size size = MediaQuery.of(context).size;
  return (designHeight*size.height)/1024;
}