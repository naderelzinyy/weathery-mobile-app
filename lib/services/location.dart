import 'package:geolocator/geolocator.dart';

class Location {
  double latitude = 0;
  double longitude = 0;
  late Position position;

  Future<void> findLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print('Location accessed.');
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print('Accessing location request denied.');
    }
  }
}
