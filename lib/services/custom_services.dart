import 'package:flutter/material.dart';

class CustomService {
  static void dismissKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
