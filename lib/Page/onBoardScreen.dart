import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Onboardscreen extends StatelessWidget {
  const Onboardscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 250, 222, 255),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 70.0),
            SvgPicture.asset('Assets/svg/Credit assesment-amico.svg'),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50.0),
                ),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    SizedBox(height: 30.0),
                    Text(
                      "Manage your daily\nlife expense",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                      child: Text(
                        "Expense tracker is a simple and efficient personal finance management app that allows you to track your daily expenses and income.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color.fromARGB(147, 0, 0, 0),
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 40.0),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 40.0),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(60.0),
                        child: Container(
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(60.0),
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: Text(
                              "Get Started",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
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
          ],
        ),
      ),
    );
  }
}
