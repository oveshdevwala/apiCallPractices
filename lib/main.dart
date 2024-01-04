// import 'package:dummy_api/screens/quotes_screen.dart';
// ignore_for_file: non_constant_identifier_names

import 'package:dummy_api/movies/movie_screen.dart';
import 'package:dummy_api/products/products_screen.dart';
import 'package:dummy_api/quotes/quotes_screen.dart';
import 'package:dummy_api/todos/todo_screen.dart';
import 'package:dummy_api/user/user_screen.dart';
// import 'package:dummy_api/screens/todo_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Api Learn',
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Padding MyNavigateButton({required String btName, required Widget screen}) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => screen));
            },
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                padding: const EdgeInsets.all(12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
            child: Text(
              btName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )),
      );
    }

    return Scaffold(
      backgroundColor: Colors.green.shade100,
      appBar: AppBar(
        title: const Center(
            child: Text(
          'Learn API',
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
        backgroundColor: Colors.green.shade200,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyNavigateButton(
                btName: 'Product APi', screen: const ProductScreen()),
            MyNavigateButton(btName: 'Todo API', screen: const ToDoScreen()),
            MyNavigateButton(
                btName: 'Quotes API', screen: const QuotesScreen()),
            MyNavigateButton(
                btName: 'Movies API', screen: const MovieScreenAPI()),
            MyNavigateButton(btName: 'User API', screen: const UserScreen()),
          ],
        ),
      ),
    );
  }
}
