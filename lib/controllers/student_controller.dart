import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StudentController {
  Future<void> insertData({
    required TextEditingController stdname,
    required TextEditingController stdage,
    required TextEditingController stdcity,
  }) async {
    try {
      String myurl = "http://localhost/06b/insert.php";
      var result = await http.post(
        Uri.parse(myurl),
        body: {
          "name": stdname.text,
          "age": stdage.text,
          "city": stdcity.text,
        },
      );

      jsonDecode(result.body);
    } catch (e) {}
  }
  
}
