import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:tp1/transfer.dart';


class SingletonDio {
  static var cookiemanager = CookieManager(CookieJar());

  static Dio getDio() {
    Dio dio = Dio();
    dio.interceptors.add(cookiemanager);
    return dio;
  }
}


Future<TaskDetailResponse> getHttpDetailTask(int id) async{
  var response = await SingletonDio.getDio().get('http://10.0.2.2:8080/api/detail/$id');
  print(response);
  return TaskDetailResponse.fromJson(response.data);
}

Future<AddTaskRequest> postHttpAddTask(AddTaskRequest addTaskRequest) async{
  var response = await SingletonDio.getDio().post('http://10.0.2.2:8080/api/add', data: addTaskRequest.toJson());
  print(response);
  return AddTaskRequest.fromJson(response.data);
}

Future<List<HomeItemResponse>> getHttpList() async {

  List<HomeItemResponse> tasks = [];


  try {
    var response = await SingletonDio.getDio()
        .get('http://10.0.2.2:8080/api/home');
    print(response);
    var listJson = response.data as List;
    var listTask = listJson.map(
            (elementJSON) {
          return  HomeItemResponse.fromJson(elementJSON);
        }
    ).toList();
    tasks = listTask;
    return tasks;
  } catch (e) {
    print(e);
    rethrow;
  }
}


Future<SigninResponse> postHttpSignIn(SignupRequest signupResquest) async{
  try {
    var response = await SingletonDio.getDio()
        .post('http://10.0.2.2:8080/api/id/signin', data: signupResquest.toJson());
    print(response);
    MySingleton().setUsername(signupResquest.username);
    return SigninResponse.fromJson(response.data);
  } catch (e) {
    print(e);
    rethrow;
  }
}
Future<SigninResponse> postHttpSignUp(SignupRequest signupRequest) async{
  try {
    var response = await SingletonDio.getDio()
        .post('http://10.0.2.2:8080/api/id/signup', data: signupRequest.toJson());
    print(response);
    MySingleton().setUsername(signupRequest.username);
    return SigninResponse.fromJson(response.data);
  } catch (e) {
    print(e);
    rethrow;
  }
}
Future<void> postHttpSignout() async{
  try {
    var response = await SingletonDio.getDio()
        .post('http://10.0.2.2:8080/api/id/signout');
    print(response);
  } catch (e) {
    print(e);
    rethrow;
  }
}


Future<void> getHttpUpdateProgress(int id, int progress) async{
  try {
    var response = await SingletonDio.getDio()
        .get('http://10.0.2.2:8080/api/progress/$id/$progress');
    print(response);
  } catch (e) {
    print(e);
    rethrow;
  }
}

class MySingleton {
  MySingleton._();

  static final MySingleton _instance = MySingleton._();

  factory MySingleton() {
    return _instance;
  }

  String? username;

  void setUsername(String username) {
    this.username = username;
  }
}