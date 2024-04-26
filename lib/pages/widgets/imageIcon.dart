imageIcon(String weather) {
  if (weather == "noite") {
    return 'assets/icons/clear_night.png';
  } else if (weather == "dia") {
    return 'assets/icons/clear_day.png';
  } else if (weather == 'rain') {
    return 'assets/icons/rain.png';
  } else if (weather == 'cloud') {
    return 'assets/icons/cloud.png';
  } else if (weather == 'cloudly_day') {
    return 'assets/icons/cloudly_day.png';
  } else {
    return 'assets/icons/interrogacao.png';
  }
}
