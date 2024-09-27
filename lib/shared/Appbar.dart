// ignore: file_names
import 'package:amigurumi_art/pages/chechout.dart';
import 'package:amigurumi_art/provider/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsAndPrice extends StatelessWidget {
  ProductsAndPrice({super.key});

  @override
  Widget build(BuildContext context) {
    final cartt = Provider.of<Cart>(context);

    return Row(
      children: [
        Stack(children: [
          Positioned(
            bottom: 20,
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Color.fromARGB(211, 164, 255, 193),
                  shape: BoxShape.circle),
              child: Text(
                "${cartt.itemCount }", //selectedProducts.length change this by get
                style: TextStyle(
                    fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
          ),
          IconButton(onPressed: () {
            Navigator.push(
            context,
          MaterialPageRoute(
            builder: (context) => CheckOut(),
          ));
          },
           icon: Icon(Icons.add_shopping_cart)),
        ]),
        Padding(
          padding: EdgeInsets.only(right: 12),
          child: Text("\$ ${cartt.price}", style: TextStyle(fontSize: 18)),
        ),
      ],
    );
  }
}
