import 'package:equatable/equatable.dart';
import 'package:smart_apaga/LoginRegister/model/Address.dart';
//import 'package:smart_apaga/LoginRegister/model/Addresses.dart';

abstract class AddressEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddressStreetNameChanged extends AddressEvent {
  final String streetName;
  AddressStreetNameChanged({this.streetName});

  @override
  List<Object> get props => [streetName];
}

class AddressBgdChanged extends AddressEvent {
  final String bgd;
  AddressBgdChanged({this.bgd});
  @override
  List<Object> get props => [bgd];
}

class AddressAptChanged extends AddressEvent {
  final String apt;
  AddressAptChanged({this.apt});

  @override
  List<Object> get props => [apt];
}

class AddressfloorChanged extends AddressEvent {
  final String floor;
  AddressfloorChanged({this.floor});

  @override
  List<Object> get props => [floor];
}

class AddressEntryChanged extends AddressEvent {
  final String entry;
  AddressEntryChanged({this.entry});

  @override
  List<Object> get props => [entry];
}

class AddressComentChanged extends AddressEvent {
  final String coment;
  AddressComentChanged({this.coment});

  @override
  List<Object> get props => [coment];
}

class AddressLatitudeChanged extends AddressEvent {
  final String latitude;
  AddressLatitudeChanged({this.latitude});

  @override
  List<Object> get props => [latitude];
}

class AddressLongitudeChanged extends AddressEvent {
  final String longitude;
  AddressLongitudeChanged({this.longitude});

  @override
  List<Object> get props => [longitude];
}

class AddressPlaceIdChanged extends AddressEvent {
  final String placeId;
  AddressPlaceIdChanged({this.placeId});

  @override
  List<Object> get props => [placeId];
}

class AddressSubmitted extends AddressEvent {
  final Address addresses;

  AddressSubmitted({this.addresses});

  @override
  List<Object> get props => [addresses];
}

// class AddresIdChanged extends AddressEvent {
//   final int id;
//   AddresIdChanged({this.id});

//   @override
//   List<Object> get props => [id];
// }