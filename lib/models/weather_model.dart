class WeatherModel {
  final double temp;
  final double tempMax;
  final double tempMin;

  double get getTemp => temp;
  double get getMaxTemp => tempMax;
  double get getMinTemp => tempMin;

  WeatherModel(this.temp, this.tempMax, this.tempMin);

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(json["temp"].toDouble(), json["temp_max"].toDouble(),
        json["temp_min"].toDouble());
  }
}
