import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'student_update.dart';

class StudentIndex extends StatefulWidget {
  const StudentIndex({Key? key}) : super(key: key);

  @override
  State<StudentIndex> createState() => _StudentIndexState();
}

class _StudentIndexState extends State<StudentIndex> {
  List students = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchStudents();
  }
// Fetch Function Work Start

  Future<void> fetchStudents() async {
    setState(() {
      isLoading = true;
    });

    try {
      String myurl = "http://localhost/apis/read.php";
      var response = await http.get(Uri.parse(myurl));
      if (response.statusCode == 200) {
        setState(() {
          students = jsonDecode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load students');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching students: $e');
    }
  }

// Fetch Function Work End

// Delete Function Work Start

  Future<void> deleteStd(String id) async {
    String myurl = "http://localhost/apis/delete.php";
    var result = await http.post(Uri.parse(myurl), body: {"id": id});
    var response = jsonDecode(result.body);
    if (response["success"] == "true") {
      print("Student Record Deleted Successfuly");
      fetchStudents();
    }
  }

  Future<void> confirmDelete(String id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete this student record?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                deleteStd(id);
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

// Delete Function Work End

// Update Function Work Start

// Update Function Work End

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      ListTile(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 30),
                        title: Text(
                          'Hello Aabhi!',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(color: Colors.white),
                        ),
                        subtitle: Text(
                          'Good Morning',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Colors.white54),
                        ),
                        trailing: const CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              AssetImage('assets/images/user.jpeg'),
                        ),
                      ),
                      const SizedBox(height: 30)
                    ],
                  ),
                ),
                Container(
                  color: Theme.of(context).primaryColor,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(100)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Student List",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton.filled(
                              onPressed: () {
                                Navigator.pushNamed(context, "/studentcreate");
                              },
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: students.length,
                          itemBuilder: (context, index) => Card(
                              child: ListTile(
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  AssetImage('assets/images/user.jpeg'),
                            ),
                            title: Text(students[index]['stdname']),
                            subtitle: Text(students[index]['stdcity']),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon:
                                      const Icon(Icons.remove_red_eye_outlined),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => StudentUpdate(
                                                  students[index]['id'],
                                                  students[index]['stdname'],
                                                  students[index]['stdage'],
                                                  students[index]['stdcity'],
                                                )));
                                  },
                                  icon: const Icon(
                                      Icons.mode_edit_outline_outlined),
                                ),
                                IconButton(
                                  onPressed: () {
                                    confirmDelete(students[index]['id']);
                                  },
                                  icon: const Icon(Icons.delete_outlined),
                                ),
                              ],
                            ),
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
