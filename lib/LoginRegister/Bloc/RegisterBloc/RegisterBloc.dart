import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:smart_apaga/LoginRegister/Bloc/RegisterBloc/RegisterEvent.dart';
import 'package:smart_apaga/LoginRegister/Bloc/RegisterBloc/RegisterState.dart';
import 'UserRepository.dart';
import '../Validators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;

  RegisterBloc({UserRepository userRepository})
      : _userRepository = userRepository,
        super(RegisterState.initial());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterFullNameChanged) {
      yield* _mapRegisterFullNameChangeToState(event.fullName);
    } else if (event is RegisterPhoneChanged) {
      yield* _mapRegisterPhoneChangeToState(event.phone);
    } else if (event is RegisterEmailChanged) {
      yield* _mapRegisterEmailChangeToState(event.email);
    } else if (event is RegisterPasswordChanged) {
      yield* _mapRegisterPasswordChangeToState(event.password);
    } else if (event is RegisterLegalNameChanged) {
      yield* _mapRegisterLegalNameChangeToState(event.legalName);
    } else if (event is RegisterTaxCodeChanged) {
      yield* _mapRegisterTaxCodeChangeToState(event.taxCode);
    } else if (event is RegisterLegalAddressChanged) {
      yield* _mapRegisterLegalAddressChangeToState(event.legalAddress);
    } else if (event is RegisterSdnChanged) {
      yield* _mapRegisterSdnChangeToState(event.sdn);
    } else if (event is RegisterCompanyEmailChanged) {
      yield* _mapRegisterCompanyEmailChangeToState(event.companyEmail);
    } else if (event is RegisterSubmitted) {
      yield* _mapRegisterSubmittedToState(event.user.toMap());
    }
  }

  Stream<RegisterState> _mapRegisterFullNameChangeToState(String name) async* {
    yield state.update(isFullNameValid: Validators.isValidFullName(name));
  }

  Stream<RegisterState> _mapRegisterPhoneChangeToState(String phone) async* {
    yield state.update(isPhoneValid: Validators.isValidPhone(phone));
  }

  Stream<RegisterState> _mapRegisterEmailChangeToState(String email) async* {
    yield state.update(isEmailValid: Validators.isValidEmail(email));
  }

  Stream<RegisterState> _mapRegisterPasswordChangeToState(
      String password) async* {
    yield state.update(isPasswordValid: Validators.isValidPassword(password));
  }

  Stream<RegisterState> _mapRegisterLegalNameChangeToState(
      String legalName) async* {
    yield state.update(
        isLegalNameValid: Validators.isValidLegalName(legalName));
  }

  Stream<RegisterState> _mapRegisterTaxCodeChangeToState(
      String taxCode) async* {
    yield state.update(isTaxCodeValid: Validators.isValidTaxCode(taxCode));
  }

  Stream<RegisterState> _mapRegisterLegalAddressChangeToState(
      String legalAddress) async* {
    yield state.update(
        isLegalAddressValid: Validators.isValidLegalAddress(legalAddress));
  }

  Stream<RegisterState> _mapRegisterSdnChangeToState(String sdn) async* {
    yield state.update(isSdnValid: Validators.isValidSdn(sdn));
  }

  Stream<RegisterState> _mapRegisterCompanyEmailChangeToState(
      String companyEmail) async* {
    yield state.update(
        isCompanyEmailValid: Validators.isValidEmail(companyEmail));
  }

  Stream<RegisterState> _mapRegisterSubmittedToState(Map userMap) async* {
    RegisterState.loading(userMap);
    try {
      final response = await http.post(
        Uri.parse(api_url + '/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(userMap),
      );

      var body = jsonDecode(response.body);
      print(body);
      var data = body['data'];

      if (response.statusCode == 200) {
        String token = data['access_token'];
        await FlutterSession().set('token', token);
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setBool('register', true);
        yield RegisterState.success();
      } else {
        yield RegisterState.failure();
      }
    } catch (error) {
      print(error);
      yield RegisterState.failure();
    }
  }
}
