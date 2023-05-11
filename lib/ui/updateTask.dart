import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_flutter/data/repository/task_repo_impl.dart';

import '../data/model/task.dart';

class UpdateTask extends StatefulWidget {
  final String taskId;

  const UpdateTask({Key? key, required this.taskId}) : super(key: key);

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  final _title = TextEditingController();
  final _desc = TextEditingController();
  String _titleError = "";
  String _descError = "";
  final repo = TaskRepoImpl();
  late int taskId;
  late int userId;

  @override
  void initState() {
    super.initState();
    refresh();
  }

  void refresh() async {
    taskId = int.parse(widget.taskId);
    final res = await repo.getTask(taskId);
    setState(() {
      if (res != null) {
        _title.text = res.title;
        _desc.text = res.desc;
        userId = res.userId;
      }
    });
  }

  _onTitleChanged(value) {
    setState(() {
      _title.text = value;
      _title.selection = TextSelection.collapsed(offset: _title.text.length);
    });
  }

  _onDescChanged(value) {
    setState(() {
      _desc.text = value;
      _desc.selection = TextSelection.collapsed(offset: _desc.text.length);
    });
  }

  _onClickUpdate(int id) {
    setState(() {
      if (_title.text.isEmpty) {
        _titleError = "Title cannot be empty";
      } else {
        _titleError = "";
      }

      if (_desc.text.isEmpty) {
        _descError = "Description cannot be empty";
      } else {
        _descError = "";
      }

      if (_titleError == "" && _descError == "") {
        _onUpdateTask(0, _title.text, _desc.text, userId);
        context.pop("true");
      }
    });
  }

  _onUpdateTask(priority, title, desc, userId) async {
    final task = Task(
        id: taskId,
        priority: priority,
        title: title,
        desc: desc,
        userId: userId);
    await repo.updateTask(task);
  }

  _onClickBack() {
    context.pop("Back from update task");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Task"),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: TextField(
                controller: _title,
                onChanged: (value) => _onTitleChanged(value),
                decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.abc_sharp),
                    hintText: "Title",
                    errorText: _titleError.isEmpty ? null : _titleError,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                keyboardType: TextInputType.name,
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: TextField(
                controller: _desc,
                onChanged: (value) => _onDescChanged(value),
                decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.abc_sharp),
                    hintText: "Description",
                    errorText: _descError.isEmpty ? null : _descError,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                keyboardType: TextInputType.name,
              ),
            ),
            const SizedBox(height: 15),
          ]),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () => _onClickUpdate(taskId),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 18),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  child: const Text("Update", style: TextStyle(fontSize: 16))),
              ElevatedButton(
                  onPressed: () => _onClickBack(),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 18),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  child: const Text("Back", style: TextStyle(fontSize: 16))),
            ],
          )
        ],
      ),
    );
  }
}
