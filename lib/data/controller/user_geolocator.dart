import 'package:geolocator/geolocator.dart';

class GeoLocation {
  double _lat = 0.0;
  double _long = 0.0;
  String error = '';

  get lat => _lat;
  get long => _long;

  GeoLocation() {
    getPosition();
  }

  Future getPosition() async {
    try {
      Position position = await _currentPosition();
      _lat = position.latitude;
      _long = position.longitude;
    } catch (e) {
      error = e.toString();
    }
  }

  Future<Position> _currentPosition() async {
    LocationPermission permition;
    bool activate = await Geolocator.isLocationServiceEnabled();

    if (!activate) {
      return Future.error("Porfavor , habilite a localizacão no smartphone");
    }
    permition = await Geolocator.checkPermission();
    if (permition == LocationPermission.denied) {
      permition = await Geolocator.requestPermission();
      if (permition == LocationPermission.denied) {
        return Future.error("Você precisa autorizar o acesso à localização");
      }
    }

    if (permition == LocationPermission.deniedForever) {
      return Future.error("Você precisa autorizar o acesso à localização");
    }

    return await Geolocator.getCurrentPosition();
  }
}
