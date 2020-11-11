import 'package:flutter/cupertino.dart';

class Products with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isfavourite ;

  Products(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      this.isfavourite= false});

  void toggleFavouriteStatus() {
    isfavourite = !isfavourite;
    notifyListeners();
  }
}
