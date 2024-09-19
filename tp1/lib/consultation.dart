
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tp1/service.dart';
import 'package:tp1/transfer.dart';

import 'navigationBar.dart';

class Consultation extends StatefulWidget {

  const Consultation({super.key});

  @override
    _ConsultationState createState() => _ConsultationState();


}

class _ConsultationState extends State<Consultation> {

  TaskDetailResponse? task;

  getTask() async {
    task = await getHttpDetailTask(0);
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTask();
  }
  
  @override
  Widget build(BuildContext context) {

    if(task == null) {
      return Scaffold(
          drawer: const NavBar(),
          appBar: AppBar(
            title: const Text('Task Details'),
          ),
          body: const Center(
            child: Text('Tes affaires s\'en viennent dude ou dudette'),
          )
      );
    }
    
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

            Text('Name: ${task!.name}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('Progress: ${task!.percentageDone}%', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Elapsed Time: ${task!.percentageTimeSpent}%', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Due Date: ${DateFormat('yyyy-MM-dd').format(task!.deadline)}', style: const TextStyle(fontSize: 18)),
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
