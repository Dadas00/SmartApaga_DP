import 'package:flutter/foundation.dart';

class Waste {
  String bagCode;
  String type;
  String paper;
  String glass;
  String plastic;
  Waste({
    this.bagCode,
    @required this.type,
    this.plastic,
    this.paper,
    this.glass,
  });

  Map toMap() {
    return {
      'bagCode': bagCode ?? '',
      'type': type ?? '',
      'paper': paper ?? '',
      'glass': glass ?? '',
      'plastic': plastic ?? '',
    };
  }

  factory Waste.fromJson(Map<String, dynamic> json) {
    return Waste(
      type: 'type',
      bagCode: 'bagCode',
      plastic: 'plastic',
      paper: 'paper',
      glass: 'glass',
    );
  }
}
