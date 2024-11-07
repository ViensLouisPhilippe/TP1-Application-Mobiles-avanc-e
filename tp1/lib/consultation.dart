import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
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
  TaskDetailPhotoResponse? task;
  String imageURL = "";
  Cookie? cookie;
  bool isLoading = true;
  bool _isUploading = false;

  getTask() async {
    task = await getHttpDetailTaskPhoto(widget.id);
    setState(() {
      isLoading = false;
      _currentSliderValue = task!.percentageDone.toDouble();
    });
  }

  void getImageAndSend() async {
    final ImagePicker picker = ImagePicker();

    setState(() {
      _isUploading = true;
    });

    final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(pickedImage.path, filename: pickedImage.name),
        "taskID": widget.id
      });

      try {
        String id = await postPhotoFile(formData);

        imageURL = "http://10.0.2.2:8080/file/$id";
        List<Cookie> cookies = await SingletonDio.cookiemanager.cookieJar.loadForRequest(Uri.parse(imageURL));
        if (cookies.isNotEmpty) {
          cookie = cookies.first;
        }

        await getTask();
      } catch (e) {
        print("Error uploading image: $e");
      } finally {
        setState(() {
          _isUploading = false;
        });
      }
    }
  }

  void hardDeleteTask(int id) async {
    setState(() {
      _isUploading = true;
    });

    await hardDelete(widget.id);

    setState(() {
      _isUploading = false;
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Accueil()),
    );
  }

  void updateProgress() async {
    setState(() {
      _isUploading = true;
    });

    try {
      task!.percentageDone = _currentSliderValue;
      await getHttpUpdateProgress(task!.id, task!.percentageDone.toInt());
      await getTask();
    } catch (e) {
      print("Error updating progress: $e");
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getTask();
  }

  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      await getTask();
    }
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

    if (task != null && !isLoading) {
      return Scaffold(
        drawer: const NavBar(),
        appBar: AppBar(
          title: const Text('Task Details'),
        ),
        body: Stack(
          children: [
            Padding(
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
                  if (task!.photoId != 0)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: CachedNetworkImage(
                        imageUrl: "http://10.0.2.2:8080/file/${task!.photoId}",
                        placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),

                  ElevatedButton(
                    child : Text("Update Progress"),
                    onPressed: () async {
                      updateProgress();
                    },
                  ),
                  ElevatedButton(
                      child: Text("Upload Image"),
                      onPressed : () async{
                        getImageAndSend();
                      }
                  ),
                  ElevatedButton(
                    child : Text("Go Back"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Accueil()),
                      );
                    },
                  ),
                  ElevatedButton(
                    child : Text("Hard Delete"),
                    onPressed: () async {
                      hardDeleteTask(task!.id);
                    },
                  ),
                ],
              ),
            ),

            if (_isUploading)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
          ],
        ),
      );
    } else {
      return Scaffold(
        drawer: const NavBar(),
        appBar: AppBar(
          title: const Text('Task Details'),
        ),
        body: const Center(
          child: Text("Task not found. Please try again."),
        ),
      );
    }
  }
}
