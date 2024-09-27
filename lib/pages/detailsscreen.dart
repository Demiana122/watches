import 'package:amigurumi_art/model/item.dart';
import 'package:amigurumi_art/shared/Appbar.dart';
import 'package:amigurumi_art/shared/constcolors.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  Item product;
  Details({super.key, required this.product});
  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  //const Details({Key? key}) : super(key: key);
  bool isshowmore = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarGreen,
        actions: [ProductsAndPrice()],
        title: const Text("Details screen"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(widget.product.imagePath),
            const SizedBox(
              height: 11,
            ),
            Text(
              "\$${widget.product.price}",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 230, 109, 149)),
                  child: Text(
                    "New",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                const Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 26,
                      color: Color.fromARGB(255, 241, 138, 3),
                    ),
                    Icon(
                      Icons.star,
                      size: 26,
                      color: Color.fromARGB(255, 241, 138, 3),
                    ),
                    Icon(
                      Icons.star,
                      size: 26,
                      color: Color.fromARGB(255, 241, 138, 3),
                    ),
                    Icon(
                      Icons.star,
                      size: 26,
                      color: Color.fromARGB(255, 241, 138, 3),
                    ),
                    Icon(
                      Icons.star,
                      size: 26,
                      color: Color.fromARGB(255, 241, 138, 3),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 23,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(
                      Icons.edit_location,
                      size: 23,
                      color: Colors.blue,
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      widget.product.location,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            const SizedBox(
              width: double.infinity,
              child: Text(
                "Details: ",
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Having apiece of Amigrumi and crochet this makes you more relaxe",
              style: const TextStyle(
                fontSize: 18,
              ),
              maxLines: isshowmore ? 3 : null,
              overflow: TextOverflow.fade,
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  isshowmore = !isshowmore;
                });
              },
              child: Text(
                isshowmore ? "show more" : "show less",
                style: const TextStyle(fontSize: 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
