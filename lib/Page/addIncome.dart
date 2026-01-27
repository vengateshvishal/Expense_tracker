import 'package:expense_tracker/Services/authServices.dart';
import 'package:expense_tracker/Services/dataBase.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddIncome extends StatefulWidget {
  const AddIncome({super.key});

  @override
  State<AddIncome> createState() => _AddIncomeState();
}

class _AddIncomeState extends State<AddIncome> {
  String? Id = authservices.value.currentUser?.uid;

  addIncome() async {
    Map<String, dynamic> addIncome = {
      'amount': amountController.text,
      'date': selectedDate,
    };
    await Database().addUserIncome(addIncome, Id!);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Income Added Successfully")));
  }

  TextEditingController amountController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add Income",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.0),
              Center(
                child: Image(
                  image: AssetImage("Assets/Image/income.png"),
                  height: 200.0,
                  width: 200.0,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                "Enter Amount",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: amountController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some amount';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Amount",
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                ),
              ),
              SizedBox(height: 30.0),
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: Icon(Icons.date_range, color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    DateFormat('dd-MM-yyyy').format(selectedDate),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.0),
              Center(
                child: Material(
                  borderRadius: BorderRadius.circular(60.0),
                  elevation: 5.0,
                  child: GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        addIncome();
                      }
                      setState(() {
                        amountController.clear();
                        selectedDate = DateTime.now();
                      });
                    },
                    child: Container(
                      height: 50.0,
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(60.0),
                      ),
                      child: Center(
                        child: Text(
                          "Submit",
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
      ),
    );
  }
}
