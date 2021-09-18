import 'package:equatable/equatable.dart';
import 'package:smart_apaga/LoginRegister/model/Contacts.dart';

abstract class PhoneNmEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PhoneNmChanged extends PhoneNmEvent {
  final String phoneNm;

  PhoneNmChanged({this.phoneNm});
}

class PhoneNmAdded extends PhoneNmEvent {
  final Contact phoneNm;
  PhoneNmAdded({this.phoneNm});
}
