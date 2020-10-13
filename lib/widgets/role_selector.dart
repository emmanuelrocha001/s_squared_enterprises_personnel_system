
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/personnel.dart';
import './role_item.dart';

class RoleSelector extends StatefulWidget {
  final Function setRolesSelected;
  final initialRoles;
  RoleSelector({
    @required this.setRolesSelected,
    this.initialRoles,
  });
  @override
  _RoleSelectorState createState() => _RoleSelectorState();
}

class _RoleSelectorState extends State<RoleSelector> {

  ScrollController _controller;

  List<String> _rolesSelected  = [];

  @override
  void initState() {
    super.initState();
    if(widget.initialRoles != null) {
      _rolesSelected = [...widget.initialRoles];
    }
  }

  void addRole(String role) {
    _rolesSelected.add(role);
    widget.setRolesSelected(_rolesSelected);
  }

  void deleteRole(String role) {
    _rolesSelected.removeWhere((element) => element == role);
    widget.setRolesSelected(_rolesSelected);
  }

  @override
  Widget build(BuildContext context) {
    final roles = Provider.of<Personnel>(context, listen: false).roles;

    var editDirectorRole = true;
    if((widget.initialRoles as List<String>).contains('Director')) {
      editDirectorRole = false;
    }
    return Scrollbar(
      child: ListView.builder(
      controller: _controller,
        itemCount: roles.length,
        itemBuilder: (context,index)  {
          var initiallySelected = false;
          if(widget.initialRoles != null) {
            initiallySelected = (widget.initialRoles as List<String>).contains(roles[index]);
          }
          var canEdit = true;
          if(!editDirectorRole && roles[index] == 'Director') {
            canEdit = false;
          }
          return RoleItem(
            canEdit: canEdit,
            role: roles[index],
            addRole: addRole,
            deleteRole: deleteRole,
            initiallySelected: initiallySelected,
          );
        }
      ),
    );
  }
}