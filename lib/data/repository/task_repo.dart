import '../model/task.dart';

abstract class TaskRepo {
  Future<List<Task>> getTasks();

  Future<List<Task>> getTasksByUserId(int userId);

  Future<Task?> getTask(int id);

  Future<bool> deleteTask(int id);

  Future<bool> createTask(Task task);

  Future<bool> updateTask(Task task);
}
