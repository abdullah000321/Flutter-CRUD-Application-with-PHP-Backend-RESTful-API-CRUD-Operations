import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StudentCreate extends StatefulWidget {
  const StudentCreate({Key? key}) : super(key: key);

  @override
  State<StudentCreate> createState() => _StudentCreateState();
}

// Define TextEditingController for student details
TextEditingController stdname = TextEditingController();
TextEditingController stdage = TextEditingController();
TextEditingController stdcity = TextEditingController();

Future<void> InsertData(BuildContext context) async {
  try {
    String myurl = "http://localhost/apis/create.php";
    var result = await http.post(Uri.parse(myurl),
        body: {"name": stdname.text, "age": stdage.text, "city": stdcity.text});

    if (result.statusCode == 200) {
      // If successful, show success message and clear text fields
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data inserted successfully')),
      );
      stdname.clear();
      stdage.clear();
      stdcity.clear();

      // Navigate to viewdata route after a short delay
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushNamed(context, "/studentindex");
      });
    } else {
      throw Exception('Failed to insert data');
    }
  } catch (e) {
    print('Error: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Failed to insert data')),
    );
  }
}

class _StudentCreateState extends State<StudentCreate> {
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
                        InsertData(context);
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
