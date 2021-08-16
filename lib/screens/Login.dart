import 'package:flutter/material.dart';
import 'package:test_bacup/screens/Home.dart';
import 'package:test_bacup/services/LoginServices.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailControler = TextEditingController();
  final passwordControler = TextEditingController();
  final loginServices = new LoginServices();
  bool loading = false;
  bool fieldsRequired = true;
  bool emailIncorrect = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login user",
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(height: 15),
              _inputText("Email", Icons.email, emailControler, false, (value) {
                bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value);
                print(emailValid);
                if (!emailValid) {
                  setState(() {
                    emailIncorrect = true;
                  });
                } else {
                  setState(() {
                    emailIncorrect = false;
                  });
                }
              }),
              emailIncorrect ? SizedBox(height: 5) : SizedBox(),
              emailIncorrect
                  ? Text(
                      "Please enter a correct email",
                      style: TextStyle(color: Colors.red),
                    )
                  : SizedBox(),
              SizedBox(height: 10),
              _inputText(
                  "Password", Icons.lock_outline, passwordControler, true,
                  (value) {
                if (value == '') {
                  setState(() {
                    fieldsRequired = true;
                  });
                } else {
                  setState(() {
                    fieldsRequired = false;
                  });
                }
              }),
              fieldsRequired ? SizedBox(height: 10) : SizedBox(),
              fieldsRequired
                  ? Text("Email and password require",
                      style: TextStyle(color: Colors.red))
                  : SizedBox(),
              SizedBox(height: 20),
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: loading || emailIncorrect || fieldsRequired
                          ? Colors.grey[600]
                          : Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.white.withOpacity(0.09),
                            offset: Offset(5, 8),
                            blurRadius: 5)
                      ]),
                  child: TextButton(
                    onPressed: loading
                        ? null
                        : () async {
                            if (emailIncorrect) {
                              return;
                            } else if (passwordControler.text.trim() == '') {
                              return;
                            }
                            FocusScope.of(context).unfocus();
                            setState(() {
                              emailIncorrect = false;
                              fieldsRequired = false;
                              loading = true;
                            });
                            bool resp = await loginServices.login(
                                emailControler.text.trim(),
                                passwordControler.text.trim(),
                                context);
                            setState(() {
                              loading = false;
                            });
                            if (resp) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home()));
                            }
                          },
                    child: Text(
                      loading ? "Loading" : "Login",
                      style: TextStyle(color: Colors.deepPurple),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

_inputText(
  String text,
  IconData icon,
  TextEditingController inputControler,
  bool obscureText,
  Function onChange,
) {
  return Container(
      decoration: BoxDecoration(
          color: Colors.deepPurple,
          border: Border.all(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(50),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.white.withOpacity(0.09),
                offset: Offset(5, 8),
                blurRadius: 5)
          ]),
      height: 45,
      width: double.infinity,
      child: TextField(
        onChanged: (value) {
          onChange(value);
        },
        controller: inputControler,
        obscureText: obscureText,
        decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: Colors.white,
            ),
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            hintText: text),
      ));
}
