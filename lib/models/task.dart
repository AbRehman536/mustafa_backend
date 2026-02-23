// To parse this JSON data, do
//
//     final taskModel = taskModelFromJson(jsonString);

import 'dart:convert';

class TaskModel {
  final String? docId;
  final String? title;
  final String? description;
  final bool? isCompleted;
  final List<dynamic>? favortie;
  final int? createdAt;

  TaskModel({
    this.docId,
    this.title,
    this.description,
    this.isCompleted,
    this.favortie,
    this.createdAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
    docId: json["docId"],
    title: json["title"],
    description: json["description"],
    isCompleted: json["isCompleted"],
    favortie: json["favortie"] == null ? [] : List<dynamic>.from(json["favortie"]!.map((x) => x)),
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson(String taskID) => {
    "docId": taskID,
    "title": title,
    "description": description,
    "isCompleted": isCompleted,
    "createdAt": createdAt,
    "favortie": favortie == null ? [] : List<dynamic>.from(favortie!.map((x) => x)),
  };
}
