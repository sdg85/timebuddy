import 'dart:async';

import '../models/user_location.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  UserLocation _currentLocation;

  Geolocator geolocator = Geolocator()..forceAndroidLocationManager = true;

  //keep track of location
  StreamController<UserLocation> _locationController =
      StreamController<UserLocation>.broadcast();

  Stream<UserLocation> get locationStream => _locationController.stream;

  //constructor
  LocationService() {
    geolocator.checkGeolocationPermissionStatus(
        locationPermission: GeolocationPermission.locationWhenInUse)
      ..then((status) {
        print('whenInUse status: $status');
      });

    var locationOptions =
        LocationOptions(accuracy: LocationAccuracy.best, distanceFilter: 0);
    geolocator.getPositionStream(locationOptions).listen((position) {
      if (position != null) {
        getAddressFromLatLng(position.latitude, position.longitude)
            .then((userLocation) => _locationController.add(userLocation));
      }
    });
  }

  //get address
  Future<UserLocation> getAddressFromLatLng(
      double latitude, double longitude) async {
    UserLocation location;
    try {
      List<Placemark> p =
          await geolocator.placemarkFromCoordinates(latitude, longitude);
      Placemark place = p[0];
      
      if (place != null)
        location = UserLocation(
            latitude: latitude,
            longitude: longitude,
            city: place.administrativeArea,
            street: "${place.thoroughfare} ${place.subThoroughfare}");
      else
        location = UserLocation(latitude: latitude, longitude: longitude);
    } catch (e) {
      print(e);
    }
    return location;
  }

  //get current location;
  Future<UserLocation> getCurrentLocation() async {
    try {
      geolocator
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
          .then((Position position) {
        _currentLocation = UserLocation(
            latitude: position.latitude, longitude: position.latitude);
      }).catchError((e) {
        print('Could not get the location: $e');
      });
      // var userLocation = await location.getLocation();
      // _currentLocation = UserLocation(
      //     latitude: userLocation.latitude, longitude: userLocation.longitude);
    } catch (e) {
      print('Could not get the location: $e');
    }

    return _currentLocation;
  }
}
