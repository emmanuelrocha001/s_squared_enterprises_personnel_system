
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/personnel.dart';
import '../widgets/employee_item.dart';
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
    // var res = await Provider.of<Personnel>(context, listen: false).employees;
    // if(res['success']) {
    //   employees = res['employees'];
    // } else {
    //   print('something went wrong');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: 400,
      child: Column(
        children: [
          Card(
            margin: EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Employee ID'),
                  Text('Last Name'),
                  Text('First Name'),
                ],
              ),
            ),
          ),

          Container(
            width: 400,
            height: 400,
            child: Scrollbar(
              child: ListView.builder(
              controller: _controller,
                // controller: ,
                itemCount: employees.length,
                itemBuilder: (context,index) => EmployeeItem(
                  id: employees[index].id,
                  firstName: employees[index].firstName,
                  lastName: employees[index].lastName,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}