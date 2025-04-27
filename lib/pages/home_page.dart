import 'dart:convert'; // for jsonEncode and jsonDecode

import 'package:Activity_List/utils/todo_title.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  //List toList = [];
  List<List<dynamic>> toList = [];

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  // Save to shared preferences
  void saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> stringList = toList.map((item) => jsonEncode(item)).toList();
    await prefs.setStringList('tasks', stringList);
  }

  // Load from shared preferences
  void loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? stringList = prefs.getStringList('tasks');
    if (stringList != null) {
      setState(() {
        toList =
            stringList
                .map((item) => List<dynamic>.from(jsonDecode(item)))
                .toList();
      });
    }
  }

  void newAdd() {
    setState(() {
      toList.add([_controller.text, false]);
      _controller.clear();
    });
    saveTasks();
  }

  void deleteTask(int index) {
    setState(() {
      toList.removeAt(index);
    });
    saveTasks();
  }

  void checkBoxChanged(int index) {
    setState(() {
      toList[index][1] = !toList[index][1];
    });
    saveTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent[100],
      appBar: AppBar(
        title: Text(
          'Activity List',
          style: TextStyle(fontFamily: 'Arizonia-Regular', fontSize: 30),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.tealAccent[400],
        foregroundColor: Colors.black,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(bottom: 100),
        itemCount: toList.length,
        itemBuilder: (BuildContext context, index) {
          return ToDolist(
            taskName: toList[index][0],
            isDone: toList[index][1],
            onChanged: (value) => checkBoxChanged(index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
      bottomSheet: Container(
        color: Colors.tealAccent[400],
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Expanded(
              // child: Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Add new activities here',
                  // isDense: true,
                  // contentPadding: EdgeInsets.symmetric(
                  //   vertical: 10,
                  //   horizontal: 15,
                  // ),
                  filled: true,
                  fillColor: Colors.white60,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            //),
            const SizedBox(width: 10),
            FloatingActionButton(
              onPressed: newAdd,
              child: Icon(Icons.add),
              backgroundColor: Colors.tealAccent[100],
              //mini: true,
            ),
          ],
        ),
      ),
    );
  }
}
