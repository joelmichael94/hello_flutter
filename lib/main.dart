import 'package:flutter/material.dart';
import 'package:hello_flutter/data/database/db.dart';
import 'package:hello_flutter/firebase_options.dart';
import 'package:hello_flutter/provider/counter_provider.dart';
import 'package:hello_flutter/provider/products_provider.dart';
import 'package:hello_flutter/service/auth_service.dart';
import 'package:hello_flutter/ui/navigation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TaskDatabase.createDb();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final isLoggedIn = await AuthService.isLoggedIn();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CounterProvider()),
        ChangeNotifierProvider(create: (context) => ProductsProvider())
      ],
      child: MyApp(initialRoute: isLoggedIn ? "/home" : "/login"),
    ),
  );
  // runApp(const MaterialApp(home: Login()));
}
