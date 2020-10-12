import 'package:flutter/material.dart';

class RoleItem extends StatefulWidget {
  final role;
  final Function addRole;
  final Function deleteRole;
  final initiallySelected;
  RoleItem({
    @required this.role,
    @required this.addRole,
    @required this.deleteRole,
    this.initiallySelected=false,
  });

  @override
  _RoleItemState createState() => _RoleItemState();
}

class _RoleItemState extends State<RoleItem> {
  var _selected = false;


  @override
  void initState() {
    super.initState();
    _selected = widget.initiallySelected;
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: _selected,
      title: Text(widget.role),
      onChanged: (bool value) {
        if(value) {
          widget.addRole(widget.role);
        } else {
          widget.deleteRole(widget.role);
        }
        setState(() {
          _selected = value;
        });
      }
    );
  }
}