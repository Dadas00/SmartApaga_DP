import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:smart_apaga/LoginRegister/view/login/ForgotPassword/VeriffyCodeScreen.dart';
import 'dart:convert';
import 'package:smart_apaga/globals.dart';

import 'package:smart_apaga/LoginRegister/Bloc/Validators.dart';

class NewPasswordScreen extends StatefulWidget {
  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPasswordScreen> {
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _verifyPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _newPasswordController.addListener(_onNewPasswordChange);
    _verifyPasswordController.addListener(_onVerifyPasswordChange);
  }

  bool isValedNewPassword = true;
  bool isValedVerifyPassword = true;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(children: <Widget>[
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    height: MediaQuery.of(context).size.width * 0.2,
                    image: AssetImage('assets/images/logo.png'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'SMARTAPAGA LLC',
                      style: TextStyle(color: Colors.green, fontSize: 22),
                    ),
                    Text(
                      'Waste Managment Solutions',
                      style: TextStyle(color: Colors.green[700], fontSize: 16),
                    )
                  ]),
                ],
              ),
              SizedBox(height: 15),
              SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                child: Text(
                  '''
Congratulations on taking the first step towards a 
more sustainable Armenia! 
                    ''',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 15),
                ),
              ),
              SizedBox(height: 50),
              TextFormField(
                controller: _newPasswordController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.grey),
                  labelText: "New Password",
                  errorText: isValedNewPassword ? null : 'Invalid password',
                ),
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
              ),
              TextFormField(
                controller: _verifyPasswordController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.grey),
                  labelText: "Verify Password",
                  errorText: isValedVerifyPassword ? null : 'Invalid password',
                ),
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ConstrainedBox(
                    constraints:
                        BoxConstraints(minWidth: screenSize.width * 0.3),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.green)),
                        primary: Colors.white,
                        textStyle: TextStyle(
                          color: Colors.green,
                        ),
                        padding: EdgeInsets.all(8.0),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancel".toUpperCase(),
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: screenSize.width * 0.18),
                  ConstrainedBox(
                    constraints:
                        BoxConstraints(minWidth: screenSize.width * 0.4),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.green)),
                        primary: Colors.green,
                        textStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: _onContinueTapped,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Save", style: TextStyle(fontSize: 14)),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Image(image: AssetImage('assets/images/sad_man2.png')),
              SizedBox(height: 20)
            ]),
          ),
        ),
      ),
    );
  }

  void _onNewPasswordChange() {
    var text = _newPasswordController.text;

    setState(() {
      isValedNewPassword = Validators.isValidPassword(text);
    });
  }

  void _onVerifyPasswordChange() {
    String newPassword = _newPasswordController.text;
    String verifyPassword = _verifyPasswordController.text;

    setState(() {
      isValedVerifyPassword = newPassword == verifyPassword;
    });
  }

  void _onContinueTapped() {
    String newPassword = _newPasswordController.text;
    String verifyPassword = _verifyPasswordController.text;

    Map parametr = {'password': newPassword, 'passwordConfirm': verifyPassword};

    if (parametr != null) {
      _makeRequest(parametr, (status) {
        if (status == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    VerifyCodeScreen(screen: 'ForgotPassword')),
          );
          //TODO: Error
          print(status);
        }
      });
    }
  }

  void _makeRequest(Map parametrs, Function closure) async {
    try {
      final response = await http.post(
        ApiEndpoints.resetPassword,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: json.encode(parametrs),
      );
      print(response.body);
      var data = jsonDecode(response.body);
      closure(data['status']);
    } catch (error) {
      print(error);
    }
  }
}
