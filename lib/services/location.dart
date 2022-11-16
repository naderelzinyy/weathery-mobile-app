import 'package:geolocator/geolocator.dart';

class Location {
  double latitude = 0;
  double longitude = 0;
  late Position position;

  Future<void> findLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

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
