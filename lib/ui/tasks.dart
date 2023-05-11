import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_flutter/data/repository/task_repo_impl.dart';
import '../data/model/task.dart';

class Tasks extends StatefulWidget {
  const Tasks({Key? key}) : super(key: key);

  @override
  State<Tasks> createState() => _TaskState();
}

class _TaskState extends State<Tasks> {
  var _title = "";
  var _titleError = "";
  var _desc = "";
  var _descError = "";
  var userId = 1;
  final repo = TaskRepoImpl();

  _onTitleChanged(value) {
    setState(() {
      _title = value;
    });
  }

  _onDescChanged(value) {
    setState(() {
      _desc = value;
    });
  }

  _onClickAdd() {
    setState(() {
      if (_title.isEmpty) {
        _titleError = "Title cannot be empty";
      } else {
        _titleError = "";
      }

      if (_desc.isEmpty) {
        _descError = "Description cannot be empty";
      } else {
        _descError = "";
      }

      if (_titleError == "" && _descError == "") {
        _onCreateTask(0, _title, _desc, userId);
        context.pop("true");
      }
    });
  }

  _onCreateTask(priority, title, desc, userId) async {
    var task =
        Task(priority: priority, title: title, desc: desc, userId: userId);
    await repo.createTask(task);
  }

  _onClickBack() {
    context.pop("Back from add task");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Task"),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: TextField(
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
                  onPressed: () => _onClickAdd(),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 18),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  child: const Text("Add", style: TextStyle(fontSize: 16))),
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
