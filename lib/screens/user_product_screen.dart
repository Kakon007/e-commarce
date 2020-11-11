import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/product_provider.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/widgets/app_dawer.dart';
import 'package:shop_app/widgets/userProduct_item.dart';

class UserProducts extends StatelessWidget {
  const UserProducts({Key key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
   final product= Provider.of<Product>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your products"),
        actions: [
          IconButton(icon: Icon(Icons.add), onPressed: (){
             Navigator.push(
                              context, MaterialPageRoute(builder: (context)=>EditProductScreen()));
          })
        ],
      ),
      drawer: AppDawer(),
      body: ListView.builder(itemCount: product.item.length ,itemBuilder: (ctx,i)=>UserProductItem(
          id: product.item[i].id,
          title: product.item[i].title,
          price: product.item[i].price,
          imageurl: product.item[i].imageUrl,
      ),
      ),
      
    );
  }
}
