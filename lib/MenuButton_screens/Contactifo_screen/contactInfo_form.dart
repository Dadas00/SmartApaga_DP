import 'dart:convert';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_session/flutter_session.dart' show FlutterSession;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:smart_apaga/Extention/MenuButton.dart';
import 'package:smart_apaga/LoginRegister/Bloc/PhoneNumberBloc/PhoneNmBloc.dart';
import 'package:smart_apaga/LoginRegister/Bloc/PhoneNumberBloc/PhoneNmEvent.dart';
import 'package:smart_apaga/LoginRegister/Bloc/PhoneNumberBloc/PhoneNmState.dart';
import 'package:smart_apaga/LoginRegister/model/Address.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//import 'package:smart_apaga/LoginRegister/model/Addresses.dart';
import 'package:smart_apaga/LoginRegister/model/Contacts.dart';
import 'package:smart_apaga/LoginRegister/view/overal/AddressConfirmationScreen.dart';
import 'package:smart_apaga/MenuButton_screens/Contactifo_screen/loadingContainer.dart';
import 'package:smart_apaga/globals.dart';

class ContactInfoForm extends StatefulWidget {
  ContactInfoFormState createState() => ContactInfoFormState();
}

class ContactInfoFormState extends State<ContactInfoForm> {
  PhoneNmBloc _phoneNmBloc;
  Future _futureAddress;
  TextEditingController _phoneNmController =
      TextEditingController(text: '098359899');

  initState() {
    _phoneNmBloc = BlocProvider.of<PhoneNmBloc>(context);
    super.initState();

    _phoneNmController.addListener(_onPhoneNmChanged);

    _futureAddress = fetchAddress();
  }

