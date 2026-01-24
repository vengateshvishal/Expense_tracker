import 'package:expense_tracker/Services/authServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Deleteaccount extends StatefulWidget {
  const Deleteaccount({super.key});

  @override
  State<Deleteaccount> createState() => _DeleteaccountState();
}

class _DeleteaccountState extends State<Deleteaccount> {
    String email = "", password = "";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
final _formKey = GlobalKey<FormState>();

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
      body: Container(
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
            SizedBox(height: 30.0),
            Text(
              "Email",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              key: _formKey,
              controller: emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },

              decoration: InputDecoration(
                filled: true,
                hintText: "Enter your email",
                hintStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20.0,),
            Text(
              "Password",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0,),
            TextFormField(
              key: _formKey,
              controller: passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
              decoration: InputDecoration(
                filled: true,
                hintText: "Enter your password",
                hintStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 30.0),
            Center(
              child: Material(
                borderRadius: BorderRadius.circular(60.0),
                elevation: 5.0,
                child: GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {}
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
                        "Delete Account",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
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
    );
  }
}
