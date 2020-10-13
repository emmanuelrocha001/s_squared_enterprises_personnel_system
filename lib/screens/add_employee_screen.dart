import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/personnel.dart';
import '../widgets/manager_selector.dart';
import '../widgets/role_selector.dart';

import '../helper.dart';

class AddEmployeeScreen extends StatefulWidget {
  final id;
  AddEmployeeScreen({this.id=''});

  @override
  _AddEmployeeScreenState createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {

  var _employeeInfo = {
    'firstName': '',
    'lastName': '',
    'employeeID': '',
    'roles': [],
    'managerID': '',
  };
  var _generateID = true;
  var _managerName = '';
  List<String> _rolesSelected = [];
  final _form = GlobalKey<FormState>();

  void setRolesSelected(List<String> roles) {
    _rolesSelected = [...roles];
  }


  @override
  void initState() {
    super.initState();
    // set initial values if available
    if(widget.id != '') {
      var employeeInfo = Provider.of<Personnel>(context, listen: false).getEmployeeByID(widget.id);
      if(_employeeInfo['managerID'] != '') {
        _managerName = Provider.of<Personnel>(context, listen: false).getMangerNameByID(widget.id);
      }
      setState(() {
        _employeeInfo['firstName'] = employeeInfo.firstName;
        _employeeInfo['lastName'] = employeeInfo.lastName;
        _employeeInfo['employeeID'] = employeeInfo.employeeID;
        _employeeInfo['managerID'] = employeeInfo.managerID;
        _employeeInfo['roles'] = employeeInfo.roles;
        setRolesSelected(employeeInfo.roles);
        if(_employeeInfo['managerID'] != '') {
          _managerName = Provider.of<Personnel>(context, listen: false).getMangerNameByID(_employeeInfo['managerID']);
        }
      });
    }
  }

  void addEmployee() async {
    final isValid = _form.currentState.validate();
    if(isValid) {
      if(_rolesSelected.length < 1) {
        Helper.showMessageTop(context, 'An Employee must be assigned at least 1 role.',error: true);
        return;
      }

      _form.currentState.save();

      // an employee must be assigned a manager(unless they have a director role)
      if(_employeeInfo['managerID'] == '' && !_rolesSelected.contains('Director')) {
        Helper.showMessageTop(context, 'Please select a Manager.',error: true);
        return;
      }

      // employee id cannot be reused(only check if ID is not automatically generated);
      if(_employeeInfo['employeeID'] != '' && !_generateID) {
        var available = Provider.of<Personnel>(context, listen: false).isIDAvailable(_employeeInfo['employeeID']);
        if(!available) {
          Helper.showMessageTop(context, 'Employee ID is not available.',error: true);
          return;
        }
      }

      final res = await Provider.of<Personnel>(context, listen: false).addEmployee(
        firstName: (_employeeInfo['firstName'] as String).replaceAll(new RegExp(r"\s+"), ""),
        lastName: (_employeeInfo['lastName'] as String).replaceAll(new RegExp(r"\s+"), ""),
        employeeID: _generateID ? '' : _employeeInfo['employeeID'],
        managerID: _employeeInfo['managerID'],
        rolesSelected: _rolesSelected,
      );

      if(res['success']) {
        Navigator.of(context).pop({
          'message': '${_employeeInfo['firstName']} has been added to the system.',
          'error': false,
        });
      } else {
        Navigator.of(context).pop({
          'message': 'something went wrong, unable to add employee to system.',
          'error': true,
        });
      }
    }
  }

  void editEmployee() async{
    final isValid = _form.currentState.validate();
    if(isValid) {
      if(_rolesSelected.length < 1) {
        Helper.showMessageTop(context, 'An Employee must be assigned at least 1 role.',error: true);
        return;
      }

      _form.currentState.save();


      final res = await Provider.of<Personnel>(context, listen: false).updateEmployee(
        id: widget.id,
        firstName: (_employeeInfo['firstName'] as String).replaceAll(new RegExp(r"\s+"), ""),
        lastName: (_employeeInfo['lastName'] as String).replaceAll(new RegExp(r"\s+"), ""),
        rolesSelected: _rolesSelected,
      );

      if(res['success']) {
        Navigator.of(context).pop({
          'message': '${_employeeInfo['firstName']}\'s info has been updated.',
          'error': false,
        });
      } else {
        Navigator.of(context).pop({
          'message': 'something went wrong, unable to add employee to system.',
          'error': true,
        });
      }
    }

  }

  void setManager(BuildContext context, String manager) {
    setState(() {
      _employeeInfo['managerID'] = manager;
    });
  }

  @override
  Widget build(BuildContext context) {
    final styleTheme = Theme.of(context);
    print('building employee form');
    print(_employeeInfo);
    return Form(
      key: _form,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 400,
              child: ListTile(
                leading: Text(widget.id == '' ? 'Add Employee' : 'Edit Employee', style: TextStyle( color: Colors.black, fontSize: 18)),
              ),
            ),
            Divider(),
            widget.id == '' ?
              ManagerSelector(setValue: setManager,) :
              Container(
                width: 400,
                child: ListTile(
                  leading: Text('Manager: ${_managerName}', style: TextStyle( color: Colors.grey[600], fontSize: 16)),
                ),
              ),
            widget.id == '' ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 300,
                child: CheckboxListTile(
                  value: _generateID,
                  title: const Text('Auto generate Employee ID'),
                  subtitle: const Text('* will disable Employee ID input field'),
                  onChanged: (bool value) {
                    setState(() {
                      _generateID = value;
                    });
                  }
                )
                ,
              ),
            ) : Container(
              width: 400,
              child: ListTile(
                leading: Text('Employee ID: ${_employeeInfo['employeeID'] == '' ? widget.id : _employeeInfo['employeeID']}', style: TextStyle( color: Colors.grey[600], fontSize: 16)),
              ),
            ),
            if(widget.id == '') Container(
              width: 400,
              child: ListTile(
                key: ValueKey('employee_id_input'),
                // leading: Icon(Icons.mail, size: 35, color: styleTheme.primaryColor,),
                leading: Text('Employee ID:', style: TextStyle( color: Colors.grey[600], fontSize: 16)),
                title: TextFormField(
                  // textInputAction: TextInputAction.next,
                  // keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.always,
                  enabled: !_generateID,

                  initialValue: _employeeInfo['employeeID'],
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) {
                    // FocusScope.of(context).requestFocus(_otherNode);
                  },
                  // autovalidate: true,
                  onSaved: (value) {
                    _employeeInfo['employeeID'] = value;
                  },
                  validator: (value) {
                    if(value.isEmpty && !_generateID) {
                      return '* Required Field';
                    } else {
                      return null;
                    }
                  },

                ),
              ),
            ),

            Container(
              width: 400,
              child: ListTile(
                // leading: Icon(Icons.mail, size: 35, color: styleTheme.primaryColor,),
                leading: Text('First Name:', style: TextStyle( color: Colors.grey[600], fontSize: 16)),
                title: TextFormField(
                  // textInputAction: TextInputAction.next,
                  // keyboardType: TextInputType.emailAddress,
                  key: ValueKey('employee_first_name_input'),
                  autovalidateMode: AutovalidateMode.always,


                  initialValue: _employeeInfo['firstName'],
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) {
                    // FocusScope.of(context).requestFocus(_otherNode);
                  },
                  // autovalidate: true,
                  onSaved: (value) {
                    _employeeInfo['firstName'] = value;
                  },
                  validator: (value) {
                    if(value.isEmpty) {
                      return '* Required Field';
                    } else {
                      return null;
                    }
                  },

                  // decoration: InputDecoration(
                  //   border: InputBorder.none,
                  //   hintText: 'ex: Jackson',
                  //   hintStyle: TextStyle( color: Colors.grey, fontSize: 16),


                  // ),
                ),
              ),
            ),

            Container(
              width: 400,
              child: ListTile(
                // leading: Icon(Icons.mail, size: 35, color: styleTheme.primaryColor,),
                leading: Text('Last Name:', style: TextStyle( color: Colors.grey[600], fontSize: 16)),
                title: TextFormField(
                  initialValue: _employeeInfo['lastName'],
                  key: ValueKey('employee_last_name_input'),
                  autovalidateMode: AutovalidateMode.always,

                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) {
                    // FocusScope.of(context).requestFocus(_otherNode);
                  },
                  // autovalidate: true,
                  onSaved: (value) {
                    _employeeInfo['lastName'] = value;
                  },
                  validator: (value) {
                    if(value.isEmpty) {
                      return '* Required Field';
                    } else {
                      return null;
                    }
                  },

                ),
              ),
            ),
            Container(
              width: 400,
              child: ListTile(
                  leading: Text('Roles:', style: TextStyle( color: Colors.grey[600], fontSize: 16)),
              ),
            ),
            Container(
              width: 300,
              height: 300,
              color: Colors.grey.withOpacity(.10),
              child: widget.id == '' ? RoleSelector(setRolesSelected: setRolesSelected,) : RoleSelector(setRolesSelected: setRolesSelected, initialRoles: _employeeInfo['roles'],) ,
            ),
            Divider(),

            Container(
              width: 400,
              margin: EdgeInsets.all(20),
              child: ListTile(
                leading: FlatButton(
                  child: Text('Save', style: TextStyle(color: Colors.green),),
                  onPressed: () {
                    if(widget.id == '') {
                      addEmployee();
                    } else {
                      editEmployee();
                    }
                  },
                ),
                trailing: FlatButton(
                  child: Text('Cancel', style: TextStyle(color: Colors.red),),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}