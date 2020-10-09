import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/personnel.dart';

import './screens/personnel_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
        // use when new instance is created
        create: (ctx) => Personnel(),),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(

          primarySwatch: Colors.blue,
          primaryColor: Colors.blue,

          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: PersonnelScreen(),
      ),
    );
  }
}

