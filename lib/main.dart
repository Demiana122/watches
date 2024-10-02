import 'package:amigurumi_art/firebase_options.dart';
import 'package:amigurumi_art/pages/home.dart';
import 'package:amigurumi_art/pages/register.dart';
import 'package:amigurumi_art/pages/signIn.dart';
import 'package:amigurumi_art/pages/verify.dart';
import 'package:amigurumi_art/provider/cart.dart';
import 'package:amigurumi_art/provider/google_signin.dart';
import 'package:amigurumi_art/shared/snackbar.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return Cart();
        }),
        ChangeNotifierProvider(create: (context) {
          return GoogleSignInProvider();
        }),
      ],
      child: MaterialApp(
          title: "myApp",
          debugShowCheckedModeBanner: false,
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                  color: Colors.white,
                ));
              } else if (snapshot.hasError) {
                return showSnackBar(context, "Something went wrong");
              } else if (snapshot.hasData) {
                return Home(); //VerifyEmailPage(); // home() OR verify email
              } else {
                return Login();
              }
            },
          )),
    );
  }
}
