import 'dart:convert';

import 'package:dummy_api/movies/movie_model.dart';
import 'package:flutter/material.dart';
// ovesh
// ignore: library_prefixes
import 'package:http/http.dart' as httpClient;

class MovieScreenAPI extends StatefulWidget {
  const MovieScreenAPI({super.key});

  @override
  State<MovieScreenAPI> createState() => _MovieScreenAPIState();
}

class _MovieScreenAPIState extends State<MovieScreenAPI> {
  MovieDataModel? movieDataModel;
  @override
  void initState() {
    super.initState();
    getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: movieDataModel != null && movieDataModel!.moviedataModel.isNotEmpty
          ? SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: movieDataModel!.moviedataModel.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      color: Colors.orange.shade200,
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Name : ${movieDataModel!.moviedataModel[index].movie}'),
                            Text(
                                'URl : ${movieDataModel!.moviedataModel[index].imdb_url}'),
                            Text(
                                'Path : ${movieDataModel!.moviedataModel[index].image}'),
                            Text(
                                'ID : ${movieDataModel!.moviedataModel[index].id}'),
                          ],
                        ),
                        subtitle: Text(
                            'Rating : ${movieDataModel!.moviedataModel[index].rating}'),
                      ),
                    ),
                  );
                },
              ),
            )
          : const Center(child: CircularProgressIndicator.adaptive()),
    );
  }

  getMovies() async {
    var uri = Uri.parse('https://dummyapi.online/api/movies');
    var response = await httpClient.get(uri);
    if (response.statusCode == 200) {
      var mdata = jsonDecode(response.body);
      movieDataModel = MovieDataModel.fromJson(mdata);
      setState(() {});
    }
  }
}
