import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lang_app/screen/test/test_page.dart';
import 'package:lang_app/screen/themes.dart';

void main(){
  runApp(MaterialApp(
      home: Scaffold(body: TestPage(options: const["ONE", "TWO",  "FOUR"], right: 1,callback: (right)=> log(right.toString()))),
      theme: AppTheme().light,
    ));
}

