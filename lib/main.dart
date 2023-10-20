import 'package:flutter/material.dart';
import 'package:flutter_sqlite_demo/provider/user_provider.dart';
import 'package:flutter_sqlite_demo/screens/splash_screen.dart';
import 'package:provider/provider.dart';

import 'app_constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child:  MaterialApp(
        navigatorKey: AppConstants.globalNavKey,
        debugShowCheckedModeBanner: false,
        home: const Splash(),
      ),
    );
  }
}

