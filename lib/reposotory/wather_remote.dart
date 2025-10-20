import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/models/wather_model.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/services/location.dart';

class WatherRemote {
  Future<WatherModel?> fetchData() async {
    try {
      final Position? location = await LocationService.getCurrentPosition();
      final res = await http.get(
        Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?lat=${location?.latitude}&lon=${location?.longitude}&appid=7b5cf4c2b1145f1e2d4f2747d192bec4",
        ),
      );

      if (res.statusCode != 200) {
        return null;
      }
      final result = jsonDecode(res.body);
      final WatherModel weather = WatherModel.fromJson(result);
      print(res.body);
      return weather;
    } catch (e) {
      throw e;
    }
  }
}
