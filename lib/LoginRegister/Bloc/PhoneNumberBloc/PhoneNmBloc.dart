import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:smart_apaga/LoginRegister/Bloc/PhoneNumberBloc/PhoneNmEvent.dart';
import 'package:smart_apaga/LoginRegister/Bloc/PhoneNumberBloc/PhoneNmState.dart';
import 'package:smart_apaga/LoginRegister/Bloc/RegisterBloc/UserRepository.dart';
import 'package:smart_apaga/LoginRegister/Bloc/Validators.dart';
import 'package:smart_apaga/globals.dart';

class PhoneNmBloc extends Bloc<PhoneNmEvent, PhoneNmState> {
  UserRepository _userRepository;

  PhoneNmBloc({UserRepository userRepository})
      : _userRepository = userRepository,
        super(PhoneNmState.initial());

  @override
  Stream<PhoneNmState> mapEventToState(PhoneNmEvent event) async* {
    if (event is PhoneNmChanged) {
      yield* _mapPhoneNmChangedState(event.phoneNm);
    } else if (event is PhoneNmAdded) {
      yield* _mapAddedtoState(event.phoneNm.toMap());
    }
  }

  Stream<PhoneNmState> _mapPhoneNmChangedState(String phoneNm) async* {
    yield state.update(isPhoneNm: Validators.isValidContactPhoneNm(phoneNm));
  }

  Stream<PhoneNmState> _mapAddedtoState(Map phoneNmMap) async* {
    try {
      dynamic token = await FlutterSession().get('token');

      var url = Uri.parse(ApiEndpoints.addressAdd);
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(phoneNmMap),
      );
      print(response.body);
      // var body = jsonDecode(response.body);
      // var data = body['data'];

      // if (data['status'] == 1) {
      //   yield PhoneNmState.added();
      // } else {
      //   yield PhoneNmState.failue();
      // }
    } catch (error) {}
  }
}
