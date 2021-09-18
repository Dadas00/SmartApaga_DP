import 'dart:convert';
import 'dart:developer';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:smart_apaga/LoginRegister/model/Address.dart';
import 'package:smart_apaga/globals.dart';
import 'PickupListItem.dart';
import 'package:smart_apaga/Home/Home/NoPickupItem.dart';
import 'package:smart_apaga/Home/Home/OrderBagsItem.dart';
// import 'package:smart_apaga/LoginRegister/model/Address.dart';
import 'package:smart_apaga/Pickup/Model/Pickup.dart';
import 'package:smart_apaga/Pickup/PickupBloc/PickupBlocWithEnum.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PickupListManager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PickupListManagerState();
  }
}

class PickupListManagerState extends State<PickupListManager> {
  int groupedValue = 0;

  List<Pickup> _pickups = [
    Pickup(
      address: Address(
        apt: 'asdf',
        bdg: 'dsdff',
        streetName: 'Adonc',
        floor: '12',
        comment: '13',
        latitude: '',
        longitude: '',
      ),
      date: '21.10.20',
      timeBegin: '18:30',
      timeEnd: '19:30',
      waste: [],
      noteForDriver: 'sdfsdf',
      bagCount: 12,
    ),
    Pickup(
      address: Address(
        apt: 'sss',
        bdg: 'aaaa',
        streetName: 'Baxramyan',
        floor: '21',
        comment: '12',
        latitude: '',
        longitude: '',
      ),
      date: '21.10.20',
      timeBegin: '18:30',
      timeEnd: '19:30',
      waste: [],
      noteForDriver: 'sdfsdf',
      bagCount: 7,
    ),
    Pickup(
      address: Address(
        apt: 'llll',
        bdg: 'pppp',
        streetName: 'Tumanyan',
        floor: '45',
        comment: '31',
        latitude: '',
        longitude: '',
      ),
      date: '21.10.20',
      timeBegin: '18:30',
      timeEnd: '19:30',
      waste: [],
      noteForDriver: 'laladen',
      bagCount: 5,
    ),
  ];

  final pickupBloc = PickupBlocs();
  int purchasedBagCount = 1;
  bool isPassed = false;

  int _itemCount() {
    int count = _pickups.length == 0 ? _pickups.length + 1 : _pickups.length;
    return purchasedBagCount != 0 ? count + 1 : count;
  }

  void _changeSegmentedControl(int value) {
    if (value == 0) {
      pickupBloc.eventSink.add(ApiEndpoints.pickupsOngoing);
      isPassed = false;
    } else {
      isPassed = true;
      pickupBloc.eventSink.add(ApiEndpoints.pickupsPassed);
    }
  }

  @override
  void initState() {
    pickupBloc.eventSink.add(ApiEndpoints.pickupsOngoing);
    super.initState();
  }

