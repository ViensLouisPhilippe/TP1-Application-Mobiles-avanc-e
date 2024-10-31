
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:tp1/service.dart';
import 'package:tp1/transfer.dart';

import 'accueil.dart';
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
  String imageURL = "";
  Cookie? cookie;
  bool isLoading = true;

  getTask() async {
    task = await getHttpDetailTask(widget.id);
    setState(() {
      isLoading = false;
      _currentSliderValue = task!.percentageDone.toDouble();
    });
  }

  void getImageAndSend() async {
    final ImagePicker picker = ImagePicker();

    final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(pickedImage.path, filename: pickedImage.name),
        "taskID" : widget.id
      });
      String id = await postPhotoFile(formData);

      imageURL = "http://10.0.2.2:8080/file/$id";

      List<Cookie> cookies = await SingletonDio.cookiemanager.cookieJar
          .loadForRequest(Uri.parse(imageURL));
      cookie = cookies.first;

      setState(() {});
    }
  }

  void hardDeleteTask(int id) async{

    await hardDelete(widget.id);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Accueil(),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTask();
  }
  
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        drawer: const NavBar(),
        appBar: AppBar(
          title: const Text('Task Details'),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if(task != null && !isLoading){
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
                onPressed: () async {
                  try{
                    task!.percentageDone = _currentSliderValue;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Accueil(),
                      ),
                    );
                    await getHttpUpdateProgress(task!.id, task!.percentageDone.toInt());
                  }on DioException catch (e) {
                    print(e);
                  }
                },
              ),
              ElevatedButton(
                  child: Text("upload image"),
                  onPressed : () async{
                    getImageAndSend();
                  }
              ),
              ElevatedButton(
                child : Text("Go back"),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Accueil(),
                    ),
                  );
                },
              ),
              ElevatedButton(
                child : Text("Hard delete"),
                onPressed: () async {
                  try{
                    hardDeleteTask(task!.id);
                  }on DioException catch (e) {
                    print(e);
                  }
                },
              ),
            ],
          ),
        ),
      );
    }
    else{
      return Scaffold(
        drawer: const NavBar(),
        appBar: AppBar(
          title: const Text('Task Details'),
        ),
        body: const Center(
          child: Text("Votre task est introuvable veuiller réessayez"),
        ),
      );
    }

  }
}
