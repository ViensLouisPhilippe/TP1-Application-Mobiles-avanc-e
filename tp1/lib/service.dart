import 'package:dio/dio.dart';
import 'package:tp1/transfer.dart';



final dio = Dio();
HomeItemResponse itemResponse = HomeItemResponse();


void getHttpDetailTask(int id) async{
  var response = await dio.get('http://10.0.2.2:8080/api/detail/{id}', );



}

void addTask(int id) async{
  var response = await dio.get('http://10.0.2.2:8080/api/detail/{id}', );



}

void getHttpList() async {

  List<HomeItemResponse> tasks = [];

  final response = await dio.get('http://10.0.2.2:8080/api/home');
  print(response);
  var listJson = response.data as List;
  var listTask = listJson.map(
          (elementJSON) {
        return  itemResponse.fromJson(elementJSON);
      }
  ).toList();

}