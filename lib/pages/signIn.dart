import 'package:amigurumi_art/pages/forgotpassword.dart';
import 'package:amigurumi_art/pages/register.dart';
import 'package:amigurumi_art/provider/google_signin.dart';
import 'package:amigurumi_art/shared/constants.dart';
import 'package:amigurumi_art/shared/constcolors.dart';
import 'package:amigurumi_art/shared/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isvisible = false;
  bool isloading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  signIn() async {
    setState(() {
      isloading = true;
    });
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // showSnackBar(context, "Donee");
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, "Error :${e.code}");
    }
    //stop progress indicator
    setState(() {
      isloading = false;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final googlesigninprovider = Provider.of<GoogleSignInProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarGreen,
        title: Text("Sign in"),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(33.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 64,
                ),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  decoration: decorationTextfield.copyWith(
                    hintText: "Enter your Email: ",
                    suffixIcon: Icon(Icons.email),
                  ),
                ),
                const SizedBox(
                  height: 33,
                ),
                TextField(
                  controller: passwordController,
                  keyboardType: TextInputType.text,
                  obscureText: isvisible ? false : true,
                  decoration: decorationTextfield.copyWith(
                    hintText: "Enter your password: ",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isvisible = !isvisible;
                        });
                      },
                      icon: isvisible
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 33,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await signIn();
                    if (!mounted) return;
                    //showSnackBar(context, "Done...");
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(BTNgreen),
                    padding: WidgetStateProperty.all(const EdgeInsets.all(12)),
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                  ),
                  child: const Text(
                    "SIGN IN",
                    style: TextStyle(fontSize: 19),
                  ),
                ),
                const SizedBox(
                  height: 9,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Forgotpassword()),
                      );
                    },
                    child: Text(
                      "forget password",
                      style: TextStyle(
                        fontSize: 18,
                        decoration: TextDecoration.underline,
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Do not have an account?",
                        style: TextStyle(fontSize: 20)),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Register()),
                        );
                      },
                      child: isloading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              'SIGN UP',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 20,
                              ),
                            ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 17,
                ),
                SizedBox(
                  width: 299,
                  child: Row(
                    children: [
                      Expanded(
                          child: Divider(
                        thickness: 0.6,
                      )),
                      Text(
                        "OR",
                        style: TextStyle(),
                      ),
                      Expanded(
                          child: Divider(
                        thickness: 0.6,
                      )),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 27),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          googlesigninprovider.googlelogin();
                        },
                        child: Container(
                          padding: EdgeInsets.all(13),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.purple, width: 1)),
                          child: SvgPicture.asset(
                            "assets/icons/icons.svg",
                            // ignore: deprecated_member_use
                            color: Colors.purple[400],
                            height: 27,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
