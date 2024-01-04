import 'dart:convert';

import 'package:dummy_api/products/products_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as httpclient;

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  ProductDataModel? productDataModel;
  @override
  void initState() {
    super.initState();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      appBar: AppBar(
        title: const Text('Ecommerce'),
        backgroundColor: Colors.green.shade200,
      ),
      body: productDataModel != null && productDataModel!.products.isNotEmpty
          ? productGridView()
          : const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
                strokeAlign: 4,
              ),
            ),
    );
  }

  Column productGridView() {
    return Column(children: [
      Expanded(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                  child: Column(children: [
                const SizedBox(height: 10),
                GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: productDataModel!.products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      var apiPath = productDataModel!.products[index];
                      return InkWell(
                          onTap: () {
                            var apipath = productDataModel!.products[index];
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProductViewScreen(apipath: apipath),
                                ));
                          },
                          child: Card(
                              color: Colors.green.shade200,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(12),
                                                        topRight:
                                                            Radius.circular(
                                                                12)),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        apiPath.thumbnail)),
                                              )),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    apiPath.title,
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          '\$${apiPath.price}',
                                                          style: const TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                          '\$${((apiPath.price * apiPath.discountPercentage / 100) + apiPath.price).toInt()}',
                                                          style: const TextStyle(
                                                              color: Colors
                                                                  .black38,
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                              decorationThickness:
                                                                  3,
                                                              decorationColor:
                                                                  Colors
                                                                      .black26,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                      ])
                                                ]))
                                      ]))));
                    }),
                const SizedBox(height: 30)
              ]))))
    ]);
  }

  getProducts() async {
    var uri = Uri.parse('https://dummyjson.com/products');
    var response = await httpclient.get(uri);
   
    if (response.statusCode == 200) {
      var mdata = jsonDecode(response.body);
      productDataModel = ProductDataModel.fromJson(mdata);
      setState(() {});
    }
  }
}

class ProductViewScreen extends StatelessWidget {
  const ProductViewScreen({
    super.key,
    required this.apipath,
  });

  final ProductModel apipath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      appBar: AppBar(
        title: Text(apipath.title),
        backgroundColor: Colors.green.shade200,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: apipath.images.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 120,
                          width: 300,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(apipath.images[index]),
                                  fit: BoxFit.contain),
                              color: Colors.grey.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                apipath.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                            Text(
                              "\$${apipath.price.toString()}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 21),
                            ),
                          ],
                        ),
                      ),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          additionalDetailesBar(apipath.brand),
                          additionalDetailesBar(apipath.category),
                          additionalDetailesBar("Stock ${apipath.stock}"),
                          additionalDetailesBar(
                              fw: true,
                              "${apipath.discountPercentage.toInt()}% Discount"),
                          ratingbar(),
                        ],
                      ),
                      const SizedBox(height: 20),
                      additionalDetailesBar(
                          "${apipath.description},\n${apipath.description},\n${apipath.description},\n${apipath.description},\n${apipath.description},\n"),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Container additionalDetailesBar(dynamic data, {var fw = false}) {
    return Container(
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12)),
        child: Text(
          "$data",
          style:
              TextStyle(fontWeight: fw ? FontWeight.bold : FontWeight.normal),
        ));
  }

  Container ratingbar() {
    return Container(
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        width: 60,
        child: Row(
          children: [
            Icon(
              Icons.star,
              color: Colors.yellow.shade800,
            ),
            const SizedBox(width: 5),
            Text(apipath.rating.toStringAsFixed(1))
          ],
        ),
      ),
    );
  }
}
