class MovieDataModel {
  List<MovieModel> moviedataModel;
  MovieDataModel({
    required this.moviedataModel,
  });
  factory MovieDataModel.fromJson(dynamic json) {
    List<MovieModel> listOfMovies = [];

    for (dynamic eachMap in json) {
      var listData = MovieModel.fromJson(eachMap);
      listOfMovies.add(listData);
    }
    return MovieDataModel(moviedataModel: listOfMovies);
  }
}

class MovieModel {
  int id;
  String movie;
  num rating;
  String image;
  String imdb_url;
  MovieModel({
    required this.id,
    required this.movie,
    required this.rating,
    required this.image,
    required this.imdb_url,
  });
  factory MovieModel.fromJson(dynamic json) {
    return MovieModel(
        id: json['id'],
        movie: json['movie'],
        rating: json['rating'],
        image: json['image'],
        imdb_url: json['imdb_url']);
  }
}
