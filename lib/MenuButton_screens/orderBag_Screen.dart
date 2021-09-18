import 'package:flutter/material.dart';
import 'package:smart_apaga/Extention/MenuButton.dart';
import 'package:smart_apaga/LoginRegister/model/Address.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderBags extends StatefulWidget {
  OrderBagsState createState() => OrderBagsState();
}

class OrderBagsState extends State<OrderBags> {
  int _value = 1;
  int count = 0;

  List<Address> _address = [];

  Widget build(context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      endDrawer: MenuButton(),
      appBar: AppBar(
        backgroundColor: Colors.green.shade300,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(10.0)),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 0)),
                  Image(
                    height: MediaQuery.of(context).size.width * 0.14,
                    image: AssetImage('assets/images/logo.png'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context).orderBags,
                  style: TextStyle(fontSize: 24.0),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 10,
                ),
                DropdownButton(
                  iconSize: 35.0,
                  value: _value,
                  items: [
                    DropdownMenuItem(
                      child: Text(AppLocalizations.of(context).homeAdressText),
                      value: 1,
                    ),
                    DropdownMenuItem(
                      child: Text("Second Item"),
                      value: 2,
                    )
                  ],
                  onChanged: (int value) {
                    setState(() {
                      _value = value;
                    });
                  },
                ),
                SizedBox(width: 170.0),
                IconButton(
                    enableFeedback: true,
                    onPressed: () {},
                    icon: Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.green,
                      size: 30,
                    )),
              ],
            ),

            // Divider(
            //   color: Colors.grey,
            // ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  // constraints: BoxConstraints(
                  //     minWidth: screenSize.width * 0.3),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green.shade300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.green),
                      ),
                      primary: Colors.white,
                      textStyle: TextStyle(
                        color: Colors.green,
                      ),
                      padding: EdgeInsets.all(8.0),
                    ),
                    onPressed: () {
                      print('sdfsda');
                    },
                    child: Text(
                      AppLocalizations.of(context).reusableText,
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.green)),
                      primary: Colors.green.shade300,
                      textStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      print('okasodfkodkfodkf');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        AppLocalizations.of(context).disposableText,
                        style: TextStyle(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Image(
                height: 150,
                width: 150,
                image: AssetImage('assets/images/bag.png')),
            SizedBox(
              height: 10,
            ),

            //Quality
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 130.0,
                ),
                Text(
                  AppLocalizations.of(context).quantityText,
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  width: 20.0,
                ),
                //  Container(),
                //  Container(),
                // SizedBox(
                //   height: 25,
                //   width: 35,
                //   child: TextButton(
                //     style: TextButton.styleFrom(
                //       side: BorderSide(color: Colors.green.shade300),
                //       primary: Colors.green,
                //       textStyle: TextStyle(
                //         color: Colors.black,
                //       ),
                //       padding: EdgeInsets.all(1.0),
                //     ),
                //     onPressed: () {
                //       Navigator.pop(context);
                //     },
                //     child: Text(
                //       "-",
                //       style: TextStyle(
                //         fontSize: 14.0,
                //       ),
                //     ),
                //   ),
                // ),
                // SizedBox(width: 8),
                // SizedBox(
                //   height: 25,
                //   width: 35,
                //   child: ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //       side: BorderSide(color: Colors.green.shade300),
                //       onPrimary: Colors.green,
                //       primary: Colors.white,
                //       textStyle: TextStyle(
                //         color: Colors.white,
                //       ),
                //     ),
                //     onPressed: () {},
                //     child: Text("+", style: TextStyle(fontSize: 14)),
                //   ),
                // ),
                Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Colors.green),
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () {
                            setState(() {
                              count--;
                            });
                          },
                          child: Icon(
                            Icons.remove,
                            color: Colors.white,
                            size: 16,
                          )),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 12),
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.white),
                        child: Text(
                          '$count',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            setState(() {
                              count++;
                            });
                          },
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 16,
                          )),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 17.0,
            ),

            Container(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  "${AppLocalizations.of(context).totalText} : 1200\֏",
                  style: TextStyle(fontSize: 20),
                ),
              ]),
              // child:
            ),

            //alignment: Alignment.bottomCenter,
            SizedBox(
              height: 50.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 102,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'CONFIRM',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(100, 0),
                    primary: Colors.green.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'SKIP',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
