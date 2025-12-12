import 'package:cuaca_kebun_ku/models/weather_model.dart';
import 'package:cuaca_kebun_ku/widgets/value_tile.dart';
import 'package:flutter/material.dart';

class CurrentConditions extends StatelessWidget {
  final Weather weather;
  const CurrentConditions( this.weather, {super.key,});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          weather.getIconData(),
          size: 70,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          '${weather.temperature}°',
          style: TextStyle(
              fontSize: 100,
              fontWeight: FontWeight.w100),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          ValueTile("max",
              '${weather.maxTemperature}°', null),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Center(
                child: SizedBox(
              width: 1,
              height: 30,
            )),
          ),
          ValueTile("min",
              '${weather.minTemperature}°', null),
        ]),
      ],
    );
  }
}
