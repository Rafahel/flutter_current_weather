import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/weather_bloc.dart';

class SearchComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController _textController = TextEditingController();
    return Container(
      padding: EdgeInsets.only(left: 32, right: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
            textInputAction: TextInputAction.search,
            onFieldSubmitted: (value) {
              _onWeatherSearch(context, _textController.text);
            },
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
            ],
            controller: _textController,
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white70,
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide(
                        color: Colors.white, style: BorderStyle.solid)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide(
                        color: Colors.white70, style: BorderStyle.solid)),
                hintText: "Cidade",
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
                _onWeatherSearch(context, _textController.text);
              },
              child: Text("Buscar",
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              color: Colors.green,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
            ),
          ),
        ],
      ),
    );
  }

  _onWeatherSearch(BuildContext context, text) {
    FocusScope.of(context).unfocus();
    if (text.isEmpty) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error,
              color: Colors.redAccent,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              "Insira o nome da cidade",
              style: TextStyle(fontSize: 18),
            )
          ],
        ),
      ));
      return;
    }
    BlocProvider.of<WeatherBloc>(context).add(FetchWeatherEvent(text));
  }
}
