import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:s_squared_enterprises_personnel_system/providers/personnel.dart';
import '../widgets/manager_selector.dart';
import '../widgets/employee_list.dart';
import '../screens/add_employee_screen.dart';
import '../helper.dart';
class PersonnelScreen extends StatefulWidget {

  @override
  _PersonnelScreenState createState() => _PersonnelScreenState();
}

class _PersonnelScreenState extends State<PersonnelScreen> {
  void _addEmployee(BuildContext context) {
    Helper.showActionScreen(context, Container(
      child: AddEmployeeScreen(),
    ));
  }

  void _setCurrentManager(BuildContext context, final newValue) {
    Provider.of<Personnel>(context, listen: false).setSelectedManager(newValue);
    print(newValue);
  }

  Future<void> _fetchPersonnel(BuildContext context) async{
    final res = await Provider.of<Personnel>(context, listen: false).fetchPersonnel();
    if(res['success']) {

    } else {
      Helper.showMessageTop(context, 'Something went wrong, failed to fetch personnel', error: true);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchPersonnel(context);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);


    final appBar = AppBar(
        title: Text('S-Squared Enterprises Personnel System'),
    );

    // final styleTheme = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: appBar,
      body: Container(
        height: mediaQuery.size.height-appBar.preferredSize.height,
        width: mediaQuery.size.width,
        padding: EdgeInsets.symmetric(vertical: 20),
        child:
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      child:
                          ManagerSelector(setValue: _setCurrentManager,),
                    ),
                  ),
                  EmployeeList(),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: FlatButton.icon(
                      onPressed: () {
                        _addEmployee(context);
                      },
                      icon: Icon(Icons.add_circle_outline, color: Colors.blue,),
                      label: Text('Add Employee', style: TextStyle(color: Colors.blue),)),
                  )
                ],
              ),
            ),
      )
    );
  }
}