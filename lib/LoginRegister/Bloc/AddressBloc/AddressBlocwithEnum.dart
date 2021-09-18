import 'dart:async';
import 'dart:convert';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'package:smart_apaga/LoginRegister/model/Address.dart';
//import 'package:smart_apaga/LoginRegister/model/Addresses.dart';
import 'package:smart_apaga/Pickup/Model/Pickup.dart';
import 'package:smart_apaga/globals.dart';

enum AddressAction { Ongoing, Passed, Cancel }

class AddressBloctwo {
  int counter;
  final _stateStreamController = StreamController<List<Address>>();

  List<Pickup> pickups;
  StreamSink<List<Address>> get _addressSink => _stateStreamController.sink;
  Stream<List<Address>> get addressStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<String>();
  StreamSink<String> get eventSink => _eventStreamController.sink;
  Stream<String> get _eventStream => _eventStreamController.stream;

  AddressBloctwo() {
    _eventStream.listen((event) async {
      try {
        String url;
        if (event == ApiEndpoints.addressAdd) {
          url = ApiEndpoints.pickupsOngoing;
        } else if (event == ApiEndpoints.pickupsPassed) {
          url = ApiEndpoints.pickupsPassed;
        }
        var pickups = await fetchAddresses(url);
        if (pickups != null)
          _addressSink.add(pickups);
        else
          _addressSink.addError('Samthing went wrong');
      } on Exception catch (e) {
        _addressSink.addError('Samthing went wrong: $e');
      }
    });
  }

  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }

  Future<List<Address>> fetchAddresses(String url) async {
    dynamic token = await FlutterSession().get('token');
    List<Address> addresses = [];

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });

      var body = jsonDecode(response.body);

      if (body['status'] == 1) {
        dynamic data = body['data'];
        data.forEach((element) {
          Address address = Address.fromJson(element);
          addresses.add(address);
        });
        pickups = List<Pickup>.from(data.map((e) => Pickup.fromJson(e)));
        return addresses;
      }
    } catch (e) {
      throw Exception('Failed to load');
    }
    return addresses;
  }
}
