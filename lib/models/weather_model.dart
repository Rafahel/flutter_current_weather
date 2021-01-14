import 'package:equatable/equatable.dart';

class WeatherModel extends Equatable {
  final String cityName;
  final double temp;
  final double tempMax;
  final double tempMin;
  final String description;
  final String icon;

  double get getTemp => temp;
  double get getMaxTemp => tempMax;
  double get getMinTemp => tempMin;
  String get getCityName => cityName;

  WeatherModel(this.cityName, this.temp, this.tempMax, this.tempMin,
      this.description, this.icon);
  // WeatherModel.withName(this.cityName, this.temp, this.tempMax, this.tempMin);

  factory WeatherModel.fromJson(String cityName, Map<String, dynamic> json) {
    return WeatherModel(
        cityName,
        json["main"]["temp"].toDouble(),
        json["main"]["temp_max"].toDouble(),
        json["main"]["temp_min"].toDouble(),
        json["weather"][0]["description"],
        json["weather"][0]["icon"]);
  }

  Map<String, dynamic> toMap() {
    return {
      'cityName': cityName,
      'temp': temp,
      'tempMax': tempMax,
      'tempMin': tempMin,
      'description': description,
      'icon': icon
    };
  }

  @override
  List<Object> get props => [cityName];
}
