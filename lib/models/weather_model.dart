class WeatherModel {
  final String cityName;
  final double temp;
  final double tempMax;
  final double tempMin;

  double get getTemp => temp;
  double get getMaxTemp => tempMax;
  double get getMinTemp => tempMin;
  String get getCityName => cityName;

  WeatherModel(this.cityName, this.temp, this.tempMax, this.tempMin);
  // WeatherModel.withName(this.cityName, this.temp, this.tempMax, this.tempMin);

  factory WeatherModel.fromJson(String cityName, Map<String, dynamic> json) {
    return WeatherModel(cityName, json["temp"].toDouble(),
        json["temp_max"].toDouble(), json["temp_min"].toDouble());
  }

  Map<String, dynamic> toMap() {
    return {
      'cityName': cityName,
      'temp': temp,
      'tempMax': tempMax,
      'tempMin': tempMin,
    };
  }
}
