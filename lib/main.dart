import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:todoprovider/provider/Todo-provider.dart';
import 'package:todoprovider/screens/Home-screen.dart';

void main() {
  runApp(ToDo());
}

class ToDo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Todo()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
