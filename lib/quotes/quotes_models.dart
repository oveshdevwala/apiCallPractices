// ignore_for_file: public_member_api_docs, sort_constructors_first
class DataModels {
  int limit;
  int skip;
  int total;
  List<QuotesModels> quotes;
  DataModels({
    required this.limit,
    required this.skip,
    required this.total,
    required this.quotes,
  });
  factory DataModels.fromJson(Map<String, dynamic> json) {
    List<QuotesModels> listQuotes = [];
    for (Map<String, dynamic> eachMap in json['quotes']) {
      var eachQuotes = QuotesModels.fromJson(eachMap);
      listQuotes.add(eachQuotes);
    }
    return DataModels(
        limit: json['limit'],
        skip: json['skip'],
        total: json['total'],
        quotes: listQuotes);
  }
}

class QuotesModels {
  int id;
  String quote;
  String author;
  QuotesModels({
    required this.id,
    required this.quote,
    required this.author,
  });
  factory QuotesModels.fromJson(Map<String, dynamic> json) {
    return QuotesModels(
      id: json['id'],
      quote: json['quote'],
      author: json['author'],
    );
  }
}
