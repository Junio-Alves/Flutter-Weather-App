// ignore: file_names
class WeatherIcon {
  static String white(String weather) {
    Map<String, String> icons = {
      "clear_day": "assets/icons/white/clear_day.png",
      "clear_night": "assets/icons/white/clear_night.png",
      "cloud": "assets/icons/white/cloud.png",
      "cloudly_day": "assets/icons/white/cloudly_day.png",
      "cloudly_night": 'assets/icons/white/cloudly_night.png',
      "fog": 'assets/icons/white/fog.png',
      "hail": 'assets/icons/white/hail.png',
      "rain": 'assets/icons/white/rain.png',
      "snow": 'assets/icons/white/snow.png',
      "storm": 'assets/icons/white/storm.png',
    };
    if (icons.containsKey(weather)) {
      return icons[weather]!;
    } else {
      return "assets/icons/unknown.png";
    }
  }

  static String black(String weather) {
    Map<String, String> icons = {
      "clear_day": "assets/icons/black/clear_day.png",
      "clear_night": "assets/icons/black/clear_night.png",
      "cloud": "assets/icons/black/cloud.png",
      "cloudly_day": "assets/icons/black/cloudly_day.png",
      "cloudly_night": 'assets/icons/black/cloudly_night.png',
      "fog": 'assets/icons/black/fog.png',
      "hail": 'assets/icons/black/hail.png',
      "rain": 'assets/icons/black/rain.png',
      "snow": 'assets/icons/black/snow.png',
      "storm": 'assets/icons/black/storm.png',
    };
    if (icons.containsKey(weather)) {
      return icons[weather]!;
    } else {
      return "assets/icons/unknown.png";
    }
  }
}
