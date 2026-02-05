import 'package:expense_tracker/Page/onBoardScreen.dart';
import 'package:expense_tracker/Services/authServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Deleteaccount extends StatefulWidget {
  const Deleteaccount({super.key});

  @override
  State<Deleteaccount> createState() => _DeleteaccountState();
}

class _DeleteaccountState extends State<Deleteaccount> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  deleteAccount() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Delete Account',
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.purple,
              fontWeight: FontWeight.w500,
            ),
          ),
          content: Text(
            "You ant delete your account permantely",
            style: TextStyle(fontSize: 15.0),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel", style: TextStyle(fontSize: 16.0)),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                try {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Onboardscreen()),
                  );
                  await authservices.value.deletedAccount(
                    email: emailController.text,
                    password: passwordController.text,
                  );
                } on FirebaseAuthException catch (e) {
                  String errorMessage = 'An error occurred';

                  if (e.code == 'user-not-found') {
                    errorMessage = 'No user found for that email.';
                  } else if (e.code == 'wrong-password') {
                    errorMessage = 'Wrong password provided for that user.';
                  } else if (e.code == 'invalid-email') {
                    errorMessage = 'Invalid email address.';
                  } else if (e.code == 'user-disabled') {
                    errorMessage = 'This user account has been disabled.';
                  } else if (e.code == 'network-request-failed') {
                    errorMessage =
                        'Network error. Please check your connection.';
                  } else {
                    errorMessage =
                        e.message ?? 'An error occurred during delete.';
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text(errorMessage),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 4),
                    ),
                  );
                }
              },
              child: Text(
                'Delete Permantely',
                style: TextStyle(fontSize: 15.0, color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Delete Account",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.0),
              Center(
                child: Image(
                  image: AssetImage("Assets/Image/delete.png"),
                  height: 200,
                  width: 200,
                ),
              ),
              Container(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.0),
                        Text(
                          "Email",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          controller: emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your email";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            hintText: "Enter your email",
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          "Password",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your email";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            hintText: "Enter your password",
                          ),
                        ),
                        SizedBox(height: 30.0),
                        Center(
                          child: Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(60.0),
                            child: GestureDetector(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  deleteAccount();
                                }
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2.5,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  color: Colors.purple,
                                  borderRadius: BorderRadius.circular(60.0),
                                ),
                                child: Center(
                                  child: Text(
                                    "Delete",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
