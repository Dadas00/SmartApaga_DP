import 'package:http/http.dart' as http;
import 'package:smart_apaga/LoginRegister/model/Address.dart';
import 'dart:convert';

import 'package:smart_apaga/Pickup/Model/Pickup.dart';

class AddressProvider {
  Future<List<Address>> getAddress() async {
    final response = await http.get(Uri.parse('https://am.oriflame.com/'));

    if (response.statusCode == 200) {
      final List<dynamic> userJson = json.decode(response.body);
      return userJson.map((json) => Address.fromJson(json)).toList();
    } else {
      throw Exception('Error fetching address');
    }
  }

  Future<List<Pickup>> getPikup() async {
    final response = await http.get(Uri.parse('https://am.oriflame.com/'));

    if (response.statusCode == 200) {
      final List<dynamic> userJson = json.decode(response.body);
      return userJson.map((json) => Pickup.fromJson(json)).toList();
    } else {
      throw Exception('Error fetching address');
    }
  }
}
