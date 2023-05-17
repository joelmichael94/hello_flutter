import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_flutter/data/repository/task_repo_impl.dart';
import 'package:hello_flutter/service/auth_service.dart';

import '../../data/model/task.dart';

class FirstTab extends StatefulWidget {
  const FirstTab({Key? key}) : super(key: key);

  @override
  State<FirstTab> createState() => _FirstTabState();
}

class _FirstTabState extends State<FirstTab> {
  var _tasks = <Task>[];
  final repo = TaskRepoImpl();

  @override
  void initState() {
    super.initState();
    refresh();
  }

  void refresh() async {
    final user = await AuthService.getUser();
    if (user != null) {
      final res = await repo.getTasksByUserId(user.id);
      setState(() {
        _tasks = res;
      });
    }
  }

  _toAddTask() async {
    var res = await context.push('/tasks');
    if (res == "true") refresh();
  }

  void _deleteTask(int id) async {
    await repo.deleteTask(id);
    refresh();
  }

  _toUpdateTask(int id) async {
    var res = await context.push('/updateTask/$id');
    if (res == "true") {
      debugPrint("Update successful");
      refresh();
    } else {
      debugPrint("failed to update");
    }
  }

  Future<bool> _onConfirmDismiss(DismissDirection dir) async {
    if (dir == DismissDirection.endToStart) {
      return await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Confirm delete?"),
              content: const Text("Item will be deleted and cannot be undone"),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade700),
                    child: const Text("YES")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text("NO"))
              ],
            );
          });
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // ElevatedButton(
          //     onPressed: () => _onClickPersons(context),
          //     style: ElevatedButton.styleFrom(
          //       // minimumSize: const Size.fromHeight(50),
          //         backgroundColor: Colors.indigo,
          //         padding:
          //         const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          //         shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(15))),
          //     // style: const ButtonStyle(
          //     //     fixedSize: MaterialStatePropertyAll(Size.fromWidth(100))),
          //     child: const Text(
          //       "Persons",
          //       style: TextStyle(fontSize: 15),
          //     )),
          Expanded(
              // flex: 2,
              child: Container(
                  color: Colors.indigo,
                  width: double.infinity,
                  child: ListView.builder(
                      itemCount: _tasks.length,
                      itemBuilder: (context, index) {
                        final task = _tasks[index];
                        return Card(
                          color: Colors.blue.shade50,
                          margin: const EdgeInsets.all(8),
                          child: Dismissible(
                            key: Key(task.id.toString()),
                            onDismissed: (dir) {
                              _deleteTask(task.id);
                            },
                            secondaryBackground: Container(
                                color: Colors.green,
                                child: const Center(child: Text("Delete"))),
                            confirmDismiss: (dir) async {
                              return _onConfirmDismiss(dir);
                            },
                            background: Container(
                              color: Colors.red.shade600,
                              child: const Center(child: Text("Cannot Delete")),
                            ),
                            child: Container(
                              // width: double.infinity,
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 15),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Priority: ${task.priority}",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600)),
                                    const SizedBox(height: 5),
                                    Text("Title: ${task.title}",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600)),
                                    const SizedBox(height: 5),
                                    Text("Description: ${task.desc}",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w400)),
                                    // Text("Title: ${_persons[index].title}"),
                                    // Text("Age: ${_persons[index].age}"),
                                    const SizedBox(height: 5),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          // GestureDetector(
                                          //   onTap: () =>
                                          //       {_deleteTask(_tasks[index].id)},
                                          //   child: Icon(Icons.delete,
                                          //       color: Colors.red.shade700),
                                          // ),
                                          GestureDetector(
                                            onTap: () =>
                                                {_toUpdateTask(task.id)},
                                            child: Icon(Icons.draw_outlined,
                                                color: Colors.yellow.shade700),
                                          )
                                        ]),
                                  ]),
                            ),
                          ),
                        );
                      })
                  // child: ListView(children: const [
                  //   Align(
                  //     alignment: Alignment.center,
                  //     child: CustomText()
                  //   ),
                  //   SizedBox(height: 100),
                  //   Align(
                  //       alignment: Alignment.centerRight,
                  //       child: CustomText()
                  //   ),
                  //   SizedBox(height: 100),
                  // ])),
                  // Expanded(
                  //   flex: 1,
                  //     child: Container(
                  //         color: Colors.redAccent,
                  //         width: double.infinity,
                  //         child: const Text("Expanded Widget")))
                  )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _toAddTask(), child: const Icon(Icons.add)),
    );
  }
}
