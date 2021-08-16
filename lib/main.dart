import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_bacup/screens/Login.dart';

import 'bloc/user/user_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => new UserBloc())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Test Bacup',
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.purple[700],
        ),
        home: Login(),
      ),
    );
  }
}
