import 'package:flutter/material.dart';

import 'creation.dart';


class Accueil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskListScreen(),
    );
  }
}

class Task {
  final String name;
  final double progress; // Progress in percentage
  final double elapsedTime; // Elapsed time in percentage
  final DateTime dueDate;

  Task({
    required this.name,
    required this.progress,
    required this.elapsedTime,
    required this.dueDate,
  });
}

class TaskListScreen extends StatelessWidget {
  final List<Task> tasks = [
    Task(name: "Task 1", progress: 40, elapsedTime: 50, dueDate: DateTime(2024, 10, 15)),
    Task(name: "Task 2", progress: 70, elapsedTime: 30, dueDate: DateTime(2024, 10, 25)),
    // Add more tasks as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Creation()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            title: Text(task.name),
            subtitle: Text('Progress: ${task.progress}% | Elapsed Time: ${task.elapsedTime}%'),
            trailing: Text('${task.dueDate.toLocal()}'),
            onTap: () {
              // Navigator.push(
              //   context,
              //   //MaterialPageRoute(
              //     //builder: (context) => Consultation(task: task),
              //   ),
              // );
            },
          );
        },
      ),
    );
  }
}


