class Constants {
  static const apiKey = 'b0988621';

  static String api({required double lat, required double long}) {
    final apiLink =
        "https://api.hgbrasil.com/weather?key=$apiKey&lat=$lat&lon=$long&user_ip=remote";
    return apiLink;
  }
}
