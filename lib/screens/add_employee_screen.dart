import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/personnel.dart';
import '../widgets/manager_selector.dart';
import '../helper.dart';

class AddEmployeeScreen extends StatefulWidget {
  @override
  _AddEmployeeScreenState createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {

  var _newEmployeeInfo = {
    'firstName': '',
    'lastName': '',
    'employeeID': '',
    'roles': [],
    'managerID': '',
  };
  var _generateID = true;

  final _form = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
    // set to firs value if available
    List<String> managerList  = Provider.of<Personnel>(context, listen: false).managers;
    if(managerList.length > 0) {
      _newEmployeeInfo['managerID'] = Provider.of<Personnel>(context, listen: false).managers[0];
      print(_newEmployeeInfo);
    }
  }

  void addEmployee() async {
    final isValid = _form.currentState.validate();
    if(isValid) {
      _form.currentState.save();
      print(_newEmployeeInfo);

      final res = await Provider.of<Personnel>(context, listen: false).addEmployee(
        firstName: _newEmployeeInfo['firstName'],
        lastName: _newEmployeeInfo['lastName'],
        employeeID: _newEmployeeInfo['employeeID'],
        managerID: _newEmployeeInfo['managerID'],
        roles: [],
      );

      if(res['success']) {
        Navigator.of(context).pop({
          'message': '${_newEmployeeInfo['firstName']} has been added to the system.',
          'error': false,
        });

      } else {
        Navigator.of(context).pop({
          'message': 'something went wrong, unable to add employee to system.',
          'error': true,
        });
      }
    } else {
      Helper.showMessageTop(context, 'Please make sure all required filles are filled in',error: true);
    }
  }

  void setManager(BuildContext context, String manager) {
    setState(() {
      _newEmployeeInfo['managerID'] = manager;
    });
    print(_newEmployeeInfo);
  }

  @override
  Widget build(BuildContext context) {
    final styleTheme = Theme.of(context);
    return Form(
      key: _form,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ManagerSelector(setValue: setManager,),
            Container(
              width: 400,
              child: CheckboxListTile(
                value: _generateID,
                title: const Text('Auto generate Employee ID'),
                onChanged: (bool value) {
                  setState(() {
                    _generateID = value;
                  });
                }
              )
              ,
            ),
            if(!_generateID) Container(
              width: 400,
              child: ListTile(
                // leading: Icon(Icons.mail, size: 35, color: styleTheme.primaryColor,),
                leading: Text('Employee ID', style: TextStyle( color: Colors.grey[600], fontSize: 16)),
                title: TextFormField(
                  // textInputAction: TextInputAction.next,
                  // keyboardType: TextInputType.emailAddress,
                  // initialValue: _newEmployeeInfo['street'],
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) {
                    // FocusScope.of(context).requestFocus(_otherNode);
                  },
                  // autovalidate: true,
                  onSaved: (value) {
                    _newEmployeeInfo['employeeID'] = value;
                  },
                  validator: (value) {
                    if(value.isEmpty) {
                      return '* Required Field';
                    } else {
                      return null;
                    }
                  },

                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'ex: 001',
                    hintStyle: TextStyle( color: Colors.grey, fontSize: 16),


                  ),
                ),
              ),
            ),

            Container(
              width: 400,
              child: ListTile(
                // leading: Icon(Icons.mail, size: 35, color: styleTheme.primaryColor,),
                leading: Text('First Name', style: TextStyle( color: Colors.grey[600], fontSize: 16)),
                title: TextFormField(
                  // textInputAction: TextInputAction.next,
                  // keyboardType: TextInputType.emailAddress,
                  // initialValue: _newEmployeeInfo['street'],
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) {
                    // FocusScope.of(context).requestFocus(_otherNode);
                  },
                  // autovalidate: true,
                  onSaved: (value) {
                    _newEmployeeInfo['firstName'] = value;
                  },
                  validator: (value) {
                    if(value.isEmpty) {
                      return '* Required Field';
                    } else {
                      return null;
                    }
                  },

                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'ex: Jackson',
                    hintStyle: TextStyle( color: Colors.grey, fontSize: 16),


                  ),
                ),
              ),
            ),

            Container(
              width: 400,
              child: ListTile(
                // leading: Icon(Icons.mail, size: 35, color: styleTheme.primaryColor,),
                leading: Text('Last Name', style: TextStyle( color: Colors.grey[600], fontSize: 16)),
                title: TextFormField(
                  // textInputAction: TextInputAction.next,
                  // keyboardType: TextInputType.emailAddress,
                  // initialValue: _newEmployeeInfo['street'],
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) {
                    // FocusScope.of(context).requestFocus(_otherNode);
                  },
                  // autovalidate: true,
                  onSaved: (value) {
                    _newEmployeeInfo['lastName'] = value;
                  },
                  validator: (value) {
                    if(value.isEmpty) {
                      return '* Required Field';
                    } else {
                      return null;
                    }
                  },

                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'ex: Washington',
                    hintStyle: TextStyle( color: Colors.grey, fontSize: 16),


                  ),
                ),
              ),
            ),

            Container(
              width: 400,
              child: ListTile(
                leading: FlatButton(
                  child: Text('Save', style: TextStyle(color: Colors.green),),
                  onPressed: addEmployee,
                ),
                trailing: FlatButton(
                  child: Text('Cancel', style: TextStyle(color: Colors.red),),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}