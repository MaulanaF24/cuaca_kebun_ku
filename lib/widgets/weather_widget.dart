import 'package:cuaca_kebun_ku/models/weather_model.dart';
import 'package:cuaca_kebun_ku/widgets/current_conditions.dart';
import 'package:cuaca_kebun_ku/widgets/forecast_horizontal_widget.dart';
import 'package:cuaca_kebun_ku/widgets/value_tile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeatherWidget extends StatelessWidget {
  final Weather weather;

  const WeatherWidget({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 30),
          Text(
            weather.cityName?.toUpperCase() ?? '',
            style: TextStyle(
                fontWeight: FontWeight.w900, letterSpacing: 5, fontSize: 25),
          ),
          SizedBox(
            height: 20,
          ),
          Text(weather.description?.toUpperCase() ?? '',
              style: TextStyle(
                fontWeight: FontWeight.w100,
                letterSpacing: 5,
                fontSize: 15,
              )),
          CurrentConditions(weather),
          Padding(
            padding: EdgeInsets.all(10),
            child: Divider(),
          ),
          ForecastHorizontal(weathers: weather.forecast!, key: Key(''),),
          Padding(
            padding: EdgeInsets.all(10),
            child: Divider(),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            ValueTile("wind speed", '${weather.windSpeed} m/s', null),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Center(
                  child: SizedBox(
                width: 1,
                height: 30,
              )),
            ),
            ValueTile(
                "sunrise",
                DateFormat('h:m a').format(DateTime.fromMillisecondsSinceEpoch(
                    weather.sunrise! * 1000)), null),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Center(
                  child: SizedBox(
                width: 1,
                height: 30,
              )),
            ),
            ValueTile(
                "sunset",
                DateFormat('h:m a').format(DateTime.fromMillisecondsSinceEpoch(
                    weather.sunset! * 1000)), null),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Center(
                  child: SizedBox(
                width: 1,
                height: 30,
              )),
            ),
            ValueTile("humidity", '${weather.humidity}%', null),
          ]),
        ],
      ),
    );
  }
}
