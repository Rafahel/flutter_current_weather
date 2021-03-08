import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_cache_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/theme_bloc.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
      FlareCacheBuilder(["assets/day_scene.flr", "assets/background.flr"],
          builder: (BuildContext context, bool isWarm) {
            return FlareActor(
              BlocProvider.of<ThemeBloc>(context).flareAsset,
              fit: BoxFit.fill,
              animation: BlocProvider.of<ThemeBloc>(context).flareAnimation,
            );
          }),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
    );
  }
}