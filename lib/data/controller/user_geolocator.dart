import 'package:geolocator/geolocator.dart';

class GetGeoLocation {
  //Latitude
  double _lat = 0.0;
  //Longitude
  double _long = 0.0;
  //Erros
  String error = '';

  get lat => _lat;
  get long => _long;

  GetGeoLocation() {
    getPosition();
  }

  //pegar geolocalização
  Future getPosition() async {
    try {
      //pega a localização atual do usuário.
      Position position = await _currentPosition();
      _lat = position.latitude;
      _long = position.longitude;
    }
    //se não for possivel, pega o erro.
    catch (e) {
      error = e.toString();
    }
  }

  Future<Position> _currentPosition() async {
    LocationPermission permition;
    //verifica se a localização do dispositivo está atividada.
    bool activate = await Geolocator.isLocationServiceEnabled();

    //Caso não esteja ativada retorna mensagem de erro.
    if (!activate) {
      return Future.error("Porfavor , habilite a localizacão no smartphone");
    }

    //Verifica a permissões de localização.
    permition = await Geolocator.checkPermission();

    //Caso permissão negada,solicita permissão ao usuário.
    if (permition == LocationPermission.denied) {
      permition = await Geolocator.requestPermission();
      if (permition == LocationPermission.denied) {
        return Future.error("Você precisa autorizar o acesso à localização");
      }
    }

    //Caso permissão negada para sempre.
    if (permition == LocationPermission.deniedForever) {
      return Future.error("Você precisa autorizar o acesso à localização");
    }

    //retorna a localização atual do dispositivo.
    return await Geolocator.getCurrentPosition();
  }
}
