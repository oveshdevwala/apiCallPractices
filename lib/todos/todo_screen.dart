import 'dart:convert';
import 'package:dummy_api/todos/todo_model.dart';
// ignore: library_prefixes
import 'package:http/http.dart' as httpClient;
import 'package:flutter/material.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  ToDoDataModel? todoDataModel;
  @override
  void initState() {
    super.initState();
    getTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      appBar: AppBar(
        title: const Text('Todo Request'),
        backgroundColor: Colors.green.shade200,
      ),
      body: todoDataModel != null && todoDataModel!.todos.isNotEmpty
          ? ListView.builder(
              itemCount: todoDataModel!.todos.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.green.shade200,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: CircleAvatar(
                          backgroundColor: Colors.black,
                          child: Text(
                            todoDataModel!.todos[index].id.toString(),
                            style: const TextStyle(color: Colors.white),
                          )),
                      title: Text(todoDataModel!.todos[index].todo),
                      subtitle: Text(todoDataModel!.todos[index].todo),
                      trailing: Checkbox.adaptive(
                          value: bool.parse(
                              todoDataModel!.todos[index].completed.toString()),
                          onChanged: (value) {}),
                    ),
                  ),
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator(
                  color: Colors.black, strokeAlign: 4)),
    );
  }

  getTodos() async {
    var uri = Uri.parse('https://dummyjson.com/todos');
    var resposnse = await httpClient.get(uri);
    if (resposnse.statusCode == 200) {
      var mData = jsonDecode(resposnse.body);
      todoDataModel = ToDoDataModel.fromJson(mData);
      setState(() {});
    }
  }
}
