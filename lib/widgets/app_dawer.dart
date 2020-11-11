import 'package:flutter/material.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/screens/order_screen.dart';
import 'package:shop_app/screens/user_product_screen.dart';

class AppDawer extends StatelessWidget {
  const AppDawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text("MD. JAHID HASAN"),
            automaticallyImplyLeading: false,
          ),

          Divider(),
          ListTile(
            leading: Icon(Icons.shop,color: Colors.purpleAccent,),
            title: Text("Shop"),
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyApp()));
            },
          ),

          Divider(),
          ListTile(
            leading: Icon(Icons.payment,color: Colors.purpleAccent,),
            title: Text("Order"),
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OrderScreen()));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment,color: Colors.purpleAccent,),
            title: Text("Your Products"),
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UserProducts()));
            },
          ),
        ],
      ),
    );
  }
}
