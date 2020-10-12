import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/personnel.dart';

class ManagerSelector extends StatelessWidget {
  final Function setValue;
  ManagerSelector({
    @required this.setValue,
  });

  // List<String>
  @override
  Widget build(BuildContext context) {

    final _managers = Provider.of<Personnel>(context,).managers;
    print(_managers);
    return Container(
      // color: Colors.red,
      width: 400,
      child: ListTile(
        leading: Text('Manager:', style: TextStyle( color: Colors.grey[600], fontSize: 16)),

        title: DropdownButtonFormField(

          decoration: InputDecoration(
            enabledBorder: InputBorder.none,
          ),

          dropdownColor: Colors.white,
          icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey[600]),
          // value: _managers[0],

          onChanged: (newValue) {
            this.setValue(context, newValue);
          },

          items: _managers.map( (value) {{
            return DropdownMenuItem<String>(
              value: value.id,
              child: Container(
                // alignment: Alignment.centerRight,
                child: Text('${value.firstName} ${value.lastName}', style: TextStyle(color: Colors.black, fontSize: 16),)),
            );
          }}).toList(),
        ),

      ),
      );
  }
}