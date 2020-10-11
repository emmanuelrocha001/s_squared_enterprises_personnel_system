import 'package:flutter/material.dart';
import '../providers/personnel.dart';


class Entrie extends StatelessWidget {
  final content;
  Entrie(this.content);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
          alignment: Alignment.centerLeft,
          child: Text(content),
      ),
    );
  }
}
class EmployeeItem extends StatelessWidget {
  final Employee employee;
  EmployeeItem({
    @required this.employee
  });

  @override
  Widget build(BuildContext context) {
    print(employee);
    return Card(
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
    );
  }
}