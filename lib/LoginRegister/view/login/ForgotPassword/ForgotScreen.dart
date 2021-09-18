import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:smart_apaga/LoginRegister/view/login/ForgotPassword/VeriffyCodeScreen.dart';
import 'dart:convert';
import 'package:smart_apaga/globals.dart';

import 'package:smart_apaga/LoginRegister/Bloc/Validators.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController _textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _textFieldController.addListener(_onTextFieldChange);
  }

  bool isValedText = true;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                controller: _textFieldController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.grey),
                  labelText: "Phone Number or Email",
                  errorText:
                      isValedText ? null : 'Invalid Phone Number or Email',
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
                          side: BorderSide(color: Colors.green),
                        ),
                        primary: Colors.green,
                        textStyle: TextStyle(
                          color: Colors.white,
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
                        child: Text("Continue".toUpperCase(),
                            style: TextStyle(fontSize: 14)),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Image(image: AssetImage('assets/images/sad_man2.png')),
              SizedBox(height: 20),
              Divider(
                color: Colors.black,
                indent: 30,
                endIndent: 30,
              ),
              Container(
                child: Row(
                  children: [
                    SizedBox(
                      width: 80.0,
                    ),
                    Image(
                        height: 50,
                        image: AssetImage('assets/images/EU4Business.png')),
                    SizedBox(
                      width: 40,
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Image(
                        height: 38, image: AssetImage('assets/images/Giz.png')),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  void _onTextFieldChange() {
    var text = _textFieldController.text;

    setState(() {
      isValedText =
          Validators.isValidEmail(text) || Validators.isValidPhone(text);
    });
  }

  Map _getParametr(String text) {
    if (Validators.isValidEmail(text)) {
      return {'email': text};
    } else if (Validators.isValidPhone(text)) {
      return {'phone': text};
    }
    return null;
  }

  void _onContinueTapped() {
    String text = _textFieldController.text;
    Map parametr = _getParametr(text);

    if (parametr != null) {
      _makeRequest(parametr, (status) {
        if (status == 1) {
          _sendCode(parametr, (s) {
            if (s == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        VerifyCodeScreen(screen: 'ForgotPassword')),
              );
            }
          });
        }
        //TODO: Error
        print(status);
      });
    }
  }

  Future<void> _makeRequest(Map parametrs, Function closure) async {
    try {
      final response = await http.post(
        Uri.parse(api_url + '/exists'),
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

  void _sendCode(Map parametrs, Function closure) async {
    try {
      final response = await http.post(
        Uri.parse(api_url + '/sendCode'),
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
