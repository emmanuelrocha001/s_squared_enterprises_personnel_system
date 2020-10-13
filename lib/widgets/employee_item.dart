import 'package:flutter/material.dart';
import '../providers/personnel.dart';
import '../screens/add_employee_screen.dart';
import '../helper.dart';


class Entrie extends StatelessWidget {
  final content;
  Entrie(this.content);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 4),
          alignment: Alignment.centerLeft,
          child: FittedBox(child: Text(content)),
      ),
    );
  }
}

class EmployeeItem extends StatelessWidget {
  final Employee employee;
  EmployeeItem({
    @required this.employee
  });

  void _editEmployee(BuildContext context, String id) {
    Helper.showActionScreen(context, Container(
      child: AddEmployeeScreen(id: id,),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _editEmployee(context, employee.id);
      },

      child: Card(
        margin: EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Entrie(employee.employeeID != '' ? employee.employeeID : employee.id),
              Entrie(this.employee.firstName),
              Entrie(this.employee.lastName),

            ],
          ),
        ),

      ),
    );
  }
}