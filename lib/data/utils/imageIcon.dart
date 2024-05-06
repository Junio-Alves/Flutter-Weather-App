imageIcon(String weather) {
  Map<String, String> icons = {
    "noite": "assets/icons/clear_night.png",
    "dia": "assets/icons/clear_day.png",
    "rain": "assets/icons/rain.gif",
    "cloud": "assets/icons/cloud.png",
    "cloudly_day": 'assets/icons/cloudly_day.png',
  };
  if (icons.containsKey(weather)) {
    return icons[weather];
  } else {
    return "assets/icons/interrogacao.png";
  }
}
