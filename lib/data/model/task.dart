import "package:flutter/cupertino.dart";

@immutable
class Task {
  static const tableName = "tasks";

  final int id;
  final int priority;
  final String title;
  final String desc;
  final int userId;

  const Task(
      {this.id = -1,
      required this.priority,
      required this.title,
      required this.desc,
      required this.userId});

  Task copy(
      {int? id, int? priority, String? title, String? desc, int? userId}) {
    return Task(
        id: id ?? this.id,
        priority: priority ?? this.priority,
        title: title ?? this.title,
        desc: desc ?? this.desc,
        userId: userId ?? this.userId);
  }

  @override
  String toString() {
    return "Task($id, $priority, $title, $desc, $userId)";
  }

  Map<String, dynamic> toMap() {
    return {
      "priority": priority,
      "title": title,
      "desc": desc,
      "fk_user_id": userId
    };
  }

  static Task fromMap(Map<String, dynamic> map) {
    return Task(
        id: map["id"],
        priority: map["priority"] ?? 0,
        title: map["title"],
        desc: map["desc"],
        userId: map["fk_user_id"] ?? 0);
  }
}
