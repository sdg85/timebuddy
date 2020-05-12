import 'package:flutter/material.dart';

class UserLocation {
  final double latitude;
  final double longitude;
  final String city;
  final String street;

  UserLocation({this.city, this.street, @required this.latitude, @required this.longitude});
}