import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:hello_flutter/ui/add_product.dart";
import "package:hello_flutter/ui/food.dart";
import "package:hello_flutter/ui/home.dart";
import "package:hello_flutter/ui/login.dart";
import "package:hello_flutter/ui/profile.dart";
import "package:hello_flutter/ui/register.dart";
import "package:hello_flutter/ui/scene.dart";
import "package:hello_flutter/ui/tasks.dart";
import "package:hello_flutter/ui/updateTask.dart";
import "package:hello_flutter/ui/update_product.dart";

class MyApp extends StatelessWidget {
  MyApp({Key? key, required this.initialRoute}) : super(key: key);

  final String initialRoute;

  final _routes = [
    GoRoute(path: "/login", builder: (context, state) => const Login()),
    GoRoute(
        path: "/home", name: "home", builder: (context, state) => const Home()),
    GoRoute(
        path: "/register",
        name: "register",
        builder: (context, state) => const Register()),
    GoRoute(
        path: "/tasks",
        name: "tasks",
        builder: (context, state) => const Tasks()),
    GoRoute(
        path: "/scene",
        name: "scene",
        builder: (context, state) => const Scene()),
    GoRoute(
        path: "/food", name: "food", builder: (context, state) => const Food()),
    GoRoute(
        path: "/updateTask/:taskId",
        name: "updateTask",
        builder: (context, state) =>
            UpdateTask(taskId: state.pathParameters["taskId"] ?? "")),
    GoRoute(
        path: "/profile",
        name: "profile",
        builder: (context, state) => const Profile()),
    GoRoute(
        path: "/addProduct",
        name: "addProduct",
        builder: (context, state) => const AddProduct()),
    GoRoute(
        path: "/updateProduct/:productId",
        name: "updateProduct",
        builder: (context, state) =>
            UpdateProduct(productId: state.pathParameters["productId"] ?? "")),
  ];

  // final _router = GoRouter(initialLocation: "/", routes: [
  //   GoRoute(path: "/", builder: (context, state) => const Login()),
  //   GoRoute(
  //       path: "/home/:email",
  //       name: "home",
  //       builder: (context, state) =>
  //           Home(email: state.pathParameters['email'] ?? "")),
  //   GoRoute(
  //       path: "/tasks",
  //       name: "tasks",
  //       builder: (context, state) => const Tasks()),
  //   GoRoute(
  //       path: "/scene",
  //       name: "scene",
  //       builder: (context, state) => const Scene()),
  //   GoRoute(
  //       path: "/food", name: "food", builder: (context, state) => const Food()),
  //   GoRoute(
  //       path: "/updateTask/:taskId",
  //       name: "updateTask",
  //       builder: (context, state) =>
  //           UpdateTask(taskId: state.pathParameters["taskId"] ?? "")
  //   ),
  // ]);

  //    String taskId = state.pathParameters["taskId"] ?? "";
  //     Task task = await myDataSource.getTask(taskId);
  //     return UpdateTask(task: task);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: MaterialApp.router(
          routerConfig:
              GoRouter(initialLocation: initialRoute, routes: _routes),
        ));
  }
}
