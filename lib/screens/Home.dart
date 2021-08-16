import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_bacup/bloc/user/user_bloc.dart';
import 'package:test_bacup/widgets/AppBar.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final totalWidth = MediaQuery.of(context).size.width.round();
    final totalheight = MediaQuery.of(context).size.height.round();
    return Scaffold(
        appBar: AppBarDetails(title: 'Welcome to test Bacup'),
        body: Container(
            height: totalheight.toDouble(),
            child: BlocBuilder<UserBloc, UserState>(builder: (_, state) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Name ${state.user.name}',
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Edad: ${state.user.yearOld}',
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Usuario: ${state.user.email}',
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Password: No available',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              );
            })));
  }
}
