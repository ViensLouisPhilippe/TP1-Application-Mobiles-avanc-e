/*class HttpTask {
  final String name;
  final double progress;
  final double elapsedTime;
  final DateTime dueDate;

  HttpTask(this.name, this.progress, this.elapsedTime, this.dueDate);

  HttpTask.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        progress = (json['progress'] as num).toDouble(),
        elapsedTime = (json['elapsedTime'] as num).toDouble(),
        dueDate = DateTime.parse(json['dueDate'] as String);

  Map<String, dynamic> toJson() => {
    'name': name,
    'progress': progress,
    'elapsedTime': elapsedTime,
    'dueDate': dueDate.toIso8601String(),
  };
}*/

import 'package:json_annotation/json_annotation.dart';

part 'transfer.g.dart';

@JsonSerializable()
class HomeItemResponse {
  HomeItemResponse();

  int id = 0;
  String name = '';
  int percentageDone = 0;
  double percentageTimeSpent = 0.0;
  DateTime deadline = DateTime.now();

  factory HomeItemResponse.fromJson(Map<String, dynamic> json) => _$HomeItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeItemResponseToJson(this);
}

@JsonSerializable()
class TaskDetailResponse {
  TaskDetailResponse();

  int id = 0;
  String name = '';
  double percentageDone = 0;
  double percentageTimeSpent = 0.0;
  DateTime deadline = DateTime.now();
  // List<ProgressEvent> events = [];

  factory TaskDetailResponse.fromJson(Map<String, dynamic> json) => _$TaskDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TaskDetailResponseToJson(this);
}
@JsonSerializable()
class AddTaskRequest {
  AddTaskRequest();
  String name = '';
  DateTime deadline = DateTime.now();
  factory AddTaskRequest.fromJson(Map<String, dynamic> json) => _$AddTaskRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddTaskRequestToJson(this);
}

@JsonSerializable()
class SignupRequest {
  SignupRequest();
  String username = '';
  String password = '';
  factory SignupRequest.fromJson(Map<String, dynamic> json) => _$SignupRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignupRequestToJson(this);
  }

@JsonSerializable()
class SigninResponse {
  SigninResponse();

  String username = '';
  factory SigninResponse.fromJson(Map<String, dynamic> json) => _$SigninResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SigninResponseToJson(this);
}

@JsonSerializable()
class SigninRequest {
  SigninRequest();

  String username = '';
  String password = '';
  factory SigninRequest.fromJson(Map<String, dynamic> json) => _$SigninRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SigninRequestToJson(this);
}

@JsonSerializable()
class TaskDetailPhotoResponse  {
  TaskDetailPhotoResponse ();

  int id = 0;
  String name = '';
  double percentageDone = 0;
  double percentageTimeSpent = 0.0;
  DateTime deadline = DateTime.now();
  int photoId = 0;
  factory TaskDetailPhotoResponse.fromJson(Map<String, dynamic> json) => _$TaskDetailPhotoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TaskDetailPhotoResponseToJson(this);
}
@JsonSerializable()
class HomeItemPhotoResponse  {
  HomeItemPhotoResponse ();

  int id = 0;
  String name = '';
  double percentageDone = 0;
  double percentageTimeSpent = 0.0;
  DateTime deadline = DateTime.now();
  int photoId = 0;
  factory HomeItemPhotoResponse.fromJson(Map<String, dynamic> json) => _$HomeItemPhotoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeItemPhotoResponseToJson(this);
}
