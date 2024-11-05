import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tp1/accueil.dart';
import 'package:tp1/service.dart';
import 'package:tp1/transfer.dart';
import 'navigationBar.dart';

class Creation extends StatefulWidget {
  const Creation({super.key});

  @override
  _CreationState createState() => _CreationState();
}

class _CreationState extends State<Creation> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  DateTime? _dueDate;
  bool _isLoading = false; // Track loading state

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
    if (_dueDate != null && _nameController.text.isNotEmpty) {
      AddTaskRequest req = AddTaskRequest();
      req.name = _nameController.text;
      req.deadline = _dueDate!;

      setState(() {
        _isLoading = true; // Start loading
      });

      try {
        final response = await postHttpAddTask(req);

        setState(() {
          _isLoading = false; // Stop loading
        });

        if (response != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Task added successfully!')),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Accueil()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to add task. Please try again.')),
          );
        }
      } catch (e) {
        setState(() {
          _isLoading = false; // Stop loading
        });

        if (e is DioError) {
          if (e.response != null && e.response?.data != null) {
            final responseBody = e.response?.data;
            if (responseBody is String) {
              final errorMessage = responseBody ?? 'Unknown error';
              if (errorMessage == "Empty") {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Le nom de la tâche est vide")),
                );
              } else if (errorMessage == "TooShort") {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Le nom de la tâche est trop court")),
                );
              } else if (errorMessage == "Existing") {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("La tâche existe déjà")),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Erreur dans la requête")),
                );
              }
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Erreur avec la communication du serveur.')),
            );
          }
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Accueil()),
          );
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez remplir tous les champs.')),
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
      body: Stack(
        children: [
          Padding(
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
                    child: const Text("Go back"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
          // Loading overlay
          if (_isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5), // Semi-transparent overlay
                child: const Center(
                  child: CircularProgressIndicator(), // Loading spinner
                ),
              ),
            ),
        ],
      ),
    );
  }
}
