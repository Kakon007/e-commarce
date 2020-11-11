import 'package:flutter/material.dart';

class CartItem {
  final String imageurl;
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
    @required this.imageurl,
  });

  // CartScreen cartScreen = new CartScreen(id: id,);
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _item = {};

  Map<String, CartItem> get item {
    return {..._item};
  }

  int get itemCount {
    return _item.length;
  }

  double get totalamount {
    double total = 0.0;
    _item.forEach((key, cartitem) {
      total += cartitem.price * cartitem.quantity;
    });
    return total;
  }

  // double  reduceAmount(double amount) {
  //   double total = amount;
  //   _item.forEach((key, cartitem) {
  //     total -= cartitem.price * cartitem.quantity;
  //   });
  //   return total;
  // }

  void addItem(String productId, String title, double price, String imageUrl) {
    if (_item.containsKey(productId)) {
      //...change quantity
      _item.update(
          productId,
          (excistingCartitem) => CartItem(
              id: excistingCartitem.id,
              title: excistingCartitem.title,
              quantity: excistingCartitem.quantity + 1,
              price: excistingCartitem.price,
              imageurl: excistingCartitem.imageurl));
    } else {
      _item.putIfAbsent(
          productId,
          () => CartItem(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                title: title,
                price: price,
                quantity: 1,
                imageurl: imageUrl,
              ));
    }
    notifyListeners();
  }

  void removeCartItem(String productId) {
    _item.remove(productId);
    notifyListeners();
  }

  void removeSingleProduct(String productId) {
    if (!_item.containsKey(productId)) {
      return;
    }
    if (_item[productId].quantity > 1) {
      _item.update(
          productId,
          (existing) => CartItem(
              id: existing.id,
              title: existing.title,
              quantity: existing.quantity - 1,
              price: existing.price,
              imageurl: existing.imageurl));
    } else {
      _item.remove(productId);
    }
    notifyListeners();
  }

  void colseCart() {
    _item.clear();
    notifyListeners();
  }
}
