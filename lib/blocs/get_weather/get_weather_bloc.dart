import 'dart:async';

import 'package:cuaca_kebun_ku/blocs/get_weather/get_weather_event.dart';
import 'package:cuaca_kebun_ku/blocs/get_weather/get_weather_state.dart';
import 'package:cuaca_kebun_ku/repositories/weather_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetWeatherBloc extends Bloc<GetWeatherEvent, GetWeatherState> {
  final WeatherRepository _weatherRepository = WeatherRepository();

  GetWeatherBloc() : super(InitialWeatherState()) {
    on<FetchWeather>((event, state) async {
      try {
        state(LoadingWeatherState());
        final weather =
        await _weatherRepository.getWeatherByUserLocation(event.latLng);
        final weathers = await _weatherRepository.getMapWeather(event.latLng);
        weather.forecast = weathers;
        state(ShowWeatherState(weather));
      } catch (e) {
        state(ErrorWeatherState(e.toString()));
      }
    });
  }

  Stream<GetWeatherState> _mapFetchWeatherToState(FetchWeather event) async* {
    try {
      yield LoadingWeatherState();
      final weather =
      await _weatherRepository.getWeatherByUserLocation(event.latLng);
      final weathers = await _weatherRepository.getListWeather(
          weather.cityName!.toUpperCase() == 'JAKARTA SPECIAL CAPITAL REGION'
              ? 'Jakarta'
              : weather.cityName!);
      weather.forecast = weathers;
      print("weather : ${weather.cityName}");
      yield ShowWeatherState(weather);
    } catch (e) {
      yield ErrorWeatherState(e.toString());
    }
  }
}
