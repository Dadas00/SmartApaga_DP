import 'package:flutter/material.dart';
import 'package:smart_apaga/Home/Home/PickupListManager.dart';
import 'package:smart_apaga/Pickup/Model/Pickup.dart';
import 'package:smart_apaga/Pickup/Model/Wast.dart';
import 'package:smart_apaga/Pickup/PickupBloc/PickupBlocWithEnum.dart';
import 'package:smart_apaga/globals.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class PickupListItem extends StatelessWidget {
  final Pickup pickup;
  final bool isPassed;

  PickupListItem(
    this.pickup,
    this.isPassed,
  );
  PickupListManagerState pickupListManagerState = PickupListManagerState();

  final _pickupBloc = PickupBlocs();

  // ignore: missing_return
  List<int> westCounter(List<Waste> wastes) {
    //   var counts = [0, 0, 0];
    //   wastes.forEach((element) {
    //     switch (element.type) {
    //       case 'plastic':
    //         {
    //           counts[0] += 1;
    //         }
    //         break;
    //       case 'paper':
    //         {
    //           counts[1] += 1;
    //         }
    //         break;
    //       case 'glass':
    //         {
    //           counts[2] += 1;
    //         }
    //         break;
    //     }
    //   });
    //   return counts;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // List<int> westCounts = westCounter(pickup.waste);
    // int plasticCount = westCounts[0];
    // int paperCount = westCounts[1];
    // int glassCount = westCounts[2];
    // int bagCount = pickup.bagCount;

    var screenSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.grey[300])),
      child: Column(
        children: [
          Container(
            color: Colors.grey[300],
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(image: AssetImage('assets/images/calendar.png')),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    pickup.date,
                    style: TextStyle(backgroundColor: Colors.white),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Image(image: AssetImage('assets/images/clock.png')),
                  Text(
                    pickup.timeBegin,
                    style: TextStyle(backgroundColor: Colors.white),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text('To'),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    pickup.timeEnd,
                    style: TextStyle(backgroundColor: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          //Address
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Address',
                      style: TextStyle(color: Colors.green),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Text(
                      pickup.address.streetName,
                      style: TextStyle(backgroundColor: Colors.white),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.grey,
                )
              ],
            ),
          ),
          //waste type
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Pickup Description',
                      style: TextStyle(color: Colors.green, fontSize: 12),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Image(image: AssetImage('assets/images/plastic1.png')),
                    SizedBox(
                      width: 10,
                    ),
                    // Text(
                    //   'x $plasticCount',
                    //   style: TextStyle(color: Colors.green),
                    // ),
                    SizedBox(
                      width: 20,
                    ),
                    Image(image: AssetImage('assets/images/paper1.png')),
                    SizedBox(
                      width: 10,
                    ),
                    // Text(
                    //   'x $paperCount',
                    //   style: TextStyle(color: Colors.green),
                    // ),
                    SizedBox(
                      width: 20,
                    ),
                    Image(image: AssetImage('assets/images/glass1.png')),
                    SizedBox(
                      width: 10,
                    ),
                    // Text(
                    //   'x $glassCount',
                    //   style: TextStyle(color: Colors.green),
                    // ),
                  ],
                ),
                Divider(
                  color: Colors.grey,
                )
              ],
            ),
          ),
          //Bags
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Bags',
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(
                      width: 83,
                    ),
                    Image(image: AssetImage('assets/images/bag_icon.png')),
                    SizedBox(
                      width: 10,
                    ),
                    // Text(
                    //   'x $bagCount',
                    //   style: TextStyle(color: Colors.green),
                    // ),
                  ],
                ),
                Divider(
                  color: Colors.grey,
                )
              ],
            ),
          ),

          isPassed
              ? SizedBox(
                  height: 0,
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(
                                minWidth: screenSize.width * 0.3),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.green)),
                                primary: Colors.green[400],
                                textStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                padding: EdgeInsets.all(8.0),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                AppLocalizations.of(context).editButtonText,
                                style: TextStyle(
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: screenSize.width * 0.1),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints(minWidth: screenSize.width * 0.3),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red[800],
                            textStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          // shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(18.0),
                          //     side: BorderSide(color: Colors.red[800])),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => new AlertDialog(
                                title: Text('Are you sure?'),
                                content:
                                    Text('Do you want to cancel this pickup ?'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(false);
                                      },
                                      child: Text('No')),
                                  TextButton(
                                      onPressed: () {
                                        _pickupBloc.eventSink.add(
                                            ApiEndpoints.pickupCancel(
                                                pickup.id));
                                      },
                                      child: Text('Yes')),
                                ],
                              ),
                            );
                            //canscElDialog();
                            // _pickupBloc.eventSink
                            //     .add(ApiEndpoints.pickupCancel(pickup.id));
                          },

                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                AppLocalizations.of(context).cancelButton,
                                style: TextStyle(fontSize: 14)),
                          ),
                        ),
                      ),
                    )
                  ],
                ),

          SizedBox(height: isPassed ? 5 : 20),
        ],
      ),
    );
  }

  // Widget _addressList() {
  //   return FutureBuilder(
  //       future: pickupListManagerState.getAddressLIst(),
  //       builder: (context, snapshot) {
  //         List<Widget> children;
  //         if (!snapshot.hasData) {
  //           return Center(
  //             child: Text(
  //               'Empty',
  //               style: TextStyle(color: Colors.red),
  //             ),
  //           );
  //         } else if (snapshot.hasData) {
  //           return Text(snapshot.data.toString());
  //         }
  //         return Row(
  //           children: children,
  //         );
  //       });
  // }
}
