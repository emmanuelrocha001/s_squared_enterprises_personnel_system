import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Employee with ChangeNotifier {
  String id;
  String employeeID;
  String firstName;
  String lastName;
  String managerID;
  Employee({
    @required this.id,
    @required this.employeeID,
    @required this.firstName,
    @required this.lastName,
    @required this.managerID,
  });
}

class Personnel with ChangeNotifier{

  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  final baseURL = 'https://test-backend-eb284.firebaseio.com/';

  List<Employee> _employees = [];
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

  Future<Map<String,dynamic>> addEmployee({String managerID, String employeeID, String firstName, String lastName, List<String> roles}) async {
    // check if maneger role is present
    try {
      final url = '$baseURL/personnel.json';

      final response = await http.post(
        url,
        body: json.encode({
          'employeeID': employeeID,
          'managerID': managerID,
          'firstName': firstName,
          'lastName': lastName,
          'roles': ['IT'],
        }),
      );

      final data = json.decode(response.body);
      print(employeeID.length);
      print('doc id');
      print(data);
      _employees.add(
        new Employee(id: data['name'], employeeID: employeeID, firstName: firstName, lastName: lastName, managerID: managerID),
      );

      notifyListeners();

      return {
        'success': true,
      };

    }catch(error) {
      return {
        'success': false
      };
    }



  }

  Future<Map<String,dynamic>> fetchManagers() async {

  }

  Future<Map<String,dynamic>> fetchPersonnel() async {
// check if maneger role is present
    try {
      final url = '$baseURL/personnel.json';

      final response = await http.get(
        url,
      );
      print(json.decode(response.body));

      final data = json.decode(response.body) as Map<String,dynamic>;
      final temp = [];
      data.forEach((key, value) {
        // check if
        var current = value as Map<String,dynamic>;
        temp.add(
          new Employee(
            id: key,
            employeeID: current.containsKey('employeeID') ? current['employeeID'] : '',
            firstName: current['firstName'],
            lastName: current['lastName'],
            managerID: current['managerID']
          ),
        );
      });
      print('doc id');
      print(data);
      _employees = [...temp];
      notifyListeners();

      return {
        'success': true,
      };

    }catch(error) {
      // print(error);
      return {
        'success': false
      };
    }
  }




}
