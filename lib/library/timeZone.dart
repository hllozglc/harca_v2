class TimeHelper {
  var time = DateTime.now().hour;
  String timeZone() {
    String mesaj;
    if (time <= 12 && time >= 6) {
      mesaj = 'Günaydın';
    } else if (time <= 17 && time > 12) {
      mesaj = 'İyi Günler';
    } else {
      mesaj = 'İyi Akşamlar';
    }
    return mesaj;
  }
}
