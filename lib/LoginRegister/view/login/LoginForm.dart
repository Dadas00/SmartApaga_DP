import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_apaga/Home/Home/HomeScreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'package:smart_apaga/LoginRegister/Bloc/LoginBloc/LoginBloc.dart';
import 'package:smart_apaga/LoginRegister/Bloc/LoginBloc/LoginEvent.dart';
import 'package:smart_apaga/LoginRegister/Bloc/LoginBloc/LoginState.dart';
import 'package:smart_apaga/LoginRegister/Bloc/RegisterBloc/UserRepository.dart';
import 'package:smart_apaga/LoginRegister/view/login/ForgotPassword/ForgotScreen.dart';
import 'package:smart_apaga/LoginRegister/view/register/RegScreen.dart';
import 'package:smart_apaga/l10n/L10n.dart';
import 'package:smart_apaga/l10n/locale_provider.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController =
      TextEditingController(text: 'aa@aa.aa');
  final TextEditingController _passwordController =
      TextEditingController(text: 'aaaaaa');

  UserRepository _userRepository;
  LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChange);
    _passwordController.addListener(_onPasswordChange);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    final locale = provider.locale ?? Locale('en');
    var screenSize = MediaQuery.of(context);
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isFailure) {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Register Failure'),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Color(0xffffae88),
              ),
            );
        }

        if (state.isSubmitting) {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Registering...'),
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  ],
                ),
                backgroundColor: Color(0xffffae88),
              ),
            );
        }

        if (state.isSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              AppLocalizations.of(context).welcomeLoginText,
                              style: TextStyle(
                                  color: Colors.lightGreen, fontSize: 20),
                            ),
                            SizedBox(
                              width: 35,
                            ),
                            DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: locale,
                                icon: Container(width: 12),
                                items: L10n.all.map(
                                  (locale) {
                                    final flag =
                                        L10n.getFlag(locale.languageCode);

                                    return DropdownMenuItem(
                                      child: Center(
                                        child: Text(
                                          flag,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                      value: locale,
                                      onTap: () {
                                        final provider =
                                            Provider.of<LocaleProvider>(context,
                                                listen: false);

                                        provider.setLocale(locale);
                                      },
                                    );
                                  },
                                ).toList(),
                                onChanged: (_) {},
                              ),
                            ),
                          ]),
                      SizedBox(
                        width: 5,
                      ),
                      Image(
                          height: MediaQuery.of(context).size.width * 0.5,
                          image: AssetImage('assets/images/login.png')),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 340.0,
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          _emailField(state),
                          _passwordField(state),
                          _forgotButton(context),
                          _loginButton(state),
                          Container(
                            alignment: Alignment.topCenter,
                            child: Column(
                              children: [
                                _signUpButton(context),
                                Row(children: <Widget>[
                                  Expanded(
                                    child: new Container(
                                        margin: const EdgeInsets.only(
                                            left: 30.0, right: 20.0),
                                        child: Divider(
                                          color: Colors.black,
                                          // height: 36,
                                        )),
                                  ),
                                  Text(AppLocalizations.of(context).orText),
                                  Expanded(
                                    child: new Container(
                                        margin: const EdgeInsets.only(
                                            left: 20.0, right: 30.0),
                                        child: Divider(
                                          color: Colors.black,
                                          // height: 36,
                                        )),
                                  ),
                                ]),
                                Container(
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      MaterialButton(
                                        onPressed: () {},

                                        color: Colors.grey,
                                        child: Text(
                                          'f',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        // padding: EdgeInsets.all(5),
                                        shape: CircleBorder(),
                                      ),
                                      MaterialButton(
                                        onPressed: () {},
                                        color: Colors.grey,
                                        textColor: Colors.white,
                                        child: Icon(
                                          Icons.mail,
                                          size: 23,
                                        ),
                                        shape: CircleBorder(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: TextButton(
                            onPressed: null,
                            child: Text(
                                AppLocalizations.of(context).termsOfuseText)),
                      ),
                      Container(
                          height: 15,
                          child: VerticalDivider(color: Colors.black)),
                      Expanded(
                          child: TextButton(
                        onPressed: null,
                        child: Text(
                            AppLocalizations.of(context).privacyPolicyText),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _emailField(LoginState state) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 5.0,
      ),
      child: TextFormField(
        controller: _emailController,
        decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.grey),
          labelText: AppLocalizations.of(context).emailText,
          errorText: !state.isEmailValid ? 'Invalid Email' : null,
          hintStyle: TextStyle(color: Colors.grey[500], fontSize: 13),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.green[700]),
          ),
        ),
        keyboardType: TextInputType.emailAddress,
        autocorrect: false,
      ),
    );
  }

  Widget _passwordField(LoginState state) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 0.0,
      ),
      child: TextFormField(
        controller: _passwordController,
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context).passwordText,
          errorText: !state.isPasswordValid ? 'Invalid Password' : null,
        ),
        obscureText: true,
        autocorrect: false,
      ),
    );
  }

  Widget _loginButton(LoginState state) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          primary: Colors.blue,
          onSurface: Colors.red,
          backgroundColor: Colors.green.shade300,
        ),
        onPressed: state.isSuccess && state.isPasswordValid ? null : _login,
        child: Text(
          AppLocalizations.of(context).loginText,
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        ),
      ),
    );
  }

  Widget _forgotButton(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 0.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ForgotPassword()),
          );
        },
        child: Align(
          alignment: Alignment.topRight,
          child: Text(
            AppLocalizations.of(context).forgotPasswordText,
            style: TextStyle(fontSize: 12.0, color: Colors.green),
          ),
        ),
      ),
    ]);
  }

  Widget _signUpButton(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        primary: Colors.teal,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegScreen()),
        );
      },
      //textTheme: ButtonTextTheme.normal,
      child: Text(
        AppLocalizations.of(context).signUpText,
        style: TextStyle(fontSize: 18, color: Colors.green),
      ),
    );
  }

  void _onEmailChange() {
    _loginBloc.add(LoginEmailChanged(email: _emailController.text));
  }

  void _onPasswordChange() {
    _loginBloc.add(LoginPasswordChanged(password: _passwordController.text));
  }

  void _login() {
    var email = _emailController.text;
    var password = _passwordController.text;

    Map userMap = {'email': email, 'password': password};
    _loginBloc.add(LoginSubmitted(user: userMap));
  }
}
