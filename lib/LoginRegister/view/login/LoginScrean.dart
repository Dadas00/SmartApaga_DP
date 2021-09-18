import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:smart_apaga/LoginRegister/Bloc/LoginBloc/LoginBloc.dart';
import 'package:smart_apaga/LoginRegister/Bloc/LoginBloc/LoginEvent.dart';
import 'package:smart_apaga/LoginRegister/Bloc/LoginBloc/LoginState.dart';
import 'package:smart_apaga/LoginRegister/Bloc/RegisterBloc/UserRepository.dart';
import 'package:smart_apaga/LoginRegister/view/login/LoginForm.dart';
import 'package:smart_apaga/LoginRegister/view/register/RegForm.dart';
import 'package:smart_apaga/l10n/L10n.dart';
import 'package:smart_apaga/l10n/locale_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  UserRepository _userRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(_userRepository),
          child: Column(
            children: [
              LoginForm(),
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
            ],
          ),
        ),
      ),

      // body:
    );
    // body:
  }
}
