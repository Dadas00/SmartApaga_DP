import 'package:smart_apaga/LoginRegister/Bloc/Validators.dart';

class RegisterState {
  final bool isFullNameValid;
  final bool isPhoneValid;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isLegalNameValid;
  final bool isTaxCodeValid;
  final bool isLegalAddressValid;
  final bool isSdnValid;
  final bool isCompanyEmailValid;

  final bool isCompany;
  final bool disclimer;

  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get _isUserValid =>
      isFullNameValid && isPhoneValid && isEmailValid && isPasswordValid;
  bool get _isCompanyValid =>
      isLegalNameValid &&
      isTaxCodeValid &&
      isLegalAddressValid &&
      isSdnValid &&
      isCompanyEmailValid;

  bool get isFormValid =>
      !isCompany ? _isUserValid : _isUserValid && _isCompanyValid;

  RegisterState(
      {this.isFullNameValid,
      this.isPhoneValid,
      this.isEmailValid,
      this.isPasswordValid,
      this.isLegalNameValid,
      this.isTaxCodeValid,
      this.isLegalAddressValid,
      this.isSdnValid,
      this.isCompanyEmailValid,
      this.isSubmitting,
      this.isSuccess,
      this.isFailure,
      this.isCompany,
      this.disclimer});

  factory RegisterState.initial() {
    return RegisterState(
      isFullNameValid: true,
      isPhoneValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isLegalNameValid: true,
      isTaxCodeValid: true,
      isLegalAddressValid: true,
      isSdnValid: true,
      isCompanyEmailValid: true,
      isCompany: true,
      disclimer: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegisterState.loading(Map userMap) {
    return RegisterState(
      isFullNameValid: true,
      isPhoneValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isLegalNameValid: userMap['company'] != null
          ? Validators.isValidLegalName(userMap['company']['name'])
          : true,
      isTaxCodeValid: userMap['company'] != null
          ? Validators.isValidTaxCode(userMap['company']['taxCode'])
          : true,
      isLegalAddressValid: userMap['company'] != null
          ? Validators.isValidLegalAddress(userMap['company']['legalAddress'])
          : true,
      isSdnValid: userMap['company'] != null
          ? Validators.isValidSdn(userMap['company']['signingDirector'])
          : true,
      isCompanyEmailValid: userMap['company'] != null
          ? Validators.isValidEmail(userMap['company']['email'])
          : true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegisterState.failure() {
    return RegisterState(
      isFullNameValid: true,
      isPhoneValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isLegalNameValid: true,
      isTaxCodeValid: true,
      isLegalAddressValid: true,
      isSdnValid: true,
      isCompanyEmailValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory RegisterState.success() {
    return RegisterState(
      isFullNameValid: true,
      isPhoneValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isLegalNameValid: true,
      isTaxCodeValid: true,
      isLegalAddressValid: true,
      isSdnValid: true,
      isCompanyEmailValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  RegisterState update(
      {bool isFullNameValid,
      bool isPhoneValid,
      bool isEmailValid,
      bool isPasswordValid,
      bool isLegalNameValid,
      bool isTaxCodeValid,
      bool isLegalAddressValid,
      bool isSdnValid,
      bool isCompanyEmailValid}) {
    return copyWith(
      isFullNameValid: isFullNameValid,
      isPhoneValid: isPhoneValid,
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isLegalNameValid: isLegalNameValid,
      isTaxCodeValid: isTaxCodeValid,
      isLegalAddressValid: isLegalAddressValid,
      isSdnValid: isSdnValid,
      isCompanyEmailValid: isCompanyEmailValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  RegisterState copyWith({
    bool isFullNameValid,
    bool isPhoneValid,
    bool isEmailValid,
    bool isPasswordValid,
    bool isLegalNameValid,
    bool isTaxCodeValid,
    bool isLegalAddressValid,
    bool isSdnValid,
    bool isCompanyEmailValid,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return RegisterState(
      isFullNameValid: isFullNameValid ?? this.isFullNameValid,
      isPhoneValid: isPhoneValid ?? this.isPhoneValid,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isLegalNameValid: isLegalNameValid ?? this.isLegalNameValid,
      isTaxCodeValid: isTaxCodeValid ?? this.isTaxCodeValid,
      isLegalAddressValid: isLegalAddressValid ?? this.isLegalAddressValid,
      isSdnValid: isSdnValid ?? this.isSdnValid,
      isCompanyEmailValid: isCompanyEmailValid ?? this.isCompanyEmailValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }
}
