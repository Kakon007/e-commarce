import 'package:flutter/material.dart';
import 'package:shop_app/provider/products.dart';

class Product with ChangeNotifier {
  List<Products> _item = [
    Products(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Products(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Products(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Products(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  // var _showFavouriteOnly = false;

  List<Products> get item {
    // if (_showFavouriteOnly) {
    //   return _item.where((element) => element.isfavourite).toList();
    // }
    return [..._item];
  }

  List<Products> get favitems {
    return _item.where((prodItem) => prodItem.isfavourite).toList();
  }

  // void showFavouriteonly() {
  //   _showFavouriteOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavouriteOnly = false;
  //   notifyListeners();
  // }

  Products findById(String id) {
    return item.firstWhere((prod) => prod.id == id);
  }

  void addProducts(Products product) {
    //_item.add(value);

    final newproducts = Products(
        id: DateTime.now().toString(),
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl);
    _item.add(newproducts);
    notifyListeners();
  }

  void updatedProducts(String id, Products newProduct) {
    final proIndex = _item.indexWhere((element) => element.id == id);
    if (proIndex >= 0) {
      item[proIndex] = newProduct;
      notifyListeners();
    } else {
      print(".......");
    }
  }

  void deleteProducts(String id) {
    _item.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