  @override
  void dispose() {
    pickupBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<int, Widget> segmentedItemList = {
      0: Text(AppLocalizations.of(context).ongoingText,
          style: TextStyle(color: Colors.black)),
      1: Text(AppLocalizations.of(context).passedText,
          style: TextStyle(color: Colors.black))
    };

    return FutureBuilder(
        future: null,
        builder: (context, snapshot) {
          if (snapshot.hasData || snapshot.data != null) {
            inspect(snapshot.data);
            _pickups = snapshot.data;
            isPassed = groupedValue == 0 ? false : true;
          }

          var screenSize;
          return Column(children: [
            Container(
              width: 300,
              child: CupertinoSegmentedControl<int>(
                  borderColor: Colors.grey,
                  selectedColor: Colors.white,
                  unselectedColor: Colors.grey,
                  children: segmentedItemList,
                  groupValue: groupedValue,
                  onValueChanged: (value) {
                    setState(() {
                      groupedValue = value;
                      _changeSegmentedControl(value);
                    });
                  }),
            ),

            //List items
            Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.all(20.0),
                    itemCount: 2,
                    // itemCount: _itemCount(),
                    itemBuilder: (BuildContext context, int index) {
                      if (purchasedBagCount != 0 && index == 0) {
                        return OrderBagsItem(purchasedBagCount);
                      }

                      if (_pickups.length != 0) {
                        // int i = purchasedBagCount != 0 ? index - 1 : index;
                        // return PickupListItem(_pickups[i], isPassed);
                        return Center(
                          child: Text('Eli Araaaaaaaaaaa'),
                        );
                      }

                      return NoPickupItem();
                    })),
          ]);
        });
  }

  List<void> parsePickups(String reponseBody) {
    final parsed = jsonDecode(reponseBody).cast<Map<String, dynamic>>();
    return parsed.map<Pickup>((json) => Pickup.fromJson(json)).toList();
  }

  Future<void> getPickupLIst() async {
    dynamic token = await FlutterSession().get('token');
    //List<Pickup> pickups = [];
    try {
      dynamic response = await http.get(
        Uri.parse(ApiEndpoints.pickupsOngoing),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      response =
          '[{"id":1,"customer_id":1,"country":"Am","administrative_area":"Yerevan","locality":"Yerevan","district":"Yerevan","street":"Tumanyan","building":"28","apartment":"5","entrance":"5","intercom":"25525","postal_code":"2525","is_default":0,"status":"active","lat":216516,"lng":1651651},{"id":2,"customer_id":1,"country":"AM","administrative_area":"Yerevan","locality":"Yerevan","district":null,"street":null,"building":"3","apartment":null,"entrance":null,"intercom":null,"postal_code":null,"is_default":0,"status":"active","lat":40.1872023,"lng":44.515209},{"id":3,"customer_id":1,"country":"AM","administrative_area":"Yerevan","locality":"Yerevan","district":null,"street":null,"building":"4567","apartment":null,"entrance":null,"intercom":null,"postal_code":null,"is_default":0,"status":"active","lat":40.1872023,"lng":44.515209}]';

      dynamic newRes = parsePickups(response);

      // var body = jsonDecode(response.body);

      // if (body['status'] == 1) {
      //   dynamic data = body['data'];
      //   data.forEach((element) {
      //     Pickup pickup = Pickup.fromJson(element);
      //     pickups.add(pickup);
      //   });
      //   pickups = List<Pickup>.from(data.map((e) => Pickup.fromJson(e)));
      //   return pickups;
      // }
      if (response.statusCode == 200) {
        jsonDecode(response.body);
        print(response.body);
      }
      inspect(newRes);
      return newRes;
    } catch (e) {
      print(e);
    }
    // return pickups;
  }

  List<Address> parseAddress(String reponseAddress) {
    final parsed = jsonDecode(reponseAddress).cast<Map<String, dynamic>>();
    return parsed.map<Address>((json) => Address.fromJson(json)).toList();
  }

  Future<void> getAddressLIst() async {
    dynamic token = FlutterSession().get('token');

    try {
      dynamic response = await http.get(
        Uri.parse(ApiEndpoints.pickupsOngoing),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      response =
          // '[{"id":1,"customer_id":1,"country":"Am","administrative_area":"Yerevan","locality":"Yerevan","district":"Yerevan","street":"Tumanyan","building":"28","apartment":"5","entrance":"5","intercom":"25525","postal_code":"2525","is_default":0,"status":"active","lat":216516,"lng":1651651},{"id":2,"customer_id":1,"country":"AM","administrative_area":"Yerevan","locality":"Yerevan","district":null,"street":null,"building":"3","apartment":null,"entrance":null,"intercom":null,"postal_code":null,"is_default":0,"status":"active","lat":40.1872023,"lng":44.515209},{"id":3,"customer_id":1,"country":"AM","administrative_area":"Yerevan","locality":"Yerevan","district":null,"street":null,"building":"4567","apartment":null,"entrance":null,"intercom":null,"postal_code":null,"is_default":0,"status":"active","lat":40.1872023,"lng":44.515209}]';
          '[{"id":1,"phoneNumber":"077021013"}]';
      dynamic newRes = parseAddress(response);

      inspect(newRes);

      return newRes;
    } catch (error) {
      print(error);
    }
  }
}
