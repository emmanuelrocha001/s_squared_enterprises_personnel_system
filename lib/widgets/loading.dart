import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final styleTheme = Theme.of(context);
    return CircularProgressIndicator(
      backgroundColor: Colors.white.withOpacity(.5),
      valueColor: new AlwaysStoppedAnimation<Color>(styleTheme.primaryColor),
      strokeWidth: 3,
    );
  }
}


class LoadingOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        child: Container(
          width: 45,
          height: 45,
          child: Loading(),
        ),
      ),
    );
  }
}