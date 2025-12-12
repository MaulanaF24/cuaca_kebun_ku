import 'package:cuaca_kebun_ku/blocs/get_weather/get_weather_event.dart';
import 'package:cuaca_kebun_ku/blocs/get_weather/get_weather_state.dart';
import 'package:cuaca_kebun_ku/repositories/weather_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetWeatherBloc extends Bloc<GetWeatherEvent, GetWeatherState> {
  final WeatherRepository _weatherRepository = WeatherRepository();

  GetWeatherBloc() : super(InitialWeatherState()) {
    on<FetchWeather>((event, state) async {
      try {
        state(LoadingWeatherState());
        List<Marker> markerList = [];
        final weather = await _weatherRepository.getWeatherByUserLocation(event.latLng);
        final weathers = await _weatherRepository.getListWeather(event.latLng);
        markerList.add(await weather.toMarker());
        weather.forecast = weathers;
        state(ShowWeatherState(weather, markerList));
      } catch (e) {
        state(ErrorWeatherState(e.toString()));
      }
    });
  }
}
