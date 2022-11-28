import 'package:dylanapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'editStudent.dart';
import 'api.dart';

class StudentPage extends StatefulWidget {
  StudentPage({super.key, required this.courseName, required this.id});
  final String courseName;
  final String id;

  final StudentCoursesApi api = StudentCoursesApi();

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  List studentList = [];
  bool _dbLoaded = false;

  void initState() {
    super.initState();

    widget.api.getAllStudents().then((data) {
      setState(() {
        studentList = data;
        _dbLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 209, 171, 114),
      appBar: AppBar(
        title: Text(widget.courseName),
      ),
      body: Center(
          child: _dbLoaded
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: ElevatedButton(
                          onPressed: () => {
                                widget.api
                                    .deleteCourse(widget.id)
                                    .then((value) {
                                  Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MyHomePage(title: 'Home Page')));
                                })
                              },
                          child: Text("Delete This Course")),
                    ),
                    Expanded(
                      child: ListView(
                          shrinkWrap: true,
                          padding: EdgeInsets.all(15.0),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text("First Name",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        decoration: TextDecoration.underline)),
                                Text("Last Name",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        decoration: TextDecoration.underline)),
                                Text("Student ID",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        decoration: TextDecoration.underline)),
                                Text("         ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15))
                              ],
                            ),
                            ...studentList.map<Widget>((student) => Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(student["fname"],
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.black)),
                                    Text(student["lname"],
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.black)),
                                    Text(student["studentID"],
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.black)),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: ((context) =>
                                                      EditStudent(
                                                          student["_id"],
                                                          student["fname"],
                                                          widget.courseName,
                                                          widget.id))));
                                        },
                                        child: Text("Edit")),
                                  ],
                                ))
                          ]),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Database Loading",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    CircularProgressIndicator()
                  ],
                )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.home),
        onPressed: () => {
          Navigator.pop(context),
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyHomePage(
                        title: 'Home Page',
                      ))),
        },
        backgroundColor: Colors.brown,
      ),
    );
  }
}
