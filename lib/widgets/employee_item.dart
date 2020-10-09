import 'package:flutter/material.dart';


class EmployeeItem extends StatelessWidget {
  final id;
  final firstName;
  final lastName;
  EmployeeItem({
    @required this.id,
    @required this.firstName,
    @required this.lastName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(id),
            Text(lastName),
            Text(firstName),
          ],
        ),
      ),
    );
  }
}