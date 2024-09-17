import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tp1/main.dart';
import 'package:tp1/transfer.dart';

import 'consultation.dart';
import 'creation.dart';
import 'navigationBar.dart';



/*
class PrincipalPage extends StatelessWidget {
  const PrincipalPage({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Accueil(),
        '/creation': (context) => Creation(onTaskCreated: (task) {}),
        '/main': (context) => const MyApp(),
      },
    );
  }
}
*/

/*class Task {
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
}*/




//PAGE ACCUEIL
class Accueil extends StatefulWidget {
  const Accueil({super.key});

  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {


  List<HomeItemResponse> tasks = [];

  void _addTask(HomeItemResponse task) {
    setState(() {
      tasks.add(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        title: const Text('Task List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
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
            trailing: Text(DateFormat('yyyy-MM-dd').format(task.dueDate)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Consultation(task: task),
                ),
              );
            },
          );
        },
      ),
    );
  }
}


/*class Creation extends StatefulWidget {
  final Function(Task) onTaskCreated;

  const Creation({super.key, required this.onTaskCreated});

  @override
  _CreationState createState() => _CreationState();
}

class _CreationState extends State<Creation> {
  final _formKey = GlobalKey<FormState>();
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
    if (_formKey.currentState?.validate() ?? false) {
      if (_dueDate != null) {
        final newTask = Task(
          name: _nameController.text,
          progress: 0,
          elapsedTime: 0,
          dueDate: _dueDate!,
        );
        widget.onTaskCreated(newTask);
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please pick a due date.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        title: const Text('Create Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Task Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a task name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Text(
                _dueDate == null
                    ? 'Select Due Date'
                    : 'Due Date: ${DateFormat('yyyy-MM-dd').format(_dueDate!)}',
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _selectDueDate,
                child: const Text('Pick a Date'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitTask,
                child: const Text('Add Task'),
              ),
              ElevatedButton(
                child : const Text("Go back"),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


//PAGE CONSULTATION
class Consultation extends StatelessWidget {
  final Task task;

  const Consultation({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        title: const Text('Task Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${task.name}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('Progress: ${task.progress}%', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Elapsed Time: ${task.elapsedTime}%', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Due Date: ${DateFormat('yyyy-MM-dd').format(task.dueDate)}', style: const TextStyle(fontSize: 18)),
            ElevatedButton(
              child : Text("Go back"),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}*/



//NOTE faire 'Flutter clean' avant la remise
