
import 'dart:math' as Math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/personnel.dart';
import '../widgets/employee_item.dart';
import '../widgets/role_selector.dart';

class EmployeeList extends StatefulWidget {


  @override
  _EmployeeListState createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  List<Employee> employees = [];
  ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    new Future.delayed(new Duration(seconds: 0), fetchEmployees);
  }

  void fetchEmployees() async {
    setState(() {
      employees = Provider.of<Personnel>(context, listen: false).employees;
    });
  }

  @override
  Widget build(BuildContext context) {

    final personnel = Provider.of<Personnel>(context);
    final employees = personnel.employees;
    final mediaQuery = MediaQuery.of(context);
    return Container(
      width: mediaQuery.size.width,
      color: Colors.grey.withOpacity(.1),
      child: Container(
        width: Math.min(600, mediaQuery.size.width),
        child: Column(
          children: [
            Container(
              width: Math.min(600, mediaQuery.size.width),

              child: Card(

                margin: EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Entrie('Employee ID'),
                      Entrie('Last Name'),
                      Entrie('First Name'),
                    ],
                  ),
                ),
              ),
            ),

            Container(
              width: Math.min(600, mediaQuery.size.width),
              height: 400,
              child: Scrollbar(
                child: ListView.builder(
                controller: _controller,
                  // controller: ,
                  itemCount: employees.length,
                  itemBuilder: (context,index) => EmployeeItem(
                    employee: employees[index],
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