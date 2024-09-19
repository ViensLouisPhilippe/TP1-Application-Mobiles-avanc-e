import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tp1/transfer.dart';



final dio = Dio();

Future<TaskDetailResponse> getHttpDetailTask(int id) async{
  var response = await dio.get('http://10.0.2.2:8080/api/detail/$id');
  print(response);
  return TaskDetailResponse.fromJson(response.data);
}

Future<AddTaskRequest> postHttpAddTask(AddTaskRequest addTaskRequest) async{
  var response = await dio.post('http://10.0.2.2:8080/api/add', data: addTaskRequest.toJson());
  print(response);
  return AddTaskRequest.fromJson(response.data);
}

Future<List<HomeItemResponse>> getHttpList() async {

  List<HomeItemResponse> tasks = [];

  final response = await dio.get('http://10.0.2.2:8080/api/home');
  print(response);
  var listJson = response.data as List;
  var listTask = listJson.map(
          (elementJSON) {
        return  HomeItemResponse.fromJson(elementJSON);
      }
  ).toList();
  tasks = listTask;
  return tasks;
}


Future<SigninResponse> postHttpSignIn(SignupRequest signupResquest) async{

  var response = await dio.post('http://10.0.2.2:8080/api/id/signin', data: signupResquest.toJson());
  print(response);
  return SigninResponse.fromJson(response.data);
}
Future<SignupRequest> postHttpSignUp(SignupRequest signUpRequest) async{
  var response = await dio.post('http://10.0.2.2:8080/api/id/signup', data: signUpRequest.toJson());
  print(response);
  return SignupRequest.fromJson(response.data);
}