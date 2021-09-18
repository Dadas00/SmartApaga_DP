import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:smart_apaga/LoginRegister/model/Address.dart';
import 'package:smart_apaga/Pickup/Model/Wast.dart';

class Pickup {
  Address address;
  String date;
  String timeBegin;
  String timeEnd;
  List<Waste> waste;
  String noteForDriver;
  int bagCount;
  int id;

  Pickup({
    this.address,
    this.date,
    this.timeBegin,
    this.timeEnd,
    this.waste,
    this.noteForDriver,
    this.bagCount,
    this.id,
  });

  Map toMap() {
    Map wasteMap = {};

    waste.forEach((element) {
      wasteMap.addAll(element.toMap());
    });

    return {
      'address': address.id ?? 1,
      'date': date,
      'timeBegin': timeBegin,
      'timeEnd': timeEnd,
      'waste': wasteMap,
      'noteForDriver': noteForDriver,
      'bagCount': bagCount,
    };
  }

  factory Pickup.fromJson(Map<String, dynamic> json) {
    List<Waste> waste = [];
    dynamic jsonWaste = json['pickup_bag'];
    jsonWaste.forEach((element) {
      dynamic bagCode = element['bag_code'];
      dynamic type = element['waste_type'];
      dynamic plastic = element['plastic'];
      dynamic paper = element['papaer'];
      dynamic glass = element['glass'];
      Waste ws = Waste(
          bagCode: bagCode,
          type: type,
          plastic: plastic,
          paper: paper,
          glass: glass);
      waste.add(ws);
    });

    Address address = Address(
        latitude: '1', longitude: '2', streetName: 'Adonc', floor: '12');

    return Pickup(
        address: address,
        date: json['order_date'],
        timeBegin: json['order_start_time'],
        timeEnd: json['order_time_end'],
        waste: waste,
        noteForDriver: json['order_time_end'],
        bagCount: json['id'],
        id: json['id']);
  }
}
