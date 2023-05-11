import 'package:hello_flutter/data/database/db.dart';
import 'package:hello_flutter/data/repository/task_repo.dart';
import '../model/task.dart';

class TaskRepoImpl extends TaskRepo {
  static final TaskRepoImpl _instance = TaskRepoImpl._init();

  factory TaskRepoImpl() {
    return _instance;
  }

  TaskRepoImpl._init();

  var counter = 2;

  // final _tasks = {
  //   1: const Task(id: 1, title: "title", desc: "description"),
  //   2: const Task(id: 2, title: "title2", desc: "description2"),
  // };

  @override
  Future<List<Task>> getTasks() async {
    final res = await TaskDatabase.getTasks();
    return res.map((e) => Task.fromMap(e)).toList();
  }

  @override
  Future<Task?> getTask(int id) async {
    final res = await TaskDatabase.getTask(id);
    if (res.isEmpty) {
      return null;
    }
    return Task.fromMap(res[0]);
  }

  @override
  Future<bool> deleteTask(int id) async {
    await TaskDatabase.deleteTask(id);
    return true;
  }

  @override
  Future<bool> createTask(Task task) async {
    await TaskDatabase.createTask(task);
    return true;
    // _tasks[++counter] = task.copy(id: counter);
    // return true;
  }

  @override
  Future<bool> updateTask(Task task) async {
    await TaskDatabase.updateTask(task);
    return true;
  }

  @override
  Future<List<Task>> getTasksByUserId(int userId) async {
    final res = await TaskDatabase.getTasksByUserId(userId);
    return res.map((e) => Task.fromMap(e)).toList();
  }
}
