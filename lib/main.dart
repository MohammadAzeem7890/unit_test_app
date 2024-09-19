import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:unit_testing_app/home_network.dart';

import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        platform: TargetPlatform.iOS,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Home(
        futureListOfPosts: HomeNetwork(Client()).fetchPosts(),
      ),
    );
  }
}
