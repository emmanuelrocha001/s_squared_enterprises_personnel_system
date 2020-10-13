import 'package:flutter/material.dart';
import '../helper.dart';

class RoleItem extends StatefulWidget {
  final role;
  final Function addRole;
  final Function deleteRole;
  final canEdit;
  final initiallySelected;
  RoleItem({
    @required this.role,
    @required this.addRole,
    @required this.deleteRole,
    @required this.canEdit,
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
        if(widget.canEdit) {
          if(value) {
            widget.addRole(widget.role);
          } else {
            widget.deleteRole(widget.role);
          }
          setState(() {
            _selected = value;
          });
        } else {
          Helper.showMessageTop(context, 'Cannot edit Director role', error: true);
        }
      }

    );
  }
}