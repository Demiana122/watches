import 'package:amigurumi_art/firebase_options.dart';
import 'package:amigurumi_art/pages/home.dart';
import 'package:amigurumi_art/pages/login.dart';
import 'package:amigurumi_art/pages/register.dart';
import 'package:amigurumi_art/provider/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';


Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
     );
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
        home :Register(),
      ),
    );
  }
}