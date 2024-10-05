import 'package:amigurumi_art/model/item.dart';
import 'package:amigurumi_art/pages/chechout.dart';
import 'package:amigurumi_art/pages/detailsscreen.dart';
import 'package:amigurumi_art/provider/cart.dart';
import 'package:amigurumi_art/shared/Appbar.dart';
import 'package:amigurumi_art/shared/constcolors.dart';
import 'package:amigurumi_art/shared/user_image_from_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    final cartt = Provider.of<Cart>(context);
    //final userrrs = FirebaseAuth.instance.currentUser!;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 22),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 33),
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Details(product: items[index]),
                      ),
                    );
                  },
                  child: GridTile(
                    footer: GridTileBar(
// backgroundColor: Color.fromARGB(66, 73, 127, 110),

                      trailing: IconButton(
                          color: Color.fromARGB(255, 62, 94, 70),
                          onPressed: () {
                            cartt.add(items[index]);
                          },
                          icon: Icon(Icons.add)),

                      leading: Text("\$12.99"),

                      title: Text(
                        "",
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 10,
                          bottom: -9,
                          right: 0,
                          left: 0,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(55),
                              child: Image.asset(items[index].imagePath)),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/backgroud.jpg"),
                          //  image:  NetworkImage(userrrs.photoURL!),
                          fit: BoxFit.cover),
                    ),
                    currentAccountPicture:  ImageUser(),
                //  backgroundImage:  NetworkImage(userrrs.photoURL!)),
                    accountEmail: Text("demianaseed@gmail.com"),//userrrs.displayName! or userrrs.email!
                    accountName: Text(
                      "Demiana saeed",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                  ListTile(
                      title: Text("Home"),
                      leading: Icon(Icons.home),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(),
                          ),
                        );
                      }),
                  ListTile(
                      title: Text("My products"),
                      leading: Icon(Icons.add_shopping_cart),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CheckOut(),
                            ));
                      }),
                  ListTile(
                      title: Text("About"),
                      leading: Icon(Icons.help_center),
                      onTap: () {}),
                
                 ListTile(
                      title: Text("Profile Page"),
                      leading: Icon(Icons.person),
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => ProfilePage(),
                        //   ),
                        // );
                      }),

                
                
                  ListTile(
                      title: Text("Logout"),
                      leading: Icon(Icons.exit_to_app),
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                      }),
                ],
              ),
              Container(
                margin: EdgeInsets.only(bottom: 12),
                child: Text("Developed by Demiana saeed © 2024",
                    style: TextStyle(fontSize: 16)),
              )
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: appbarGreen,
          actions: [ProductsAndPrice()],
          title: Text("Home"),
        ),
      ),
    );
  }
}
