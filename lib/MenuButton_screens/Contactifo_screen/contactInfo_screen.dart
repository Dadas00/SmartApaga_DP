import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_apaga/LoginRegister/Bloc/AddressBloc/AddressBloc.dart';
import 'package:smart_apaga/MenuButton_screens/Contactifo_screen/contactInfo_form.dart';

class ContactScreen extends StatefulWidget {
  ContactScreenState createState() => ContactScreenState();
}

class ContactScreenState extends State<ContactScreen> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider<AddressBloc>(
        create: (BuildContext context) => AddressBloc(),
        child: ContactInfoForm(),
      ),
    );
  }
}
