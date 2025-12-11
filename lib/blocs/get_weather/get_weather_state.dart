import 'package:cuaca_kebun_ku/models/weather_model.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class GetWeatherState {}

class InitialWeatherState extends GetWeatherState {}
class LoadingWeatherState extends GetWeatherState {}

class ShowWeatherState extends GetWeatherState {
  final Weather weatherModel;

  ShowWeatherState(this.weatherModel);

  @override
  String toString() => 'ShowWeatherState : {$weatherModel}';
}

class ErrorWeatherState extends GetWeatherState {
  final String error;

  ErrorWeatherState(this.error);
}