  Widget build(context) {
    final _phoneNmBloc = BlocProvider.of<PhoneNmBloc>(context);

    return BlocListener<PhoneNmBloc, PhoneNmState>(
      bloc: _phoneNmBloc,
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
        if (state.isAdding) {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Addressing...'),
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  ],
                ),
                backgroundColor: Color(0xffffae88),
              ),
            );
        }
        if (state.isAdded) {
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<PhoneNmBloc, PhoneNmState>(
        bloc: _phoneNmBloc,
        builder: (context, state) {
          return Scaffold(
            endDrawer: MenuButton(),
            appBar: AppBar(
              backgroundColor: Colors.green.shade300,
              iconTheme: IconThemeData(color: Colors.green.shade700),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
            ),
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: Column(children: <Widget>[
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.all(10.0)),
                    Image(
                      height: MediaQuery.of(context).size.width * 0.15,
                      image: AssetImage("assets/images/logo.png"),
                    ),
                    SizedBox(
                      width: 55,
                    ),
                    Expanded(
                      child: Text(
                        AppLocalizations.of(context).contatcIfno,
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.all(10.0)),
                    IconButton(
                        onPressed: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  //title: Text('Phone number'),
                                  actions: [
                                    TextFormField(
                                      controller: _phoneNmController,
                                      decoration: InputDecoration(
                                        border: UnderlineInputBorder(),
                                        labelText: AppLocalizations.of(context)
                                            .phoneNumText,
                                        // errorText: !state.isPhoneNmValid
                                        //     ? "Invalid Phone Number"
                                        //     : null,
                                      ),
                                      onTap: () {
                                        print('object');
                                      },
                                      keyboardType: TextInputType.phone,
                                      autocorrect: true,
                                    ),
                                  ],
                                )),
                        icon: Icon(Icons.add_circle_outline_rounded),
                        color: Colors.green.shade300),
                    Text(
                      AppLocalizations.of(context).phoneNumText,
                      style: TextStyle(fontSize: 13.0),
                    ),
                    SizedBox(
                      width: 114.0,
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  AddressConfirmationScreen()));
                        },
                        icon: Icon(Icons.add_circle_outline_rounded),
                        color: Colors.green.shade300),
                    SizedBox(
                      width: 2,
                    ),
                    Expanded(
                      child: Text(
                        AppLocalizations.of(context).addressText,
                        style: TextStyle(fontSize: 13.0),
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.green.shade300,
                  thickness: 2,
                  indent: 20,
                  endIndent: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.all(10.0)),
                    Text(
                      AppLocalizations.of(context).addressText,
                      style:
                          TextStyle(fontSize: 13, color: Colors.grey.shade500),
                    ),
                  ],
                ),
                Container(
                  child: addressList(),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Divider(
                  color: Colors.green.shade300,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.all(10.0)),
                    Text(
                      AppLocalizations.of(context).phoneNumText,
                      style:
                          TextStyle(fontSize: 13, color: Colors.grey.shade500),
                    ),
                  ],
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      child: _phoneNmList(),
                    ),
                  ),
                ),
                // Container(
                //   child: ,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomLeft,
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
                          AppLocalizations.of(context).cancelText,
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Align(
                      alignment: Alignment.bottomRight,
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
                        onPressed: () {
                          _complationOfAction();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(AppLocalizations.of(context).confirmText,
                              style: TextStyle(fontSize: 14)),
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          );
        },
      ),
    );
  }

  Widget _phoneNmList() {
    return FutureBuilder<List<Contact>>(
        future: fetchContacts(),

        // ignore: missing_return
        builder: (context, snapshot) {
          List<Widget> children;
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(color: Colors.green[200]),
            );
          } else if (snapshot.hasData) {
            children = <Widget>[
              SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    ListView.builder(
                      controller: null,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        //final folder = snapshot.data[index];
                        return Dismissible(
                          background: Container(
                            color: Colors.red,
                            child: Align(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    " Delete",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                ],
                              ),
                              alignment: Alignment.centerRight,
                            ),
                          ),
                          key: Key(UniqueKey().toString()),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            // setState(() {
                            //   _futureAddress = deleteAddress(
                            //       snapshot.data.removeAt(index).toString());
                            // });
                            _futureAddress = deleteAddress(
                                snapshot.data.remove(index).toString());
                          },
                          child: Card(
                            child: ListTile(
                              title:
                                  Text('${snapshot.data[index].phoneNumber}'),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ];
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          );
        });
  }

  Widget addressList() {
    return FutureBuilder(
        future: _futureAddress,
        builder: (context, snapshot) {
          List<Widget> children;
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(color: Colors.green[200]),
            );
          } else if (snapshot.hasData) {
            children = <Widget>[
              SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    ListView.builder(
                      controller: null,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        //final folder = snapshot.data[index];
                        return Dismissible(
                          background: Container(
                            color: Colors.red,
                            child: Align(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    " Delete",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                ],
                              ),
                              alignment: Alignment.centerRight,
                            ),
                          ),
                          key: Key(UniqueKey().toString()),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            _futureAddress = deleteAddress(
                                snapshot.data.remove(index).toString());
                          },
                          child: Card(
                            child: ListTile(
                              title: Text('${snapshot.data[index].streetName}'),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ];
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          );
        });
  }

  List<Address> parseAddresses(String reponseBody) {
    final parsed = jsonDecode(reponseBody).cast<Map<String, dynamic>>();
    return parsed.map<Address>((json) => Address.fromJson(json)).toList();
  }

  List<Contact> parseContact(String reponseBody) {
    final parsed = jsonDecode(reponseBody).cast<Map<String, dynamic>>();
    return parsed.map<Contact>((json) => Contact.fromJson(json)).toList();
  }

  Future<List<Contact>> fetchContacts() async {
    dynamic token = await FlutterSession().get('token');
    List<Contact> contact = [];
    final response = await http.get(
      Uri.parse(ApiEndpoints.address),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    var body = jsonDecode(response.body);
    // print(body);
    if (body['status'] == 1) {
      dynamic data = body['data'];
      data.forEach((element) {
        Contact address = Contact.fromJson(element);
        contact.add(address);
      });
      // for (var item in addressLt) {
      //   print(item.id);
      // }
      inspect(contact);
    } else {
      print("Error ");
    }
    return contact;
  }

  // Future<Address> fetchAddresses() async {
  //   dynamic token = await FlutterSession().get('token');
  //   var newRes;
  //   try {
  //     dynamic response = await http.get(
  //       Uri.parse(ApiEndpoints.address),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //     );

  //     response =
  //         '[{"id":1,"streetName":"Baxramyan"},{"id":2,"streetName":"Gyulbenkyan"},{"id":3,"streetName":"Mashtoci"}]';

  //     print('Daaaavs' + response);
  //     newRes = parseAddresses(response);
  //     // listAddress.add(newRes);
  //     // print(listAddress);
  //     inspect(newRes);
  //     return newRes;
  //   } catch (error) {
  //     print(error);
  //   }

  // }

  // ignore: missing_return
  Future<List<Address>> fetchAddress() async {
    dynamic token = await FlutterSession().get('token');
    List<Address> addressLt = [];
    final response = await http.get(
      Uri.parse(ApiEndpoints.address),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    var body = jsonDecode(response.body);
    // print(body);
    if (body['status'] == 1) {
      dynamic data = body['data'];
      data.forEach((element) {
        Address address = Address.fromJson(element);
        addressLt.add(address);
      });
      // for (var item in addressLt) {
      //   print(item.id);
      // }
      inspect(addressLt);
      return addressLt;
    } else {
      print("Error ");
    }

    //   // A 200 OK response means
    //   // ready to parse th
    //\
    //e JSON.
    //   return List<Address> addressLists = List<Address>.from(i.map((element) => Address.fromJson(element)));
    // } else {
    //   // If not a 200 ok response
    //   // means throw an exception.
    //   throw Exception('Failed to load album');
    // }
  }

  Future<void> deleteAddress(String id) async {
    dynamic token = FlutterSession().get('token');

    try {
      http.Response response = await http.get(
        Uri.parse(ApiEndpoints.address + '/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json;  charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      print("Response status:${response.statusCode}");
      print('DAvs karas axpers lav mtaci');
      //return Address.fromJson(jsonDecode(response.body));
    } catch (error) {
      print(error);
    }
  }

  void _complationOfAction() {
    final phoneNm = _phoneNmController.text;

    Contact contact = Contact(
      phoneNumber: phoneNm,
    );

    _phoneNmBloc.add(PhoneNmAdded(phoneNm: contact));
  }

  void _onPhoneNmChanged() {
    _phoneNmBloc.add(PhoneNmChanged(phoneNm: _phoneNmController.text));
  }

  @override
  void dispose() {
    _phoneNmController.dispose();
    super.dispose();
  }
}
  

// shrinkWrap: true,
//                 itemCount: snapshot.data.length,
//                 scrollDirection: Axis.vertical,
//                 itemBuilder: (context, index) {
//                   return Dismissible(
//                     key: ValueKey(snapshot.data[index]),
//                     child: Card(
//                       child: ListTile(
//                         title: Text(snapshot.data[index].toString()),
//                       ),
//                     ),
//                     background: Container(
//                       color: Colors.green,
//                     ),
//                     onDismissed: (DismissDirection direction) {
//                       setState(() {
//                         snapshot.data.removeAt(index);
//                       });
//                     },
//                   );
//                 }
// dynamic token = await FlutterSession().get('token');
    // var newRes;
    // try {
    //   dynamic response = await http.get(
    //     Uri.parse(ApiEndpoints.addressAdd),
    //     headers: <String, String>{
    //       'Content-Type': 'application/json',
    //       'Authorization': 'Bearer $token',
    //     },
    //   );

    //   response =
    //       // '[{"id":1,"customer_id":1,"country":"Am","administrative_area":"Yerevan","locality":"Yerevan","district":"Yerevan","street":"Tumanyan","building":"28","apartment":"5","entrance":"5","intercom":"25525","postal_code":"2525","is_default":0,"status":"active","lat":216516,"lng":1651651},{"id":2,"customer_id":1,"country":"AM","administrative_area":"Yerevan","locality":"Yerevan","district":null,"street":null,"building":"3","apartment":null,"entrance":null,"intercom":null,"postal_code":null,"is_default":0,"status":"active","lat":40.1872023,"lng":44.515209},{"id":3,"customer_id":1,"country":"AM","administrative_area":"Yerevan","locality":"Yerevan","district":null,"street":null,"building":"4567","apartment":null,"entrance":null,"intercom":null,"postal_code":null,"is_default":0,"status":"active","lat":40.1872023,"lng":44.515209}]';
    //       '[{"id":1,"phoneNumber":"077021013"},{"id":2,"phoneNumber":"098359899"},{"id":3,"phoneNumber":"093095659"}]';
    //   newRes = parseContact(response);
    //   // listAddress.add(newRes);
    //   inspect(newRes);

    //   return newRes;
    // } catch (error) {
    //   print(error);
    // }
    // return newRes;