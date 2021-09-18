import 'package:flutter/cupertino.dart';

class Address {
  String streetName = 'AllaAkbar';
  String bdg = '66';
  String apt = '21';
  String floor = '12';
  String entry = 'yerevan';
  String comment = 'daas';
  String latitude = '525333';

  String longitude = '253200';
  String placeId = '1';
  int id;

  Address(
      {this.streetName,
      this.bdg,
      this.latitude,
      this.longitude,
      this.apt,
      this.floor,
      this.entry,
      this.comment,
      this.placeId,
      this.id});

  bool isExpanded = false;
  Map toMap() {
    return {
      'streetName': streetName,
      'bdg': bdg,
      'apt': apt ?? '',
      'floor': floor ?? '',
      'entry': entry ?? '',
      'comment': comment ?? '',
      'latitude': latitude ?? '',
      'longitude': longitude ?? '',
      'placeId': placeId ?? '',
    };
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      streetName: json['streetName'] as String,
      bdg: json['bdg'] as String,
      apt: json['apt'] as String,
      floor: json['floor'] as String,
      entry: json['entry'] as String,
      longitude: json['longitude'] as String,
      latitude: json['latitude'] as String,
      placeId: json['placeId'] as String,
      id: json['id'] as int,
    );
  }
}
