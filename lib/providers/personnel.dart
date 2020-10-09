import 'package:flutter/material.dart';


class Employee with ChangeNotifier {
  String id;
  String firstName;
  String lastName;
  String managerId;
  Employee({
    @required this.id,
    @required this.firstName,
    @required this.lastName,
    @required this.managerId,

  });

}

class Personnel with ChangeNotifier{
  List<Employee> _employees = [
    Employee(firstName: 'Jack', lastName: 'Robertson', id: '1', managerId: '2'),
    Employee(firstName: 'Jack', lastName: 'Robertson', id: '2', managerId: '2'),
    Employee(firstName: 'Jack', lastName: 'Robertson', id: '3', managerId: '2'),
    Employee(firstName: 'Jack', lastName: 'Robertson', id: '4', managerId: '2'),
    Employee(firstName: 'Jack', lastName: 'Robertson', id: '5', managerId: '2'),
    Employee(firstName: 'Jack', lastName: 'Robertson', id: '6', managerId: '2'),
    Employee(firstName: 'Jack', lastName: 'Robertson', id: '7', managerId: '2'),
    Employee(firstName: 'Jack', lastName: 'Robertson', id: '8', managerId: '2'),
    Employee(firstName: 'Jack', lastName: 'Robertson', id: '9', managerId: '2'),
    Employee(firstName: 'Jack', lastName: 'Robertson', id: '10', managerId: '2'),
    Employee(firstName: 'Jack', lastName: 'Robertson', id: '11', managerId: '2'),
      Employee(firstName: 'Jack', lastName: 'Robertson', id: '2', managerId: '2'),
    Employee(firstName: 'Jack', lastName: 'Robertson', id: '3', managerId: '2'),
    Employee(firstName: 'Jack', lastName: 'Robertson', id: '4', managerId: '2'),
    Employee(firstName: 'Jack', lastName: 'Robertson', id: '5', managerId: '2'),
    Employee(firstName: 'Jack', lastName: 'Robertson', id: '6', managerId: '2'),
    Employee(firstName: 'Jack', lastName: 'Robertson', id: '7', managerId: '2'),
    Employee(firstName: 'Jack', lastName: 'Robertson', id: '8', managerId: '2'),
    Employee(firstName: 'Jack', lastName: 'Robertson', id: '9', managerId: '2'),
    Employee(firstName: 'Jack', lastName: 'Robertson', id: '10', managerId: '2'),
    Employee(firstName: 'Jack', lastName: 'Robertson', id: '11', managerId: '2'),

  ];
  List<String> _managers = ['Todd', 'Robbert', 'Jackson'];

  String _selectedManager = '';


  void setSelectedManager(String newValue) {
    _selectedManager = newValue;
    // call backend
    print('new manager selected: $_selectedManager');
  }


  List<Employee> get employees {
    return [..._employees];
  }

  List<String> get managers {
    return [..._managers];
  }

  Future<Map<String,dynamic>> addEmployee({String managerId, String firstName, String lastName, List<String> roles}) async {
    // check if maneger role is present

  }

  Future<Map<String,dynamic>> fetchManagers() async {

  }

  Future<Map<String,dynamic>> fetchEmployees() async {

  }




}
