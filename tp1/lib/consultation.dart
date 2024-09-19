
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tp1/service.dart';
import 'package:tp1/transfer.dart';

import 'navigationBar.dart';

class Consultation extends StatefulWidget {
  final int id;

  const Consultation({required this.id});

  @override
    _ConsultationState createState() => _ConsultationState();


}

class _ConsultationState extends State<Consultation> {
  double _currentSliderValue = 0;
  TaskDetailResponse? task;

  getTask() async {
    task = await getHttpDetailTask(this.widget.id);
    setState(() {

    });
    _currentSliderValue = task!.percentageDone.toDouble();
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
            Text('Elapsed Time: ${task!.percentageTimeSpent}%', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Due Date: ${DateFormat('yyyy-MM-dd').format(task!.deadline)}', style: const TextStyle(fontSize: 18)),

            Slider(
              value: _currentSliderValue,
              max: 100,
              divisions: 100,
              label: _currentSliderValue.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _currentSliderValue = value;
                });
              },
            ),
            ElevatedButton(
              child : Text("Update Progress"),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
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
