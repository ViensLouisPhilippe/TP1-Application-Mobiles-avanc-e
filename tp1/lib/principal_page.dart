import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class PrincipalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Accueil(),
    );
  }
}

class Task {
  final String name;
  final double progress;
  final double elapsedTime;
  final DateTime dueDate;

  Task({
    required this.name,
    required this.progress,
    required this.elapsedTime,
    required this.dueDate,
  });
}

// PAGE ACCUEIL
class Accueil extends StatefulWidget {
  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  List<Task> tasks = [];

  void _addTask(Task task) {
    setState(() {
      tasks.add(task);
    });
  }

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
                MaterialPageRoute(
                  builder: (context) => Creation(
                    onTaskCreated: _addTask,
                  ),
                ),
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
            trailing: Text('${DateFormat('yyyy-MM-dd').format(task.dueDate)}'),
            onTap: () {
              //Eventuel bouton consultation
            },
          );
        },
      ),
    );
  }
}
//PAGE CREATION
class Creation extends StatefulWidget {
  final Function(Task) onTaskCreated;

  Creation({required this.onTaskCreated});

  @override
  _CreationState createState() => _CreationState();
}

class _CreationState extends State<Creation> {
  final _nameController = TextEditingController();
  DateTime? _dueDate;

  Future<void> _selectDueDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _dueDate) {
      setState(() {
        _dueDate = pickedDate;
      });
    }
  }

  void _submitTask() {
    if (_nameController.text.isNotEmpty && _dueDate != null) {
      final newTask = Task(
        name: _nameController.text,
        progress: 0,
        elapsedTime: 0,
        dueDate: _dueDate!,
      );
      widget.onTaskCreated(newTask);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Task Name'),
            ),
            SizedBox(height: 20),
            Text(
              _dueDate == null
                  ? 'Select Due Date'
                  : 'Due Date: ${DateFormat('yyyy-MM-dd').format(_dueDate!)}',
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _selectDueDate,
              child: Text('Pick a Date'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitTask,
              child: Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
}




