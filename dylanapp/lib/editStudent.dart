import 'package:dylanapp/studentPage.dart';
import 'package:flutter/material.dart';
import 'api.dart';
import 'main.dart';

class EditStudent extends StatefulWidget {
  final String id, fname;
  final String courseName, courseID;

  final StudentCoursesApi api = StudentCoursesApi();

  EditStudent(this.id, this.fname, this.courseName, this.courseID);

  @override
  _EditStudentState createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  void _changeStudentName(id, fname) {
    setState(() {
      widget.api.changeFname(id, fname).then((value) {
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => StudentPage(
                    courseName: widget.courseName, id: widget.courseID)));
      });
    });
  }

  TextEditingController fnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 209, 171, 114),
      appBar: AppBar(
        title: Text(widget.fname),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Text(
                  "Change Name for " + widget.fname,
                  style: const TextStyle(
                      fontSize: 20, decoration: TextDecoration.underline),
                ),
                TextFormField(
                  controller: fnameController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                ElevatedButton(
                  onPressed: () => {
                    _changeStudentName(widget.id, fnameController.text),
                  },
                  child: Text("Change First Name"),
                )
              ],
            ),
          )
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
