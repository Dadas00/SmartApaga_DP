import 'package:smart_apaga/LoginRegister/Bloc/Validators.dart';

class PhoneNmState {
  bool isPhoneNmValid;
  bool isFailure;
  bool isAdded;
  bool isAdding;
  PhoneNmState({
    this.isPhoneNmValid,
    this.isAdded,
    this.isFailure,
    this.isAdding,
  });

  factory PhoneNmState.initial() {
    return PhoneNmState(
      isPhoneNmValid: true,
      isAdded: false,
      isAdding: false,
      isFailure: false,
    );
  }
  factory PhoneNmState.added() {
    return PhoneNmState(
      isPhoneNmValid: false,
      isAdded: true,
      isFailure: false,
      isAdding: false,
    );
  }

  factory PhoneNmState.adding(Map phoneMap) {
    return PhoneNmState(
      isPhoneNmValid: Validators.isValidContactPhoneNm(phoneMap['number']),
      isAdded: false,
      isFailure: false,
      isAdding: true,
    );
  }

  factory PhoneNmState.failue() {
    return PhoneNmState(
      isPhoneNmValid: false,
      isFailure: true,
      isAdded: false,
      isAdding: false,
    );
  }

  PhoneNmState update({
    bool isPhoneNm,
    bool isFailure,
    bool isAdded,
    bool isAdding,
  }) {
    return copyWith(
      isPhoneNm: isPhoneNm,
      isFailure: false,
      isAdded: false,
      isAdding: false,
    );
  }

  PhoneNmState copyWith({
    bool isPhoneNm,
    bool isFailure,
    bool isAdded,
    bool isAdding,
  }) {
    return PhoneNmState(
      isPhoneNmValid: isPhoneNm ?? this.isPhoneNmValid,
      isAdded: isAdded ?? this.isAdded,
      isFailure: isFailure ?? this.isFailure,
    );
  }
}
