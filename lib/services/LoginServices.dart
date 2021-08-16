import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:test_bacup/bloc/user/user_bloc.dart';
import 'package:test_bacup/config/config.dart';
import 'package:test_bacup/models/LoginResponse.dart';

class LoginServices {
  Future<bool> login(
      String email, String password, BuildContext context) async {
    User user;
    final usuarioBloc = BlocProvider.of<UserBloc>(context);
    String url = '${urlApi}singin';
    var data = {
      'email': email,
      'password': password,
    };

    try {
      final resp = await http.post(Uri.parse(url),
          body: jsonEncode(data),
          headers: {'Content-Type': 'application/json'});

      if (resp.statusCode == 200 || resp.statusCode == 201) {
        final respLogin = loginResponseFromJson(resp.body);
        user = respLogin.user;
        usuarioBloc.add(SetUSer(user));
        return true;
      } else {
        return false;
      }
    } on TimeoutException catch (_) {
      print("Errorr timeException");
      return false;
    } catch (e) {
      return false;
    }
  }
}
