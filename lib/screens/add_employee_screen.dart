import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/personnel.dart';
import '../widgets/manager_selector.dart';

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
    'managerId': '',
  };

  final _form = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
    // set to firs value if available
    List<String> managerList  = Provider.of<Personnel>(context, listen: false).managers;
    if(managerList.length > 0) {
      _newEmployeeInfo['managerId'] = Provider.of<Personnel>(context, listen: false).managers[0];
      print(_newEmployeeInfo);
    }
  }

  void setManager(BuildContext context, String manager) {
    setState(() {
      _newEmployeeInfo['managerId'] = manager;
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
                  onPressed: () {
                    Navigator.of(context).pop('Successfully added employee to the system');
                  },
                ),
                trailing: FlatButton(
                  child: Text('Cancel', style: TextStyle(color: Colors.red),),
                  onPressed: () {

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