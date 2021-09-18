import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:smart_apaga/LoginRegister/view/login/ForgotPassword/NewPasswordScreen.dart';
import 'dart:convert';
import 'package:smart_apaga/globals.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String screen;

  VerifyCodeScreen({this.screen});

  @override
  _VerifyCodeState createState() => _VerifyCodeState(screen: screen);
}

class _VerifyCodeState extends State<VerifyCodeScreen> {
  final TextEditingController _textFieldController = TextEditingController();

  String screen;

  _VerifyCodeState({this.screen});

  get _isValedText =>
      _textFieldController.text.length == 6 ||
      _textFieldController.text.length == 0;

  RequestManager _requestManager = RequestManager();

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
              SizedBox(height: 50),
              TextFormField(
                controller: _textFieldController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.grey),
                  labelText: "Code",
                  errorText: _isValedText ? null : 'Invaled Code',
                ),
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
              ),
              SizedBox(height: 50),
              ConstrainedBox(
                constraints: BoxConstraints(minWidth: screenSize.width * 0.3),
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
                  onPressed: _onVerifyTapped,
                  child: Text(
                    "Verify",
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }

  void _onVerifyTapped() {
    String text = _textFieldController.text;
    Map parametr = {'code': text};

    if (text.length != 0 && _isValedText) {
      if (screen == 'ForgotPassword') {
        _makeRequest(parametr, (s) {
          if (s == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewPasswordScreen()),
            );
          }
        });
      }
    }
  }

  void _makeRequest(Map parametrs, Function closure) async {
    String url = api_url + ApiEndpoints.checkCode;
    try {
      final response = await http.post(
        Uri.parse(url),
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
