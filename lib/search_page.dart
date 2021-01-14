import 'package:current_weather/bloc/weather_bloc.dart';
import 'package:current_weather/models/weather_model.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/weather_bloc.dart';
import 'current_weather.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final WeatherBloc weatherBloc = BlocProvider.of<WeatherBloc>(context);
    final TextEditingController textController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Column(
            children: [
              Center(
                  child: Container(
                child: FlareActor(
                  "assets/WorldSpin.flr",
                  fit: BoxFit.contain,
                  animation: "roll",
                ),
                height: 150,
                width: 150,
              )),
              BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
                if (state is WeatherIsNotSearchedState) {
                  weatherBloc.add(LoadFromDbEvent());
                  return Container(
                    padding: EdgeInsets.only(left: 32, right: 32),
                    child: Column(
                      children: [
                        Text(
                          "Search",
                          style: TextStyle(
                              fontSize: 28,
                              color: Colors.white70,
                              fontWeight: FontWeight.bold),
                        ),
                        TextFormField(
                          controller: textController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.white70,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: Colors.white70,
                                      style: BorderStyle.solid)),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: Colors.white70,
                                      style: BorderStyle.solid)),
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
                              weatherBloc
                                  .add(FetchWeatherEvent(textController.text));
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
                } else if (state is WeatherIsLoadingState ||
                    state is LoadingFromDbState)
                  return Center(child: CircularProgressIndicator());
                else if (state is WeatherIsLoadedState)
                  return CurrentWeatherWidget(state.getWeather);
                else
                  return Text(
                    "Error",
                    style: TextStyle(color: Colors.white),
                  );
              })
            ],
          ),
        )
      ],
    );
  }
}

class CityListWidgetState extends State<CityListWidget> {
  List<WeatherModel> weatherList = List.empty();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
      weatherList = BlocProvider.of<WeatherBloc>(context).getWeatherList;
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
                child: ListView.builder(
                  itemCount: weatherList == null ? 0 : weatherList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Icon(
                        Icons.location_city,
                        color: Colors.white70,
                      ),
                      title: Text(
                        weatherList[index].cityName,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    );
                  },
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
