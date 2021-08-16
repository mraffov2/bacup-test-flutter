import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
          headers: {
            'Content-Type': 'application/json'
          }).timeout(const Duration(seconds: 50), onTimeout: () {
        // Time has run out, do what you wanted to do.
        return http.Response('{"ok": false, "message": "Error"}',
            500); // Replace 500 with your http code.
      });

      if (resp.statusCode == 200 || resp.statusCode == 201) {
        final respLogin = loginResponseFromJson(resp.body);
        user = respLogin.user;
        usuarioBloc.add(SetUSer(user));
        return true;
      } else if (resp.statusCode == 404) {
        showSnackBar(
            "Email or password incorrect", context, Colors.redAccent[700]);
        return false;
      } else {
        showSnackBar(
            "Sometihg happend, try agains", context, Colors.orange[400]);
        return false;
      }
    } on TimeoutException catch (_) {
      showSnackBar("Sometihg happend, try agains", context, Colors.orange[400]);
      print("Errorr timeException");
      return false;
    } catch (e) {
      showSnackBar("Sometihg happend, try agains", context, Colors.orange[400]);
      return false;
    }
  }

  showSnackBar(String message, BuildContext context, Color color) {
    if (context == null) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      duration: Duration(seconds: 8),
      backgroundColor: color,
    ));
  }
}
