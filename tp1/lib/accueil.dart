import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tp1/main.dart';
import 'package:tp1/service.dart';
import 'package:tp1/transfer.dart';

import 'consultation.dart';
import 'creation.dart';
import 'navigationBar.dart';


//PAGE ACCUEIL
class Accueil extends StatefulWidget {
  const Accueil({super.key});

  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {


  List<HomeItemResponse> tasks = [];
  bool isLoading = true;
  getTasks() async {
    tasks = await getHttpList();
    setState(() {
      isLoading = false;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTasks();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if(tasks.isEmpty){
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
                    builder: (context) => Creation(),
                  ),
                );
              },
            ),
          ],
        ),
        body: Center(
          child: Text("Vous n'avez pas de task on dirait"),
        ),
      );
    }
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
                  builder: (context) => Creation(),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final HomeItemResponse = tasks[index];
          return ListTile(
            title: Text(HomeItemResponse.name),
            subtitle: Text('Progress: ${HomeItemResponse.percentageDone}% | Elapsed Time: ${HomeItemResponse.percentageTimeSpent}%'),
            trailing: Text(DateFormat('yyyy-MM-dd').format(HomeItemResponse.deadline)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Consultation(id: HomeItemResponse.id),
                ),
              );
            },
          );
        },
      ),
    );
  }
}



//NOTE faire 'Flutter clean' avant la remise
