// ignore_for_file: use_super_parameters
import 'package:amigurumi_art/pages/login.dart';
import 'package:amigurumi_art/shared/constants.dart';
import 'package:amigurumi_art/shared/constcolors.dart';
import 'package:amigurumi_art/shared/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isvisible = true;
  final _formKey = GlobalKey<FormState>();
  bool isloading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordHas8Character = false;
  bool isPasswordHas1Number = false;
  bool hasUppercase = false;
  bool hasLowercase = false;
  bool hasSpecialCharacter = false;

  OnPasswordChanged(String password) {
    isPasswordHas1Number = false;
    isPasswordHas8Character = false;
    hasUppercase = false;
    hasLowercase = false;
    hasSpecialCharacter = false;
    setState(() {
      if (password.contains(RegExp(r'.{8,}'))) {
        isPasswordHas8Character = true;
      }
      if (password.contains(RegExp(r'[0-9]'))) {
        isPasswordHas1Number = true;
      }
      if (password.contains(RegExp(r'[A-Z]'))) {
        hasUppercase = true;
      }
      if (password.contains(RegExp(r'[a-z]'))) {
        hasLowercase = true;
      }
      if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        hasSpecialCharacter = true;
      }
    });
  }

  register() async {
    setState(() {
      isloading = true;
    });
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(context, "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(context, "The account already exists for that email.");
      } else {
        showSnackBar(context, "ERROR - please try again later. ");
      }
    } catch (err) {
      showSnackBar(context, err.toString());
    }

    setState(() {
      isloading = true;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(33.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextField(
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      decoration: decorationTextfield.copyWith(
                        hintText: "Enter your username: ",
                        suffixIcon: Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(
                      height: 33,
                    ),
                    TextFormField(
                      // we return "null" when something is valid
                      validator: (email) {
                        return email!.contains(RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                            ? null
                            : "Enter a valid email";
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    TextFormField(
                      onChanged: (password) {
                        OnPasswordChanged(password);
                      },
                      // we return "null" when something is valid
                      validator: (value) {
                        return value!.length < 8
                            ? "Enter at least 8 char"
                            : null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: isvisible ? true : false,
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
                      height: 15,
                    ),
                    Row(
                      children: [
                        Container(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 15,
                          ),
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isPasswordHas8Character
                                ? Colors.green
                                : Colors.white,
                            border: Border.all(
                              color: const Color.fromARGB(255, 189, 189, 189),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 11,
                        ),
                        Text("At least 8 char"),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Container(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 15,
                          ),
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isPasswordHas1Number
                                ? Colors.green
                                : Colors.white,
                            border: Border.all(
                              color: const Color.fromARGB(255, 189, 189, 189),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 11,
                        ),
                        Text("At least 1 number"),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Container(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 15,
                          ),
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: hasUppercase ? Colors.green : Colors.white,
                            border: Border.all(
                              color: const Color.fromARGB(255, 189, 189, 189),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 11,
                        ),
                        Text("Have uppercase"),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Container(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 15,
                          ),
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: hasLowercase ? Colors.green : Colors.white,
                            border: Border.all(
                              color: const Color.fromARGB(255, 189, 189, 189),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 11,
                        ),
                        Text("Have lowercase"),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Container(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 15,
                          ),
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: hasSpecialCharacter
                                ? Colors.green
                                : Colors.white,
                            border: Border.all(
                              color: const Color.fromARGB(255, 189, 189, 189),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 11,
                        ),
                        Text("Have special character"),
                      ],
                    ),
                    const SizedBox(
                      height: 33,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          register();
                          if (!mounted) return;
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                          //  showSnackBar(context, "Done");
                        } else {
                          showSnackBar(context, "ERROR");
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(BTNgreen),
                        padding:
                            WidgetStateProperty.all(const EdgeInsets.all(12)),
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                      ),
                      child: isloading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "Register",
                              style: TextStyle(fontSize: 19),
                            ),
                    ),
                    const SizedBox(
                      height: 33,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Do not have an account?",
                          style: TextStyle(fontSize: 20),
                        ),
                        TextButton(
                          onPressed: () {
                            // Navigator.pushNamed(context,'/SIGN IN'); // تأكد من أن '/login' هو اسم المسار الصحيح
                            // أو إذا كنت تستخدم MaterialPageRoute:
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          },
                          child: const Text(
                            'SIGN In',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
