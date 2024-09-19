//PAGE CREATION
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tp1/accueil.dart';
import 'package:tp1/service.dart';
import 'package:tp1/transfer.dart';

import 'navigationBar.dart';

class Creation extends StatefulWidget {
  //final Function(HomeItemResponse) onTaskCreated;

  const Creation({super.key /*, required this.onTaskCreated*/});

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

  Future<void> _submitTask() async {
    if (_dueDate != null) {

      AddTaskRequest req = AddTaskRequest();
      req.name = _nameController.text;
      req.deadline = _dueDate!;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Accueil(),
        ),
      );
      await postHttpAddTask(req);

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please pick a due date.')),
      );
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
              OutlinedButton(
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