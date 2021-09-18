import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'package:smart_apaga/LoginRegister/Bloc/RegisterBloc/UserRepository.dart';
import 'package:smart_apaga/Pickup/Model/Pickup.dart';
import 'package:smart_apaga/Pickup/PickupBloc/pickupEvent.dart';
import 'package:smart_apaga/Pickup/PickupBloc/pickupState.dart';
import 'package:smart_apaga/globals.dart';

enum PickupAction { Ongoing, Passed, Cancel }

class PickupBloc extends Bloc<PickupEvent, PickupState> {
  UserRepository _userRepositroy;
  PickupBloc({UserRepository userRepositroy})
      : _userRepositroy = userRepositroy,
        super(PickupInitial());
  @override
  Stream<PickupState> mapEventToState(PickupEvent event) async* {
    if (event is PickupSumbited) {
      yield* _getPickupListToState(event.pickup.toMap());
    } else if (event is PicupNoteChanged) {
      yield* _mapnoteChangedtoState(event.note);
    }
    throw UnimplementedError();
  }

  Stream<PickupState> _mapnoteChangedtoState(String note) async* {
    yield state.update(note: note);
  }

  Stream<PickupState> _getPickupListToState(Map pickupMap) async* {
    dynamic token = await FlutterSession().get('token');
    try {
      var url = Uri.parse(ApiEndpoints.pickupsOngoing);
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(pickupMap),
      );
      print(response.body);

      var body = jsonDecode(response.body);

      var data = body['data'];
      print(data);
    } catch (error) {
      print(error);
    }
  }
}
