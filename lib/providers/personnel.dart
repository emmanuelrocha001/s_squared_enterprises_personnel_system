import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Employee with ChangeNotifier {
  String id;
  String employeeID;
  String firstName;
  String lastName;
  String managerID;
  List<String> roles;
  Employee({
    @required this.id,
    @required this.employeeID,
    @required this.firstName,
    @required this.lastName,
    @required this.managerID,
    @required this.roles,
  });
}

class Personnel with ChangeNotifier{

  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  final baseURL = 'https://test-backend-eb284.firebaseio.com/';
  // final projectID = 'test-backend-eb284';
  // var baseURL = 'https://firestore.googleapis.com/v1/projects/test-backend-eb284/databases/(default)/documents';

  List<Employee> _employees = [];
  List<Employee> _personnel = [];
  List<Employee> _managers = [];
  List<String> _roles = ['Director','Support', 'IT', 'Analyst','Sales', 'Accounting'];

  String _selectedManager = '';



  List<Employee> get personnel {
    return [..._personnel];
  }


  List<Employee> get employees {
    return [..._employees];
  }

  List<Employee> get managers {
    return [..._managers];
  }


  List<String> get roles {
    return [..._roles];
  }

  Employee getEmployeeByID(String id) {
    int index = _employees.indexWhere((element) => element.id == id);
    return _employees[index];
  }

  String getMangerNameByID(String id) {
    int index = _managers.indexWhere((element) => element.id == id);
    return '${_managers[index].firstName} ${_managers[index].lastName}';
  }

  bool isIDAvailable(String id) {
    var index = _personnel.indexWhere((element) => element.employeeID == id);
    if(index == -1) {
      return true;
    } else {
      return false;
    }
  }

  void setSelectedManager(String newValue) {
    if(newValue != _selectedManager) {
      print('new manager selected: $_selectedManager');

      _selectedManager = newValue;
      fetchPersonnel();
    }
    // call backend
  }

  Future<Map<String,dynamic>> addEmployee({String managerID, String employeeID, String firstName, String lastName, List<String> rolesSelected}) async {
    try {
      final url = '$baseURL/personnel.json';
      final response = await http.post(
        url,
        body: json.encode({
          'employeeID': employeeID,
          'managerID': managerID,
          'firstName': firstName,
          'lastName': lastName,
          'roles': rolesSelected,
        }),
      );
      print(response);

      final data = json.decode(response.body);
      print(employeeID.length);
      print('doc id');
      print(data);
      fetchPersonnel();
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


  Future<Map<String,dynamic>> updateEmployee({String id,String firstName, String lastName, List<String> rolesSelected}) async {
     // check if manager role is present
    try {
      final url = '$baseURL/personnel/$id.json';

      final response = await http.patch(
        url,
        body: json.encode({
          'firstName': firstName,
          'lastName': lastName,
          'roles': rolesSelected,
        }),
      );
      print('employee info retrieved');

      final data = json.decode(response.body);
      print(data);
      // print(employeeID.length);
      print('doc id');
      print(data);
      fetchPersonnel();
      notifyListeners();

      return {
        'success': true,
      };

    }catch(error) {
      print(error);
      return {
        'success': false
      };
    }
  }


  Future<Map<String,dynamic>> fetchPersonnel() async {
    // check if maneger role is present
    print('fetching personnel');
    try {
      final url = '$baseURL/personnel.json';

      final response = await http.get(
        url,
      );

      final data = json.decode(response.body) as Map<String,dynamic>;
      if(data != null) {
        final temp = [];
        var tempPersonnel = [];

        List<Employee> tempManagers = [
          new Employee(id: '', employeeID: '', firstName: '', lastName: '', managerID: '', roles: [])
        ];

        data.forEach((key, value) {
          //
          var current = value as Map<String,dynamic>;

          // store personnel(to check employee ID is not duplicate)
          tempPersonnel.add(
            new Employee(
                id: key,
                employeeID: current.containsKey('employeeID') ? current['employeeID'] : '',
                firstName: current['firstName'],
                lastName: current['lastName'],
                managerID: current['managerID'],
                roles: [...current['roles']],
              ),
          );

          // separates managers from employees
          var current_roles = [...current['roles']];
          if(current_roles.contains('Director')) {
            tempManagers.add(
              new Employee(
                id: key,
                employeeID: current.containsKey('employeeID') ? current['employeeID'] : '',
                firstName: current['firstName'],
                lastName: current['lastName'],
                managerID: current['managerID'],
                roles: [...current['roles']],
              ),
            );
          }

          if(current['managerID'] == _selectedManager) {
            temp.add(
              new Employee(
                id: key,
                employeeID: current.containsKey('employeeID') ? current['employeeID'] : '',
                firstName: current['firstName'],
                lastName: current['lastName'],
                managerID: current['managerID'],
                roles: [...current['roles']],
              ),
            );
          }
        });
        _managers = [...tempManagers];
        _employees = [...temp];
        _personnel = [...tempPersonnel];
        print(_personnel);
        notifyListeners();
      }
      return {
        'success': true,
      };
    }catch(error) {
      print(error);
      return {
        'success': false
      };
    }
  }




}
