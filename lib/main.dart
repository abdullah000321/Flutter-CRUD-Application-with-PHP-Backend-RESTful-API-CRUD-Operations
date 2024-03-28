import 'package:flutter/material.dart';

import 'screens/dashboard/dashboard.dart';
import 'screens/dashboard/student/student_create.dart';
import 'screens/dashboard/student/student_index.dart';

void main() {
  return runApp(MaterialApp(routes: {
    "/studentindex": (context) => StudentIndex(),
    "/studentcreate": (context) => StudentCreate(),
    // "/studentupdate": (context) => StudentUpdate(),
  }, debugShowCheckedModeBanner: false, home: const Dashboard()));
}
