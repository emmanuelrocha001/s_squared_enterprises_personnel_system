import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:s_squared_enterprises_personnel_system/providers/personnel.dart';
import '../widgets/manager_selector.dart';
import '../widgets/employee_list.dart';
import '../widgets/loading.dart';
import '../screens/add_employee_screen.dart';
import '../helper.dart';
class PersonnelScreen extends StatelessWidget {


  void _addEmployee(BuildContext context) {
    Helper.showActionScreen(context, Container(
      child: AddEmployeeScreen(),
    ));
  }

  void _setCurrentManager(BuildContext context, String newValue) {
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
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);


    final appBar = AppBar(
        title: Text('S-Squared Enterprises Personnel System'),
    );

    final styleTheme = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: appBar,

      body: Container(
        height: mediaQuery.size.height-appBar.preferredSize.height,
        width: mediaQuery.size.width,
        padding: EdgeInsets.symmetric(vertical: 20),
        child: FutureBuilder(
          future: _fetchPersonnel(context),
          builder: (context, snapshot) => snapshot.connectionState == ConnectionState.waiting ?
            LoadingOverlay() :
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ManagerSelector(setValue: _setCurrentManager,),
                ),
                EmployeeList(),
                FlatButton.icon(
                  onPressed: () {
                    _addEmployee(context);
                  },
                  icon: Icon(Icons.add_circle_outline, color: Colors.blue,),
                  label: Text('Add Employee', style: TextStyle(color: Colors.blue),))

              ],
            ),
        ),
      )
    );
  }
}