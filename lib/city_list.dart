import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/weather_bloc.dart';
import 'models/weather_model.dart';

class CityListWidgetState extends State<CityListWidget> {
  List<WeatherModel> weatherList = List.empty();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
      weatherList =
          BlocProvider.of<WeatherBloc>(context).getWeatherList.toList();
      if (weatherList.isEmpty) {
        return Container(
          child: Text("No saved city"),
        );
      } else {
        return Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 250,
                child: Container(
                  child: ListView.builder(
                    itemCount: weatherList == null ? 0 : weatherList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[800],
                          ),
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: Colors.white70,
                                        size: 35,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(weatherList[index].cityName,
                                          style: TextStyle(
                                              fontSize: 26,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                      Container(
                                        margin: EdgeInsets.only(left: 16),
                                        child: FlareActor(
                                          "assets/weather_${weatherList[index].icon}.flr",
                                          fit: BoxFit.contain,
                                          animation:
                                              "${weatherList[index].icon}",
                                        ),
                                        height: 85,
                                        width: 85,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "Temperature: ${weatherList[index].temp} C",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                              "Description: ${weatherList[index].description}",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold))
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        );
      }
    });
  }
}

class CityListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CityListWidgetState();
  }
}
