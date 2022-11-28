import 'package:dylanapp/Models/appCourses.dart';
import 'package:dylanapp/editStudent.dart';
import 'package:flutter/material.dart';
import 'api.dart';
import 'studentPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Page',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final StudentCoursesApi api = StudentCoursesApi();
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List courseList = [];
  bool _dbLoaded = false;

  void initState() {
    super.initState();

    widget.api.getAllCourses().then((data) {
      setState(() {
        data.sort((a, b) => a["courseName"].compareTo(b["courseName"]));
        courseList = data;
        _dbLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 209, 171, 114),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: _dbLoaded
              ? Expanded(
                  child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(15.0),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text("Coures Name",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    decoration: TextDecoration.underline)),
                            Text("Coures Instructor",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    decoration: TextDecoration.underline)),
                            Text("Coures Credits",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    decoration: TextDecoration.underline))
                          ],
                        ),
                        ...courseList.map<Widget>((course) => TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => StudentPage(
                                          courseName: course["courseName"],
                                          id: course["_id"]))));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(course["courseName"],
                                    textAlign: TextAlign.center,
                                    style:
                                        const TextStyle(color: Colors.black)),
                                Text(course["courseInstructor"],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.black)),
                                Text(course["courseCredits"].toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.black))
                              ],
                            )))
                      ]),
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
    );
  }
}
