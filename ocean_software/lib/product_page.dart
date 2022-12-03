import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ocean_software/home_page.dart';
import 'package:ocean_software/service/product_service.dart';

import 'model/product.dart';

class ProductPage extends StatefulWidget {
  ProductPage({this.id = "All", this.name = "All"});
  String? id;
  String? name;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  Product? _product;
  List<Datum> _data = [];

  @override
  void initState() {
    super.initState();
    getProduct();
  }

  getProduct() {
    _product = ProductService.getInstance().getProduct();
    if (widget.id != "All") {
      _product!.data!.map((e) {
        if (e.category!.id == widget.id) _data.add(e);
      }).toList();
    } else {
      _data = _product!.data!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => HomePage()));
            },
            icon: Icon(Icons.arrow_back)),
        title: Text("Product - ${widget.name}"),
        centerTitle: true,
      ),
      body: Container(
          padding: EdgeInsets.all(12.0),
          child: GridView.builder(
            itemCount: _data.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.55,
                crossAxisCount: 2,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: 200,
                        height: 80,
                        child: Text(
                          _data[index].title!,
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.fade),
                        )),
                    Image.asset("assets/images/productimage.png"),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          child: Text(
                        "PRICE: ${_product!.data![index].price!.toString()}",
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.fade),
                      )),
                    ),
                    Divider(
                      color: Colors.blue,
                      thickness: 1,
                    )
                  ],
                ),
              );
            },
          )),
    );
  }
}
