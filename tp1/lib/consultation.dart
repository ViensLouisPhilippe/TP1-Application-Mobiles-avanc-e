
import 'package:flutter/material.dart';

import 'navigationBar.dart';

class Consultation extends StatefulWidget {
  final Task task;

  const Consultation({super.key, required this.task});

}


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
}