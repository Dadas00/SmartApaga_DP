import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:smart_apaga/Extention/MenuButton.dart';
import 'package:smart_apaga/Pickup/Model/Pickup.dart';
import 'package:smart_apaga/Pickup/Model/Wast.dart';
import 'package:smart_apaga/Pickup/PickupBloc/PickupBloc.dart';
import 'package:smart_apaga/Pickup/View/SchedulScreen.dart';
import 'package:smart_apaga/globals.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WastTypeScreen extends StatefulWidget {
  final String barcode;
  final List<Waste> wastes;

  WastTypeScreen({
    this.barcode,
    this.wastes,
  });

  @override
  WastTypeScreenState createState() => WastTypeScreenState(
        barcode: barcode,
        wastes: wastes,
      );
}

class WastTypeScreenState extends State<WastTypeScreen> {
  String barcode;
  Pickup _pickup;
  int gestureTag = 0;
  //List<int> countwast = [];
  List<Waste> wastes = [];

  Waste waste;

  //List<int> wastCount;

  List<dynamic> types = ['plastic', 'paper', 'glass'];

  WastTypeScreenState({this.barcode, this.wastes});

  int selectedState = 0;
  int previewSelectedState = 0;
  //List<int> wastesCount = [0, 0, 0];
  List<int> wastesCount = [];
  int plastic = 0;
  int paper = 0;
  int glass = 0;

  List<int> countsWast() {
    wastesCount = [plastic, paper, glass];
    wastesCount.elementAt(0);
    wastesCount.elementAt(1);
    wastesCount.elementAt(2);
    print('Assalla-$wastesCount');
    return wastesCount;
  }

