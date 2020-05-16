import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;

const apiKey = 'cbd6ca69c6cac24bf2806f537521b0e9';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double _latitude;
  double _longitude;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();

    _latitude = location.getLat();
    _longitude = location.getLong();
  }

  void getData() async {
    http.Response response = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?lat=$_latitude&lon=$_longitude&appid=$apiKey');

    if (response.statusCode == 200) {
      String data = response.body;
      var decodeData = jsonDecode(data);

      var temperature = decodeData['main']['temp'];
      var condition = decodeData['weather'][0]['id'];
      var cityName = decodeData['name'];
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
