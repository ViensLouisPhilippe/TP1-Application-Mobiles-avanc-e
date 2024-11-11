import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:tp1/transfer.dart';
import 'package:path_provider/path_provider.dart';

class SingletonDio {
  static PersistCookieJar? _cookieJar;
  static var cookiemanager = CookieManager(CookieJar());
  static Dio? _dio;

  static Future<void> init() async {
    // Initialiser _cookieJar s'il est null
    if (_cookieJar == null) {
      Directory tempDir = await getApplicationDocumentsDirectory();
      String cookiePath = tempDir.path + "/cookies"; // Chemin pour stocker les cookies
      _cookieJar = PersistCookieJar(
        storage: FileStorage(cookiePath),
      );
    }

    // Initialiser _dio s'il est null
    if (_dio == null) {
      _dio = Dio();
      _dio!.interceptors.add(CookieManager(_cookieJar!)); // Ajout du CookieManager pour gérer les cookies
    }
  }

  // Retourner une instance Dio avec les cookies
  static Future<Dio> getDio() async {
    // Assure-toi que Dio et CookieJar sont initialisés
    await init();
    return _dio!; // Retourner l'instance Dio initialisée
  }

  // Vérifie s'il y a une session active en vérifiant les cookies
  static Future<bool> hasActiveSession() async {
    // Assure-toi que Dio et CookieJar sont initialisés avant de vérifier les cookies
    await init();
    List<Cookie> cookies = await _cookieJar!.loadForRequest(Uri.parse('http://10.0.2.2:8080'));
    return cookies.isNotEmpty;
  }

  // Méthode pour récupérer les cookies (initialisation ou réinitialisation)
  static Future<void> getCookie() async {
    await init(); // Assure-toi que CookieJar et Dio sont initialisés
  }

  static Future<void> deleteCookie() async{
    try {
      // Assure que l'initialisation a eu lieu
      await init();

      // Supprime tous les cookies stockés
      await _cookieJar!.deleteAll();

      print('Cookies deleted successfully');
    } catch (e) {
      print('Error deleting cookies: $e');
    }
  }
}


Future<TaskDetailResponse> getHttpDetailTask(int id) async {
  var dio = await SingletonDio.getDio(); // Await the future to get Dio instance
  var response = await dio.get('http://10.0.2.2:8080/api/detail/$id'); // Send GET request
  print(response);
  return TaskDetailResponse.fromJson(response.data);
}

Future<AddTaskRequest> postHttpAddTask(AddTaskRequest addTaskRequest) async {
  var dio = await SingletonDio.getDio(); // Await the future to get Dio instance
  var response = await dio.post(
    'http://10.0.2.2:8080/api/add',
    data: addTaskRequest.toJson(), // Send POST request with data
  );
  print(response);
  return AddTaskRequest.fromJson(response.data);
}

Future<List<HomeItemResponse>> getHttpList() async {
  List<HomeItemResponse> tasks = [];
  try {
    var dio = await SingletonDio.getDio(); // Await the future to get Dio instance
    var response = await dio.get('http://10.0.2.2:8080/api/home'); // Send GET request
    print(response);
    var listJson = response.data as List;
    var listTask = listJson.map(
          (elementJSON) {
        return HomeItemResponse.fromJson(elementJSON); // Map each element to model
      },
    ).toList();
    tasks = listTask;
    return tasks;
  } catch (e) {
    print(e);
    rethrow;
  }
}

Future<SigninResponse> postHttpSignIn(SignupRequest signupRequest) async {
  try {
    var dio = await SingletonDio.getDio(); // Await the future to get Dio instance
    var response = await dio.post(
      'http://10.0.2.2:8080/api/id/signin',
      data: signupRequest.toJson(), // Send POST request with data
    );
    print(response);
    MySingleton().setUsername(signupRequest.username);
    return SigninResponse.fromJson(response.data);
  } catch (e) {
    print(e);
    rethrow;
  }
}

Future<SigninResponse> postHttpSignUp(SignupRequest signupRequest) async {
  try {
    var dio = await SingletonDio.getDio(); // Await the future to get Dio instance
    var response = await dio.post(
      'http://10.0.2.2:8080/api/id/signup',
      data: signupRequest.toJson(), // Send POST request with data
    );
    print(response);
    MySingleton().setUsername(signupRequest.username);
    return SigninResponse.fromJson(response.data);
  } catch (e) {
    print(e);
    rethrow;
  }
}

Future<void> postHttpSignout() async {
  try {
    var dio = await SingletonDio.getDio(); // Await the future to get Dio instance
    var response = await dio.post('http://10.0.2.2:8080/api/id/signout'); // Send POST request
    print(response);
    await SingletonDio.deleteCookie();
  } catch (e) {
    print(e);
    rethrow;
  }
}

Future<void> getHttpUpdateProgress(int id, int progress) async {
  try {
    var dio = await SingletonDio.getDio(); // Await the future to get Dio instance
    var response = await dio.get('http://10.0.2.2:8080/api/progress/$id/$progress'); // Send GET request
    print(response);
  } catch (e) {
    print(e);
    rethrow;
  }
}

Future<void> hardDelete(int id) async {
  try {
    var dio = await SingletonDio.getDio(); // Await the future to get Dio instance
    var response = await dio.delete('http://10.0.2.2:8080/api/task/hard/$id'); // Send DELETE request
    print(response);
  } catch (e) {
    print(e);
    rethrow;
  }
}

Future<String> postPhotoFile(FormData formData) async {
  try {
    var dio = await SingletonDio.getDio(); // Await the future to get Dio instance
    var response = await dio.post(
      'http://10.0.2.2:8080/file',
      data: formData, // Send POST request with form data
    );
    return response.data as String;
  } catch (e) {
    print(e);
    rethrow;
  }
}

Future<TaskDetailPhotoResponse> getHttpDetailTaskPhoto(int id) async {
  var dio = await SingletonDio.getDio(); // Await the future to get Dio instance
  var response = await dio.get('http://10.0.2.2:8080/api/detail/photo/$id'); // Send GET request
  print(response);
  return TaskDetailPhotoResponse.fromJson(response.data);
}

Future<List<HomeItemPhotoResponse>> getHttpListPhoto() async {
  List<HomeItemPhotoResponse> tasks = [];
  try {
    var dio = await SingletonDio.getDio(); // Await the future to get Dio instance
    var response = await dio.get('http://10.0.2.2:8080/api/home/photo'); // Send GET request
    print(response);
    var listJson = response.data as List;
    var listTask = listJson.map(
          (elementJSON) {
        return HomeItemPhotoResponse.fromJson(elementJSON); // Map each element to model
      },
    ).toList();
    tasks = listTask;
    return tasks;
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
