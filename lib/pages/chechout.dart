import 'package:amigurumi_art/provider/cart.dart';
import 'package:amigurumi_art/shared/Appbar.dart';
import 'package:amigurumi_art/shared/constcolors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckOut extends StatelessWidget {
  const CheckOut({super.key});

  @override
  Widget build(BuildContext context) {
    final cartt = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarGreen,
        title: const Text("check out screen"),
        actions: [ProductsAndPrice()],
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: 500,
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: cartt.selectedProducts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        title: Text(cartt.selectedProducts[index].name),
                        subtitle: Text(
                            "${cartt.selectedProducts[index].price}-${cartt.selectedProducts[index].location}"),
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(
                              cartt.selectedProducts[index].imagePath),
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              cartt.delete(cartt.selectedProducts[index]);
                            }, icon: const Icon(Icons.remove)),
                      ),
                    );
                  }),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.edit_location,
              color: Color.fromARGB(255, 255, 129, 129),
              size: 24.0,
            ),
            label: Text(
              "pay \$${cartt.price}",
              style: const TextStyle(fontSize: 19),
            ),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(BTNpink),
              padding: WidgetStateProperty.all(const EdgeInsets.all(22)),
              shape: WidgetStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
            ),
          ),
        ],
      ),
    );
  }
}
