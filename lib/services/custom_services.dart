import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomService {
  static void dismissKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
