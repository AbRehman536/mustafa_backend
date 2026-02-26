// To parse this JSON data, do
//
//     final taskModel = taskModelFromJson(jsonString);

import 'dart:convert';

class TaskModel {
  final String? docId;
  final String? title;
  final String? description;
  final String? priorityID;
  final String? userID;
  final bool? isCompleted;
  final List<dynamic>? favortie;
  final int? createdAt;

  TaskModel({
    this.docId,
    this.title,
    this.description,
    this.isCompleted,
    this.priorityID,
    this.userID,
    this.favortie,
    this.createdAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
    docId: json["docId"],
    title: json["title"],
    description: json["description"],
    isCompleted: json["isCompleted"],
    userID: json["userID"],
    priorityID: json["priorityID"],
    favortie: json["favortie"] == null ? [] : List<dynamic>.from(json["favortie"]!.map((x) => x)),
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson(String taskID) => {
    "docId": taskID,
    "title": title,
    "description": description,
    "priorityID": priorityID,
    "userID": userID,
    "isCompleted": isCompleted,
    "createdAt": createdAt,
    "favortie": favortie == null ? [] : List<dynamic>.from(favortie!.map((x) => x)),
  };
}
