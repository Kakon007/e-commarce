import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/product_provider.dart';
import 'package:shop_app/provider/products.dart';

class EditProductScreen extends StatefulWidget {
  EditProductScreen({Key key}) : super(key: key);
  static const routeName = "/edit-product";

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  TextEditingController _imgcontroller = TextEditingController();
  final _imgurlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editProduct =
      Products(id: null, title: "", description: "", price: null, imageUrl: "");
  var _isInit = true;

  var _initValues = {
    "title": "",
    "description": "",
    "price": "",
    "imageUrl": ""
  };

  @override
  void initState() {
    _imgurlFocusNode.addListener(updatedURL);
    super.initState();
  }

  @override
  void dispose() {
    _imgurlFocusNode.removeListener(updatedURL);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imgcontroller.dispose();
    _imgurlFocusNode.dispose();
    super.dispose();
  }

  void updatedURL() {
    if (!_imgurlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    final isValidate = _form.currentState.validate();
    if (!isValidate) {
      return;
    }
    _form.currentState.save();
    if (_editProduct.id != null) {
      Provider.of<Product>(context, listen: false)
          .updatedProducts(_editProduct.id, _editProduct);
    } else {
      Provider.of<Product>(context, listen: false).addProducts(_editProduct);
    }

    Navigator.of(context).pop();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments;
      if (productId != null) {
         _editProduct = Provider.of<Product>(context).findById(productId);
      _initValues = {
        "title": _editProduct.title,
        "description": _editProduct.description,
        "price": _editProduct.price.toString(),
        //"imageUrl": _editProduct.imageUrl
        "imageUrl": ""
      };
       _imgcontroller.text = _editProduct.imageUrl;
      }
     
     
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                _saveForm();
              })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _initValues["title"],
                decoration: InputDecoration(
                  labelText: "Title",
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please Enter A Title";
                  }
                  return null;
                },
                onSaved: (value) {
                  _editProduct = Products(
                      id: _editProduct.id,
                      isfavourite: _editProduct.isfavourite,
                      title: value,
                      description: _editProduct.description,
                      price: _editProduct.price,
                      imageUrl: _editProduct.imageUrl);
                },
              ),
              TextFormField(
                initialValue: _initValues["price"],
                decoration: InputDecoration(
                  labelText: "Price",
                ),
                textInputAction: TextInputAction.next,
                focusNode: _priceFocusNode,
                keyboardType: TextInputType.number,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please Enter A price";
                  }
                  if (double.tryParse(value) == null) {
                    return "Please Enter A Proper Amount";
                  }
                  if (double.parse(value) <= 0) {
                    return "Please Enter A Amount greater Than Zero";
                  }
                  return null;
                },
                onSaved: (value) {
                  _editProduct = Products(
                      id: _editProduct.id,
                      isfavourite: _editProduct.isfavourite,
                      title: _editProduct.title,
                      description: _editProduct.description,
                      price: double.parse(value),
                      imageUrl: _editProduct.imageUrl);
                },
              ),
              TextFormField(
                initialValue: _initValues["description"],
                decoration: InputDecoration(
                  labelText: "Description",
                ),
                maxLines: 3,
                focusNode: _descriptionFocusNode,
                keyboardType: TextInputType.multiline,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Enter Description";
                  }
                  if (value.length <= 10) {
                    return "Character Should Be More Than 10";
                  }
                  return null;
                },
                onSaved: (value) {
                  _editProduct = Products(
                      id: _editProduct.id,
                      isfavourite: _editProduct.isfavourite,
                      title: _editProduct.title,
                      description: value,
                      price: _editProduct.price,
                      imageUrl: _editProduct.imageUrl);
                },
              ),
              Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 8, right: 10),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey)),
                    child: _imgcontroller.text.isEmpty
                        ? Text("Enter A image URL")
                        : FittedBox(
                            child: Image.network(_imgcontroller.text),
                            fit: BoxFit.cover,
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "ImageUrl"),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imgcontroller,
                      focusNode: _imgurlFocusNode,
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Enter A image URL";
                        }
                        if (!value.startsWith("http") &&
                            !value.startsWith("https")) {
                          return "Please Enter A Valid URL";
                        }
                        if (!value.endsWith(".png") &&
                            !value.endsWith(".jpg") &&
                            !value.endsWith(".jpeg")) {
                          return "Please Enter A Valid URL";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editProduct = Products(
                            id: _editProduct.id,
                            isfavourite: _editProduct.isfavourite,
                            title: _editProduct.title,
                            description: _editProduct.description,
                            price: _editProduct.price,
                            imageUrl: value);
                      },
                    ),
                  )
                ],
              ),
              Divider()
            ],
          ),
        ),
      ),
    );
  }
}
