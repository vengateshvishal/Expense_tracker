import 'package:expense_tracker/Page/profile.dart';
import 'package:expense_tracker/Services/authServices.dart';
import 'package:expense_tracker/Services/dataBase.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../Widgets/legend_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String id = authservices.value.currentUser!.uid;
  int userExpense = 0;
  int userIncome = 0;
  double userFoodExpense = 0;
  double userTransportExpense = 0.0;
  double userOtherExpense = 0.0;
  String dashBoardData = "Overall Expense";

  getDashBoardDetails() {
    getUsername();
    getExpense();
    getFoodExpense();
    getTransportExpense();
    getOthersExpense();
    userAnnualData();
    getIncome();
  }

  getIncome() async {
    int totalIncome = 0;
    var incomeData = await Database().getUserIncome(id);
    for (var i = 0; i < incomeData.length; i++) {
      totalIncome += int.parse(incomeData[i]['amount']);
    }
    setState(() {
      userIncome = totalIncome;
    });
  }

  getMonthlyIncome() async {
    int tempIncome = 0;
    var incomeData = await Database().getUserIncome(id);
    String currentMonth = DateFormat('MM').format(DateTime.now());
    for (var entry in incomeData) {
      String entryMonth = DateFormat(
        'MM',
      ).format(DateTime.parse(entry['date']));
      if (entryMonth == currentMonth) {
        tempIncome += int.parse(entry['amount'].toString());
      }
    }
    setState(() {
      userIncome = tempIncome;
    });
  }

  getAnnualIncome() async {
    int tempIncome = 0;
    var incomeData = await Database().getUserIncome(id);
    String currentYear = DateFormat('yyy').format(DateTime.now());
    for (var entry in incomeData) {
      String entryYear = DateFormat(
        'yyy',
      ).format(DateTime.parse(entry['date']));
      if (entryYear == currentYear) {
        tempIncome += int.parse(entry['amount'].toString());
      }
    }
    setState(() {
      userIncome = tempIncome;
    });
  }

  Future<void> userAnnualData() async {
    int tempExpense = 0;
    double tempFood = 0;
    double tempTransport = 0;
    double tempOthers = 0;
    final List userDateDetails = await Database().getUserExpense(id);
    String currentYear = DateFormat('yyy').format(DateTime.now());

    for (var entry in userDateDetails) {
      String entryYear = DateFormat(
        'yyy',
      ).format(DateTime.parse(entry['date']));
      if (entryYear == currentYear) {
        tempExpense += int.parse(entry['amount'].toString());
        List temp = [];
        temp.add(entry['category']);
        for (var i = 0; i < temp.length; i++) {
          if (temp[i] == 'Food') {
            tempFood += double.parse(entry['amount']);
          } else if (temp[i] == 'Transport') {
            tempTransport += double.parse(entry['amount']);
          } else if (temp[i] == 'Others') {
            tempOthers += double.parse(entry['amount']);
          }
        }
      }
    }
    setState(() {
      userExpense = tempExpense;
      userFoodExpense = tempFood;
      userTransportExpense = tempTransport;
      userOtherExpense = tempOthers;
      dashBoardData = DateFormat('yyy').format(DateTime.now());
    });
  }

  Future<void> userMonthlyData() async {
    final List userDateDetails = await Database().getUserExpense(id);
    String currentMonth = DateFormat('MM').format(DateTime.now());

    int tempExpense = 0;
    double tempFood = 0;
    double tempTransport = 0;
    double tempOthers = 0;

    for (var entry in userDateDetails) {
      String entryMonth = DateFormat(
        'MM',
      ).format(DateTime.parse(entry['date']));
      if (entryMonth == currentMonth) {
        tempExpense += int.parse(entry['amount'].toString());
        List temp = [];
        temp.add(entry['category']);
        for (var i = 0; i < temp.length; i++) {
          if (temp[i] == 'Food') {
            tempFood += double.parse(entry['amount']);
          } else if (temp[i] == 'Transport') {
            tempTransport += double.parse(entry['amount']);
          } else if (temp[i] == 'Others') {
            tempOthers += double.parse(entry['amount']);
          }
        }
      }
    }
    setState(() {
      userExpense = tempExpense;
      userFoodExpense = tempFood;
      userTransportExpense = tempTransport;
      userOtherExpense = tempOthers;
      dashBoardData = DateFormat('MMMM').format(DateTime.now());
    });
  }

  getOthersExpense() async {
    double totalOtherExpense = 0;
    var otherExpense = await Database().getUserExpenseByCategory(id, 'Others');
    for (var i = 0; i < otherExpense.length; i++) {
      totalOtherExpense += int.parse(otherExpense[i]['amount']);
    }
    setState(() {
      userOtherExpense = totalOtherExpense;
    });
  }

  getTransportExpense() async {
    double totalTransportExpense = 0;
    var transportExpense = await Database().getUserExpenseByCategory(
      id,
      'Transport',
    );
    for (var i = 0; i < transportExpense.length; i++) {
      totalTransportExpense += int.parse(transportExpense[i]['amount']);
    }
    setState(() {
      userTransportExpense = totalTransportExpense;
    });
  }

  getFoodExpense() async {
    double totalFoodExpense = 0;
    var foodExpense = await Database().getUserExpenseByCategory(id, 'Food');
    for (var i = 0; i < foodExpense.length; i++) {
      totalFoodExpense += int.parse(foodExpense[i]['amount']);
    }
    setState(() {
      userFoodExpense = totalFoodExpense;
    });
  }

  getExpense() async {
    int totalExpense = 0;
    var expenseData = await Database().getUserExpense(id);
    for (var i = 0; i < expenseData.length; i++) {
      totalExpense += int.parse(expenseData[i]['amount']);
    }

    setState(() {
      userExpense = totalExpense;
    });
  }

  @override
  // ignore: must_call_super
  initState() {
    getDashBoardDetails();
  }

  String? userName;

  void getUsername() async {
    final userDetails = await Database().getUserDetails(id);
      String localName = userDetails['name'];
    setState(() {
      userName=localName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome Back",
                      style: TextStyle(
                        color: const Color.fromARGB(136, 0, 0, 0),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      userName != null ? "$userName" : "User",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Profile()),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60.0),
                    child: Image(
                      image: AssetImage("Assets/Image/9434619.jpg"),
                      height: 60,
                      width: 60,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.0),
            Text(
              "Manage your\nexpense",
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Container(
              padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.0),
                borderRadius: BorderRadius.circular(20.0),
              ),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Expenses",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "\$${userExpense}",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 221, 78, 68),
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    dashBoardData,
                    style: TextStyle(
                      color: const Color.fromARGB(136, 0, 0, 0),
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 170,
                        width: 150,
                        child: Builder(
                          builder: (context) {
                            final sections = [
                              {'value': userFoodExpense, 'color': Colors.red},
                              {
                                'value': userTransportExpense,
                                'color': Colors.blue,
                              },
                              {
                                'value': userOtherExpense,
                                'color': Colors.orange,
                              },
                            ];
                            final total = sections.fold<double>(
                              0,
                              (sum, section) =>
                                  sum + (section['value'] as double),
                            );

                            return PieChart(
                              PieChartData(
                                sections: List.generate(sections.length, (
                                  index,
                                ) {
                                  final value =
                                      sections[index]['value'] as double;
                                  final percentage = ((value / total) * 100)
                                      .toStringAsFixed(0);

                                  return PieChartSectionData(
                                    value: value,
                                    color: sections[index]['color'] as Color,
                                    radius: 50,
                                    title: '$percentage%',
                                    titleStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  );
                                }),
                              ),
                            );
                          },
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LegendItem(
                            color: Colors.red,
                            amount: "Food",
                            price: "\$${userFoodExpense.toInt()}",
                          ),
                          SizedBox(height: 10.0),
                          LegendItem(
                            color: Colors.blue,
                            amount: "Transport",
                            price: "\$${userTransportExpense.toInt()}",
                          ),

                          SizedBox(height: 10.0),
                          LegendItem(
                            color: Colors.orange,
                            amount: "Other",
                            price: "\$${userOtherExpense.toInt()}",
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Row(),
                ],
              ),
            ),
            SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    userMonthlyData();
                    getMonthlyIncome();
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2.5,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(60.0),
                    ),
                    child: Center(
                      child: Text(
                        "This Month",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                Material(
                  borderRadius: BorderRadius.circular(60.0),
                  elevation: 5.0,
                  child: GestureDetector(
                    onTap: () {
                      userAnnualData();
                      getAnnualIncome();
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 2.5,
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(60.0),
                      ),
                      child: Center(
                        child: Text(
                          "This Year",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.all(10.0),
                  width: MediaQuery.of(context).size.width / 2.5,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Income",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        "+\$$userIncome",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Container(
                        height: 10,
                        width: MediaQuery.of(context).size.width / 3.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  width: MediaQuery.of(context).size.width / 2.5,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Expenses",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        '-\$$userExpense',
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Container(
                        height: 10,
                        width: MediaQuery.of(context).size.width / 3.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: const Color.fromARGB(255, 240, 93, 93),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.0),
            Container(
              height: 80,
              padding: EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(60.0),
                    ),
                    child: Image(
                      image: AssetImage('Assets/Image/like.png'),
                      height: 30,
                      width: 30,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 20.0),
                  Text(
                    "Your expense plan looks good",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
