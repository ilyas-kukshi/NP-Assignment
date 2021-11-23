import 'dart:convert' as convert;

import 'package:fluttertoast/fluttertoast.dart';
import 'package:npassignment/models/product_model.dart';

import 'package:http/http.dart' as http;
import 'package:npassignment/shared/constants.dart';

class ProductsService {
  Future<List<ProductsModel>> getAllProducts() async {
    List<ProductsModel> allProducts = [];
    try {
      var client = http.Client();
      var response = await client.get(Uri.https(Constants.apiUrl, '/products'));
      if (response.statusCode == 200) {
        final products = convert.jsonDecode(response.body) as List;
        for (int i = 0; i < products.length; i++) {
          allProducts.add(ProductsModel.fromJson(products[i]));
        }
      } else {}
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    return allProducts;
  }
}
