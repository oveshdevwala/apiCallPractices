import 'dart:convert';

import 'package:dummy_api/quotes/quotes_models.dart';
import 'package:flutter/material.dart';
// ignore: library_prefixes
import 'package:http/http.dart' as httpClient;

class QuotesScreen extends StatefulWidget {
  const QuotesScreen({super.key});

  @override
  State<QuotesScreen> createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  DataModels? dataModels;
  @override
  void initState() {
    super.initState();
    getQuotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      appBar: AppBar(
        title: const Text('Quotes Request'),
        backgroundColor: Colors.green.shade200,
      ),
      body: dataModels != null && dataModels!.quotes.isNotEmpty
          ? todoListView()
          : const Center(
              child: CircularProgressIndicator(
              color: Colors.black,
              strokeAlign: 4,
            )),
    );
  }

  SingleChildScrollView todoListView() {
    return SingleChildScrollView(
      child: Column(children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: dataModels!.quotes.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(10),
              child: Card(
                color: Colors.green.shade200,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.black,
                    child: Text(
                      dataModels!.quotes[index].id.toString(),
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  title: Text(
                    dataModels!.quotes[index].author.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    dataModels!.quotes[index].quote.toString(),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            );
          },
        )
      ]),
    );
  }

  getQuotes() async {
    var uri = Uri.parse("https://dummyjson.com/quotes");
    var response = await httpClient.get(uri);
    if (response.statusCode == 200) {
      var mData = jsonDecode(response.body);
      dataModels = DataModels.fromJson(mData);
      setState(() {});
    }
  }
}
