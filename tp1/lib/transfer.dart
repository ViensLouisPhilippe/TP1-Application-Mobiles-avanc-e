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
  int percentageDone = 0;
  double percentageTimeSpent = 0.0;
  DateTime deadline = DateTime.now();
  // List<ProgressEvent> events = [];

  factory TaskDetailResponse.fromJson(Map<String, dynamic> json) => _$TaskDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TaskDetailResponseToJson(this);
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