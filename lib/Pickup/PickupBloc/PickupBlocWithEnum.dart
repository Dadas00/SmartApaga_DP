import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'package:smart_apaga/LoginRegister/Bloc/RegisterBloc/UserRepository.dart';
import 'package:smart_apaga/Pickup/Model/Pickup.dart';
import 'package:smart_apaga/Pickup/PickupBloc/pickupEvent.dart';
import 'package:smart_apaga/Pickup/PickupBloc/pickupState.dart';
import 'package:smart_apaga/globals.dart';

enum PickupAction { Ongoing, Passed, Cancel }

class PickupBlocs {
  int counter;
  final _stateStreamController = StreamController<List<Pickup>>();
  StreamSink<List<Pickup>> get _pickupSink => _stateStreamController.sink;
  Stream<List<Pickup>> get pickupStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<String>();
  StreamSink<String> get eventSink => _eventStreamController.sink;
  Stream<String> get _eventStream => _eventStreamController.stream;

  PickupBlocs() {
    _eventStream.listen((event) async {
      if (event == ApiEndpoints.pickupsOngoing ||
          event == ApiEndpoints.pickupsPassed) {
        try {
          String url;
          if (event == ApiEndpoints.pickupsOngoing) {
            url = ApiEndpoints.pickupsOngoing;
          } else if (event == ApiEndpoints.pickupsPassed) {
            url = ApiEndpoints.pickupsPassed;
          }
          var pickups = await _fetchPickup(url);
          if (pickups != null)
            _pickupSink.add(pickups);
          else
            _pickupSink.addError('Samthing went wrong');
        } on Exception catch (e) {
          _pickupSink.addError('Samthing went wrong: $e');
        }
      } else if (event.contains('cancel')) {
        print(event);
      }

      // counterSink.add(event);
    });
  }

  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }

  Future<List<Pickup>> _fetchPickup(String url) async {
    dynamic token = await FlutterSession().get('token');
    List<Pickup> pickups = [];

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });

      var body = jsonDecode(response.body);

      if (body['status'] == 1) {
        dynamic data = body['data'];
        data.forEach((element) {
          Pickup pickup = Pickup.fromJson(element);
          pickups.add(pickup);
        });
        pickups = List<Pickup>.from(data.map((e) => Pickup.fromJson(e)));
        return pickups;
      }
    } catch (e) {
      return throw Exception('Failed to load album');
    }
    return pickups;
  }
}
