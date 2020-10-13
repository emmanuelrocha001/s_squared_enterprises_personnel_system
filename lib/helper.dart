import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';

class Helper extends StatelessWidget {

  static void showActionScreen(BuildContext context, content, {bool resetLocalInventory=false}) {
    final mediaQuery = MediaQuery.of(context);
    showModalBottomSheet(
      elevation: 0,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context, builder: (ctx) {
      return Container(
        height: (mediaQuery.size.height )* .85,
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 0),
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8)
            )),
          child: Scrollbar(
            child: SingleChildScrollView(
              child: content,
            )
          ),

        ),
      );
    }).then((value) {
      if(value != null) {
        showMessageTop(context, value['message'], error: value['error']);
      }
    });
  }

  static void showMessageTop(BuildContext context, String message,{bool error: false}) {
    Flushbar(
      backgroundColor: Colors.white,
      messageText: Text(message, style: TextStyle(color: error ? Colors.red : Colors.green),),

      duration: new Duration(seconds: 2),
      margin: EdgeInsets.all(8),
      maxWidth: 400,
      flushbarPosition: FlushbarPosition.TOP,
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      borderRadius: 8,
      message: message,


    )..show(context);

  }


  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}