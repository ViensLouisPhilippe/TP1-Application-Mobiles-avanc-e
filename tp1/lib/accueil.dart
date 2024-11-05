import 'package:cached_network_image/cached_network_image.dart';
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


  List<HomeItemPhotoResponse> tasks = [];
  bool isLoading = true;
  bool isError = false;
  String errorMessage = "";
  Future<void> getTasks() async {
    setState(() {
      isLoading = true;
      isError = false;
    });
    try {
      tasks = await getHttpListPhoto();
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        isError = true;
        errorMessage = "erreur dans avec la communication du serveur veuillez réessayez.";
      });
    }
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
    if (isError) {
      return Scaffold(
        drawer: const NavBar(),
        appBar: AppBar(
          title: const Text('Liste de tâches'),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(errorMessage, style: TextStyle(color: Colors.red)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: getTasks,
                child: const Text("Réessayez"),
              ),
            ],
          ),
        ),
      );
    }
    if(tasks.isEmpty){
      return Scaffold(
        drawer: const NavBar(),
        appBar: AppBar(
          title: const Text('Liste de tâches'),
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
        title: const Text('Liste de tâches'),
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
        final HomeItemPhotoResponse task = tasks[index];

        return ListTile(
          title: Text(task.name),
          subtitle: Text(
              'Progress: ${task.percentageDone}% | Elapsed Time: ${task.percentageTimeSpent}%'),
          trailing: Text(DateFormat('yyyy-MM-dd').format(task.deadline)),

          // Conditionally display the image if photoId is not 0
          contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Consultation(id: task.id),
              ),
            );
          },
            leading: task.photoId != 0
                ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: CachedNetworkImage(
                imageUrl:
                "http://10.0.2.2:8080/file/${task.photoId}",
                placeholder: (context, url) =>
                const CircularProgressIndicator(), // While waiting for the image
                errorWidget: (context, url, error) =>
                const Icon(Icons.error), // Error handling
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            )
                : const SizedBox.shrink(),
        );
      },
    ),
    );
  }
}



//NOTE faire 'Flutter clean' avant la remise
