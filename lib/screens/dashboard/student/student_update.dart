import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../utils/utils.dart';

class StudentUpdate extends StatefulWidget {
  String id;
  String stdname;
  String stdage;
  String stdcity;

  StudentUpdate(
    this.id,
    this.stdname,
    this.stdage,
    this.stdcity,
  );

  @override
  State<StudentUpdate> createState() => _StudentUpdateState();
}

class _StudentUpdateState extends State<StudentUpdate> {
  // Define TextEditingController for student details
  TextEditingController id = TextEditingController();
  TextEditingController stdname = TextEditingController();
  TextEditingController stdage = TextEditingController();
  TextEditingController stdcity = TextEditingController();

  @override
  void initState() {
    id.text = widget.id;
    stdname.text = widget.stdname;
    stdage.text = widget.stdage;
    stdcity.text = widget.stdcity;
    super.initState();
  }

  Future<void> UpdateData() async {
    try {
      String url = "http://localhost/apis/update.php";
      var res = await http.post(Uri.parse(url), body: {
        "id": id.text,
        "name": stdname.text,
        "age": stdage.text,
        "city": stdcity.text,
      });
      var response = jsonDecode(res.body);
      if (response["success"] == "true") {
        Utils().toastMessage('Data Updated successfully');
      } else {
        print("some issue");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
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
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  title: Text('Hello Aabhi!',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: Colors.white)),
                  subtitle: Text('Good Morning',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.white54)),
                  trailing: const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/user.jpeg'),
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
                        BorderRadius.only(topLeft: Radius.circular(100))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Add Student",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton.filled(
                          onPressed: () {
                            Navigator.pushNamed(context, "/studentindex");
                          },
                          icon: const Icon(Icons.list),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    // TextFormField(
                    //   controller: id,
                    //   enabled: false,
                    //   decoration: const InputDecoration(
                    //       labelText: "Enter Your id",
                    //       border: OutlineInputBorder(
                    //           borderSide: BorderSide(width: 2),
                    //           borderRadius:
                    //               BorderRadius.all(Radius.circular(15)))),
                    // ),
                    // const SizedBox(
                    //   height: 25,
                    // ),
                    TextFormField(
                      controller: stdname,
                      decoration: const InputDecoration(
                          labelText: "Enter Your name",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)))),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      controller: stdage,
                      decoration: const InputDecoration(
                          labelText: "Enter Your age",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)))),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      controller: stdcity,
                      decoration: const InputDecoration(
                          labelText: "Enter Your City",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)))),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        UpdateData();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      child: const Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white, // Text color
                        ),
                      ),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
