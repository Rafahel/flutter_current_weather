import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/weather_bloc.dart';
import 'city_list.dart';

class SearchComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    WeatherBloc weatherBloc = BlocProvider.of<WeatherBloc>(context);
    return Container(
      padding: EdgeInsets.only(left: 32, right: 32),
      child: Column(
        children: [
          Container(
            child: FlareActor(
              "assets/WorldSpin.flr",
              fit: BoxFit.contain,
              animation: "roll",
            ),
            height: 100,
            width: 100,
          ),
          SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: textController,
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white70,
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                        color: Colors.white70, style: BorderStyle.solid)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                        color: Colors.white70, style: BorderStyle.solid)),
                hintText: "City Name",
                hintStyle: TextStyle(color: Colors.white70)),
            style: TextStyle(color: Colors.white70),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            height: 50,
            child: FlatButton(
              onPressed: () {
                weatherBloc.add(FetchWeatherEvent(textController.text));
              },
              child: Text("Search",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              color: Colors.lightBlue,
            ),
          ),
          SizedBox(height: 20),
          CityListWidget()
        ],
      ),
    );
  }
}