  void _onGesturTap(int tag) {
    if (selectedState != 0) {
      wastes.removeLast();
    }
    selectedState = gestureTag;
    wastes.add(Waste(bagCode: barcode, type: types[gestureTag]));
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: Text(AppLocalizations.of(context).wastTypeText),
          backgroundColor: Colors.green[300],
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, true),
          )),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
          child: Column(
            children: [
              Text(AppLocalizations.of(context).belowText,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  )),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //
                    //
                    //
                    //s
                    //Plastic
                    Container(
                      decoration: BoxDecoration(
                          color: gestureTag == 0
                              ? Colors.green[100]
                              : Colors.white,
                          border: Border.all(color: Colors.green)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      gestureTag = 0;
                                      _onGesturTap(gestureTag);
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Image(
                                          image: AssetImage(
                                              "assets/images/plastic2.png")),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        AppLocalizations.of(context)
                                            .plasticText,
                                        style: TextStyle(
                                            color: Colors.green, fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                //
                                barcode != null
                                    ? SizedBox.shrink()
                                    : Column(
                                        children: [
                                          SizedBox(
                                            height: 50,
                                            width: 110,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.all(3),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: Colors.green),
                                                child: Row(
                                                  children: [
                                                    InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            plastic--;

                                                            // countsWast();
                                                          });
                                                        },
                                                        child: Icon(
                                                          Icons.remove,
                                                          color: Colors.white,
                                                          size: 16,
                                                        )),
                                                    Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 12),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 12,
                                                              vertical: 6),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(3),
                                                          color: Colors.white),
                                                      child: Text(
                                                        '$plastic',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                    InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            plastic++;

                                                            countsWast();
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
                                        ],
                                      )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    //
                    SizedBox(
                      height: 10,
                    ),
                    //
                    //
                    //
                    //
                    //Paper
                    Container(
                      decoration: BoxDecoration(
                          color: gestureTag == 1
                              ? Colors.green[100]
                              : Colors.white,
                          border: Border.all(color: Colors.green)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      gestureTag = 1;
                                      _onGesturTap(gestureTag);
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Image(
                                          image: AssetImage(
                                              "assets/images/paper2.png")),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        AppLocalizations.of(context).paperText,
                                        style: TextStyle(
                                            color: Colors.green, fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                //
                                barcode != null
                                    ? SizedBox.shrink()
                                    : Column(
                                        children: [
                                          SizedBox(
                                            height: 50,
                                            width: 120,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.all(3),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: Colors.green),
                                                child: Row(
                                                  children: [
                                                    InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            paper--;
                                                            // countsWast();
                                                          });
                                                        },
                                                        child: Icon(
                                                          Icons.remove,
                                                          color: Colors.white,
                                                          size: 16,
                                                        )),
                                                    Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 12),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 12,
                                                              vertical: 6),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(3),
                                                          color: Colors.white),
                                                      child: Text(
                                                        '$paper',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                    InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            paper++;

                                                            //countsWast();
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
                                              // SizedBox(
                                              //   height: 25,
                                              //   width: 50,
                                              //   child: TextButton(
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
                                              // SizedBox(width: 11),
                                              // SizedBox(
                                              //   height: 25,
                                              //   width: 50,
                                              //   child: ElevatedButton(
                                              //     style:
                                              //         ElevatedButton.styleFrom(
                                              //       shape:
                                              //           RoundedRectangleBorder(
                                              //               borderRadius:
                                              //                   BorderRadius
                                              //                       .circular(
                                              //                           18.0),
                                              //               side: BorderSide(
                                              //                   color: Colors
                                              //                       .green)),
                                              //       primary: Colors.green,
                                              //       textStyle: TextStyle(
                                              //         color: Colors.white,
                                              //       ),
                                              //     ),
                                              //     onPressed: () {
                                              //       wastesCount[1]++;
                                              //       print(wastesCount);
                                              //     },
                                              //     child: Text("+",
                                              //         style: TextStyle(
                                              //             fontSize: 14)),
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ],
                                      )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    //
                    SizedBox(
                      height: 10,
                    ),
                    //
                    //
                    //
                    //
                    //Glass
                    Container(
                      decoration: BoxDecoration(
                          color: gestureTag == 2
                              ? Colors.green[100]
                              : Colors.white,
                          border: Border.all(
                            color: Colors.green,
                          )),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      gestureTag = 2;
                                      _onGesturTap(gestureTag);
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Image(
                                          image: AssetImage(
                                              "assets/images/glass2.png")),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        AppLocalizations.of(context).glassText,
                                        style: TextStyle(
                                            color: Colors.green, fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 13,
                                  height: 15,
                                ),
                                //
                                barcode != null
                                    ? SizedBox.shrink()
                                    : Column(
                                        children: [
                                          SizedBox(
                                            height: 50,
                                            width: 153,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.all(3),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: Colors.green),
                                                child: Row(
                                                  children: [
                                                    InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            if (glass >= 0) {
                                                              glass--;
                                                            }

                                                            //  countsWast();
                                                          });
                                                        },
                                                        child: Icon(
                                                          Icons.remove,
                                                          color: Colors.white,
                                                          size: 16,
                                                        )),
                                                    Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 12),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 12,
                                                              vertical: 6),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(3),
                                                          color: Colors.white),
                                                      child: Text(
                                                        '$glass',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                    InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            //wastesCount[2]++;
                                                            glass++;

                                                            // countsWast();
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
                                              // SizedBox(
                                              //   height: 25,
                                              //   width: 50,
                                              //   child: TextButton(
                                              //     style: TextButton.styleFrom(
                                              //       shape:
                                              //           RoundedRectangleBorder(
                                              //               borderRadius:
                                              //                   BorderRadius
                                              //                       .circular(
                                              //                           18.0),
                                              //               side: BorderSide(
                                              //                   color: Colors
                                              //                       .red)),
                                              //       primary: Colors.red,
                                              //       textStyle: TextStyle(
                                              //         color: Colors.black,
                                              //       ),
                                              //       padding:
                                              //           EdgeInsets.all(1.0),
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
                                              // SizedBox(width: 5),
                                              // SizedBox(
                                              //   height: 25,
                                              //   width: 50,
                                              //   child: ElevatedButton(
                                              //     style:
                                              //         ElevatedButton.styleFrom(
                                              //       shape:
                                              //           RoundedRectangleBorder(
                                              //               borderRadius:
                                              //                   BorderRadius
                                              //                       .circular(
                                              //                           18.0),
                                              //               side: BorderSide(
                                              //                   color: Colors
                                              //                       .green)),
                                              //       primary: Colors.green,
                                              //       textStyle: TextStyle(
                                              //         color: Colors.white,
                                              //       ),
                                              //     ),
                                              //     onPressed: () {
                                              //       wastesCount[2]++;
                                              //       print(wastesCount);
                                              //     },
                                              //     child: Text("+",
                                              //         style: TextStyle(
                                              //             fontSize: 14)),
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ],
                                      )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    //
                    //buy bag
                    Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 12.0,
                        ),
                        ConstrainedBox(
                          constraints:
                              BoxConstraints(minWidth: double.infinity),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.green)),
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
                              AppLocalizations.of(context).orederBagsButtonText,
                              style: TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              // constraints: BoxConstraints(
                              //     minWidth: screenSize.width * 0.3),
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.green)),
                                  primary: Colors.green,
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                  padding: EdgeInsets.all(8.0),
                                ),
                                onPressed: () {
                                  Navigator.pop(context, wastes);
                                },
                                child: Text(
                                  AppLocalizations.of(context)
                                      .addAnotherBagText,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              // constraints: BoxConstraints(
                              //     minWidth: screenSize.width * 0.4),
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
                                  _sendWastes();
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => SchedulScreen(
                                            countwast: [plastic, paper, glass],
                                          )));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      AppLocalizations.of(context)
                                          .nextButtonText,
                                      style: TextStyle(fontSize: 14)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                    //
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Waste>> _sendWastes() async {
    List<Waste> wastes = [];
    try {
      dynamic token = FlutterSession().get('token');
      var url = Uri.parse(ApiEndpoints.pickupAdd);
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print(response.body);

      var body = jsonDecode(response.body);
      inspect(body);
      if (response.statusCode == 200) {
        return wastes = List<Waste>.from(body.map((e) => Pickup.fromJson(e)));
      } else {
        throw Exception("Fadiled create");
      }
    } catch (error) {
      print(error);
    }
    return wastes;
  }
}
