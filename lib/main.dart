import 'package:amigurumi_art/pages/home.dart';
import 'package:amigurumi_art/pages/login.dart';
import 'package:amigurumi_art/provider/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}
 
class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {return Cart();},
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(useMaterial3: true),
        //home: Login(),
        home :Home(),
      ),
    );
  }
}