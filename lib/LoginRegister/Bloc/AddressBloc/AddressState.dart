import 'package:smart_apaga/LoginRegister/Bloc/Validators.dart';

class AddressState {
  bool isStreetNameValid;
  bool isBdgValid;
  bool isAptValid;
  bool isFloorValid;
  bool isEntryValid;
  bool isComentValid;
  bool isLatitudeValid;
  bool isLongitudeValid;

  bool isSuccess;
  bool isSumbiting;
  bool isFailure;

  //final bool isPlaceId;

  bool get isAddressValid =>
      isStreetNameValid.toString().isNotEmpty &&
      isBdgValid.toString().isNotEmpty &&
      isAptValid.toString().isNotEmpty &&
      isFloorValid.toString().isNotEmpty &&
      isEntryValid.toString().isNotEmpty &&
      isComentValid.toString().isNotEmpty;

  AddressState({
    this.isStreetNameValid,
    this.isBdgValid,
    this.isAptValid,
    this.isFloorValid,
    this.isEntryValid,
    this.isComentValid,
    this.isLatitudeValid,
    this.isLongitudeValid,
    this.isSuccess,
    this.isSumbiting,
    this.isFailure,
  });

  factory AddressState.initial() => AddressState(
        isStreetNameValid: true,
        isBdgValid: true,
        isAptValid: true,
        isEntryValid: true,
        isComentValid: true,
        isFloorValid: true,
        isLatitudeValid: true,
        isLongitudeValid: true,
        isFailure: false,
        isSuccess: false,
        isSumbiting: false,
      );

  factory AddressState.loading(Map addresMap) {
    return AddressState(
      isStreetNameValid: Validators.isValidStreetName(addresMap['streetName']),
      isBdgValid: Validators.isValidBdg(addresMap['bgd']),
      isAptValid: Validators.isValidapt(addresMap['apt']),
      isEntryValid: Validators.isValidEntry(addresMap['entry']),
      isFloorValid: Validators.isValidfloor(addresMap['floor']),
      isComentValid: Validators.isValidComent(addresMap['comment']),
      isLatitudeValid: Validators.isValidLatitude(addresMap['latirde']),
      isLongitudeValid: Validators.isValidLongitude(addresMap['longitude']),
      isFailure: false,
      isSuccess: false,
      isSumbiting: true,
    );
  }

  factory AddressState.failure() => AddressState(
        isStreetNameValid: false,
        isBdgValid: false,
        isAptValid: false,
        isFloorValid: false,
        isEntryValid: false,
        isComentValid: false,
        isLatitudeValid: false,
        isLongitudeValid: false,
        isFailure: true,
        isSuccess: false,
        isSumbiting: false,
      );
  factory AddressState.success() => AddressState(
        isStreetNameValid: true,
        isBdgValid: true,
        isAptValid: true,
        isEntryValid: true,
        isComentValid: true,
        isFloorValid: true,
        isLatitudeValid: true,
        isLongitudeValid: false,
        isFailure: false,
        isSuccess: true,
        isSumbiting: false,
      );

  AddressState update({
    bool isStreetNameValid,
    bool isBdgValid,
    bool isAptValid,
    bool isFloorValid,
    bool isEntryValid,
    bool isComentValid,
    bool isLatitudeValid,
    bool isLongitudeValid,
    bool isSuccess,
  }) {
    return copyWith(
      isStreetNameValid: isStreetNameValid,
      isBdgValid: isBdgValid,
      isAptValid: isAptValid,
      isFloorValid: isFloorValid,
      isEntryValid: isEntryValid,
      isComentValid: isComentValid,
      isLatitudeValid: isLatitudeValid,
      isLongitudeValid: isLongitudeValid,
      isSuccess: false,
      isFailure: false,
      isSumbiting: false,
    );
  }

  // factory AddressState.empty() {
  //   return null;
  // }

  AddressState copyWith({
    bool isStreetNameValid,
    bool isBdgValid,
    bool isAptValid,
    bool isFloorValid,
    bool isEntryValid,
    bool isComentValid,
    bool isLatitudeValid,
    bool isLongitudeValid,
    bool isSuccess,
    bool isSumbiting,
    bool isFailure,
  }) {
    return AddressState(
      isStreetNameValid: isStreetNameValid ?? this.isStreetNameValid,
      isBdgValid: isBdgValid ?? this.isBdgValid,
      isAptValid: isAptValid ?? this.isAptValid,
      isFloorValid: isFloorValid ?? this.isFloorValid,
      isEntryValid: isEntryValid ?? this.isEntryValid,
      isComentValid: isComentValid ?? this.isComentValid,
      isLatitudeValid: isLatitudeValid ?? this.isLatitudeValid,
      isLongitudeValid: isLongitudeValid ?? this.isLongitudeValid,
      isFailure: isFailure ?? this.isFailure,
      isSuccess: isSuccess ?? this.isSuccess,
      isSumbiting: isSumbiting ?? this.isSumbiting,
    );
  }
}
