background(String currently) {
  Map<String, String> background = {
    "noite": "assets/background/night.jpg",
    "dia": "assets/background/day.png",
  };
  if (background.containsKey(currently)) {
    return background[currently];
  } else {
    return background["dia"];
  }
}
