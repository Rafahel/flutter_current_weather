import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bloc/weather_bloc.dart';
import 'models/weather_model.dart';

class SelectedWeatherWidget extends StatelessWidget {
  final WeatherModel weatherModel;

  SelectedWeatherWidget(this.weatherModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 30, right: 30),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: FlareActor(
                  "assets/weather_${weatherModel.icon}.flr",
                  animation: "${weatherModel.icon}",
                ),
                height: 150,
                width: 300,
              ),
              Text(
                weatherModel.getCityName,
                style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                  "${weatherModel.description[0].toUpperCase() + weatherModel.description.substring(1)}",
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 8,
              ),
              Text(
                "${weatherModel.temp.round().toInt()} C",
                style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Temperatura",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "${weatherModel.getMaxTemp.round().toInt()} C",
                        style: TextStyle(
                            fontSize: 28,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Text("Temperatura Máxima",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ))
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "${weatherModel.getMinTemp.round().toInt()} C",
                        style: TextStyle(
                            fontSize: 28,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Text("Temperatura Mínima",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ))
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: 50,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context, SaveWeatherEvent(weatherModel));
                  },
                  child: Text("Favoritar",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.lightGreen),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30)))),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                width: double.infinity,
                height: 50,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context, ResetWeatherEvent());
                  },
                  child: Text("Voltar",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.lightBlue),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30)))),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
