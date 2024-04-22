import 'package:flutter/material.dart';
import 'package:flutter_application_1/HomeScreen/HomePage.dart';
import 'package:flutter_application_1/admin/adminlogin.dart';
import 'package:flutter_application_1/HomeScreen/requests.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controller/controller.dart';

Widget defaultHome = HomeScreen();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();



  
  runApp(MultiProvider(providers: [
  ChangeNotifierProvider(create: (context) => OnBoardNotifier()),

  ], child: const MyApp()));}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the roo
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:HomeScreen(),
    );
  }
}

