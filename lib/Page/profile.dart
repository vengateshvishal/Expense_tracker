import 'package:expense_tracker/Page/addExpense.dart';
import 'package:expense_tracker/Page/addIncome.dart';
import 'package:expense_tracker/Page/deleteAccount.dart';
import 'package:expense_tracker/Services/authLayout.dart';
import 'package:expense_tracker/Services/authServices.dart';
import 'package:expense_tracker/Widgets/profileCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<void> logOut() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap a button to dismiss
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Logout',
            style: TextStyle(
              color: Colors.purple,
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          content: const Text(
            'Do you really want to logout?',
            style: TextStyle(fontSize: 15.0),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel',style: TextStyle(fontSize: 16.0),),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
            TextButton(
              child: const Text('Logout', style: TextStyle(color: Colors.red,fontSize: 16.0)),
              onPressed: () async {
                Navigator.of(context).pop(); // Dismiss the dialog
                try {
                  // Call the existing sign out service
                  await authservices.value.signOut();

                  // Ensure page changes by clearing the navigation stack
                  if (mounted) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AuthLayout(),
                      ),
                      (route) => false,
                    );
                  }
                } on FirebaseAuthException catch (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
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
        centerTitle: true,
        title: Text(
          "Profile",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 30.0),
            Center(
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(70.0),
                  child: Image(
                    image: AssetImage('Assets/Image/9434619.jpg'),
                    height: 120,
                    width: 120,
                  ),
                ),
              ),
            ),
            SizedBox(height: 50.0),
            Profilecard1(icon: Icons.person, label: "Name", value: "Vishal"),
            SizedBox(height: 30.0),
            Profilecard1(
              icon: Icons.email,
              label: "Email",
              value: "vengateshvishal12@gmail.com",
            ),
            SizedBox(height: 30.0),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Addexpense()),
                );
              },
              child: ProfileCard2(icon: Icons.wallet, label: "Add Expense"),
            ),
            SizedBox(height: 30.0),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddIncome()),
                );
              },
              child: ProfileCard2(
                icon: Icons.attach_money,
                label: "Add Income",
              ),
            ),
            SizedBox(height: 30.0),
            GestureDetector(
              onTap: () {
                logOut();
              },
              child: ProfileCard2(icon: Icons.logout, label: "LogOut"),
            ),
            SizedBox(height: 30.0),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Deleteaccount()));
              },
              child: ProfileCard2(icon: Icons.delete, label: "Delete Account"),
            ),
          ],
        ),
      ),
    );
  }
}
