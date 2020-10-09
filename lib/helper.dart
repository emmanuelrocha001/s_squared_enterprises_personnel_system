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
        height: (mediaQuery.size.height )* .7,
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 0),
          elevation: 1,
          // color: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)
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
        showMessageTop(context, value);
      } else {
        showMessageTop(context, 'Hello this is a test');
      }
    });
  }

  static void showMessageTop(BuildContext context, String message,{bool error: false}) {
    // final mediaQuery = MediaQuery.of(context);
    // final styleTheme = Theme.of(context);
    Flushbar(
      backgroundColor: Colors.white,
      messageText: Text(message, style: TextStyle(color: Colors.blue),),

      duration: new Duration(seconds: 2),
      margin: EdgeInsets.all(8),
      maxWidth: 400,
      flushbarPosition: FlushbarPosition.TOP,
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      // boxShadows: [
      //   BoxShadow(

      //     color: Colors.black.withOpacity(.45),
      //     offset: Offset(3,3),
      //     blurRadius: 3
      //   )
      // ],

      borderRadius: 8,
      // title: 'Error message:',
      message: message,


    )..show(context);

  }


  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}