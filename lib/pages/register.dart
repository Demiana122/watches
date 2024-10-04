// ignore_for_file: use_super_parameters

import 'dart:math';

import 'package:amigurumi_art/pages/signIn.dart';
import 'package:amigurumi_art/shared/constants.dart';
import 'package:amigurumi_art/shared/constcolors.dart';
import 'package:amigurumi_art/shared/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' show basename;

class Register extends StatefulWidget {
  Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isvisible = true;
  File? imgPath;
  String? imgName;
  final _formKey = GlobalKey<FormState>();
  bool isloading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final titleController = TextEditingController();
  final ageController = TextEditingController();

  bool isPasswordHas8Character = false;
  bool isPasswordHas1Number = false;
  bool hasUppercase = false;
  bool hasLowercase = false;
  bool hasSpecialCharacter = false;

  uploadImageToScreen(ImageSource sourcee) async {
    final pickedImg = await ImagePicker().pickImage(source: sourcee);
    try {
      if (pickedImg != null) {
        setState(() {
          imgPath = File(pickedImg.path);
          imgName = basename(pickedImg.path);
          int random = Random().nextInt(9999999);
          imgName = "$random$imgName";
          print(imgName);
        });
      } else {
        print("NO img selected");
      }
    } catch (e) {
      print("Error => $e");
    }
    if (!mounted) return;
    Navigator.pop(context);
  }

  showModel() {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(22),
            height: 170,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    await uploadImageToScreen(ImageSource.camera);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.camera,
                      ),
                      SizedBox(
                        width: 11,
                      ),
                      Text("From camera"),
                    ],
                  ),
                ),
                SizedBox(
                  height: 22,
                ),

                GestureDetector(
                  onTap: () async {
                    await uploadImageToScreen(ImageSource.gallery);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.photo_outlined),
                      SizedBox(
                        width: 11,
                      ),
                      Text("From gallery")
                    ],
                  ),
                ),

                // TextButton(
                //     onPressed: () {
                //       Navigator.pop(context);
                //     },
                // child: Text(
                //   "Cancel",
                //   style: TextStyle(fontSize: 22),
                // ))
              ],
            ),
          );
        },
        isScrollControlled: true);
  }

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

      // Upload image to firebase storage
      final storageRef = FirebaseStorage.instance.ref("users_images/$imgName");
      await storageRef.putFile(imgPath!);
      String url = await storageRef.getDownloadURL();

      print(credential.user!.uid);
      CollectionReference users =
          FirebaseFirestore.instance.collection('usersss');

      users
          .doc(credential.user!.uid)
          .set({
            "imglink": url,
            "username": usernameController.text,
            "age": ageController.text,
            "title": titleController.text,
            "email": emailController.text,
            "pass": passwordController.text
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
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
    ageController.dispose();
    titleController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Register",
        ),
        elevation: 0,
        backgroundColor: appbarGreen,
      ),
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
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(125, 78, 91, 110),
                    ),
                    child: Stack(
                      children: [
                        imgPath == null
                            ? CircleAvatar(
                                backgroundColor:
                                    Color.fromARGB(255, 255, 255, 255),
                                backgroundImage:
                                    AssetImage("assets/images/watch1.jpg"),
                                radius: 77,
                              )
                            : ClipOval(
                                child: Image.file(
                                  imgPath!,
                                  width: 145,
                                  height: 145,
                                  fit: BoxFit.cover,
                                ),
                              ),
                        Positioned(
                          left: 95,
                          bottom: -10,
                          child: IconButton(
                            onPressed: () {
                              showModel();
                            },
                            icon: Icon(Icons.add_a_photo),
                            color: Color.fromARGB(255, 94, 115, 126),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 33,
                  ),
                  TextField(
                    controller: usernameController,
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    decoration: decorationTextfield.copyWith(
                      hintText: "Enter your username: ",
                      suffixIcon: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  TextFormField(
                      controller: ageController,
                      keyboardType: TextInputType.number,
                      obscureText: false,
                      decoration: decorationTextfield.copyWith(
                          hintText: "Enter Your age : ",
                          suffixIcon: Icon(Icons.pest_control_rodent))),
                  const SizedBox(
                    height: 22,
                  ),
                  TextFormField(
                      controller: titleController,
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      decoration: decorationTextfield.copyWith(
                          hintText: "Enter Your title : ",
                          suffixIcon: Icon(Icons.person_outline))),
                  const SizedBox(
                    height: 22,
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
                      return value!.length < 8 ? "Enter at least 8 char" : null;
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
                          color:
                              hasSpecialCharacter ? Colors.green : Colors.white,
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
                      if (_formKey.currentState!.validate() &&
                          imgName != null &&
                          imgPath != null) {
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
                            fontSize: 20,
                            decoration: TextDecoration.underline,
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
    );
  }
}
