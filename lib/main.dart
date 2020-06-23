import 'package:flutter/material.dart';
import 'package:involatask/ViemModels/data_view_model.dart';
import 'package:provider/provider.dart';

import 'Widgets/home_screen.dart';

void main() => runApp(ChangeNotifierProvider(
    create: (context) => DataViewModel(), child: MyApp()));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Provider.of<DataViewModel>(context, listen: false).getData();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
