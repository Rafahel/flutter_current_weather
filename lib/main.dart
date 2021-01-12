import 'dart:io';

import 'package:current_weather/bloc/weather_bloc.dart';
import 'package:current_weather/data/repository.dart';
import 'package:current_weather/weather_model.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocProvider(
          builder: (context) => WeatherBloc(Repository()),
          child: MyHomePage(title: 'Current Weather'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.grey[900],
        title: Text(widget.title),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white70,
          ),
          onPressed: () {
            final WeatherBloc weatherBloc =
                BlocProvider.of<WeatherBloc>(context);
            if (weatherBloc.state is WeatherIsNotSearched) {
              exit(0);
            } else {
              weatherBloc.add(ResetWeather());
            }
          },
        ),
      ),
      body: SearchPage(),
      backgroundColor: Colors.grey[900],
      resizeToAvoidBottomInset: false,
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

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
                height: 300,
                width: 300,
              )),
              BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
                if (state is WeatherIsNotSearched) {
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
                                  .add(FetchWeather(textController.text));
                            },
                            child: Text("Search",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            color: Colors.lightBlue,
                          ),
                        )
                      ],
                    ),
                  );
                } else if (state is WeatherIsLoading)
                  return Center(child: CircularProgressIndicator());
                else if (state is WeatherIsLoaded)
                  return CurrentWeatherWidget(
                      state.getWeather, textController.text);
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

class CurrentWeatherWidget extends StatelessWidget {
  final WeatherModel weatherModel;
  final String cityName;

  CurrentWeatherWidget(this.weatherModel, this.cityName);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 30, right: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            cityName,
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
            "Temperature",
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
                  Text("Maximun Temperature",
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
                  Text("Minimum Temperature",
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
                BlocProvider.of<WeatherBloc>(context).add(ResetWeather());
              },
              child: Text("Search Again",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              color: Colors.lightBlue,
            ),
          )
        ],
      ),
    );
  }
}
