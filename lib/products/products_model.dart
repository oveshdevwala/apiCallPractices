// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductDataModel {
  int total;
  int skip;
  int limit;
  List<ProductModel> products;
  ProductDataModel({
    required this.total,
    required this.skip,
    required this.limit,
    required this.products,
  });
  factory ProductDataModel.fromJson(Map<String, dynamic> json) {
    List<ProductModel> listProducts = [];
    for (Map<String, dynamic> eachMap in json['products']) {
      listProducts.add(ProductModel.fromJson(eachMap));
    }
    return ProductDataModel(
        total: json['total'],
        skip: json['skip'],
        limit: json['limit'],
        products: listProducts);
  }
}

class ProductModel {
  num id;
  num price;
  num discountPercentage;
  num rating;
  num stock;
  String title;
  String description;
  String brand;
  String category;
  String thumbnail;
  List<dynamic> images;
  ProductModel({
    required this.id,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.title,
    required this.description,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['id'],
        price: json['price'],
        discountPercentage: json['discountPercentage'],
        rating: json['rating'],
        stock: json['stock'],
        title: json['title'],
        description: json['description'],
        brand: json['brand'],
        category: json['category'],
        thumbnail: json['thumbnail'],
        images: json['images']);
  }
}
