import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/weather_bloc.dart';
import 'models/weather_model.dart';

class CurrentWeatherWidget extends StatelessWidget {
  final WeatherModel weatherModel;

  CurrentWeatherWidget(this.weatherModel);

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
                  fit: BoxFit.contain,
                  animation: "${weatherModel.icon}",
                ),
                height: 150,
                width: 300,
              ),
              Text(
                weatherModel.getCityName,
                style: TextStyle(
                    fontSize: 28,
                    color: Colors.white70,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "${weatherModel.temp.round().toInt()} C",
                style: TextStyle(
                    fontSize: 28,
                    color: Colors.white70,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Temperatura",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white70,
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
                            color: Colors.white70,
                            fontWeight: FontWeight.bold),
                      ),
                      Text("Temperatura Máxima",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                          ))
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "${weatherModel.getMinTemp.round().toInt()} C",
                        style: TextStyle(
                            fontSize: 28,
                            color: Colors.white70,
                            fontWeight: FontWeight.bold),
                      ),
                      Text("Temperatura Mínima",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
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
                child: FlatButton(
                  onPressed: () {
                    BlocProvider.of<WeatherBloc>(context)
                        .add(SaveWeatherEvent(weatherModel));
                  },
                  child: Text("Favoritar",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  color: Colors.lightGreen,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                width: double.infinity,
                height: 50,
                child: FlatButton(
                  onPressed: () {
                    BlocProvider.of<WeatherBloc>(context)
                        .add(ResetWeatherEvent());
                  },
                  child: Text("Voltar",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  color: Colors.lightBlue,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
