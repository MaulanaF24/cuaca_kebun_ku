import 'package:cuaca_kebun_ku/blocs/map_weather/map_weather_event.dart';
import 'package:cuaca_kebun_ku/blocs/map_weather/map_weather_state.dart';
import 'package:cuaca_kebun_ku/repositories/weather_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

export 'package:cuaca_kebun_ku/blocs/map_weather/map_weather_event.dart';
export 'package:cuaca_kebun_ku/blocs/map_weather/map_weather_state.dart';

class MapWeatherBloc extends Bloc<MapWeatherEvent, MapWeatherState> {
  final WeatherRepository _weatherRepository = WeatherRepository();

  MapWeatherBloc() : super(InitialMapWeather()) {
    on<FetchMapWeather>((event, state) async {
      try {
        final weathers = await _weatherRepository.getMapWeather(event.latLng);
        final mapMarketList = <Marker>[];
        await Future.forEach(weathers, (each) async {
          final marker = await each!.toMarker();
          mapMarketList.add(marker);
        });
        state(ShowMapWeather(weathers, mapMarketList));
      } catch (e) {
        state(FailedMapWeather(e.toString()));
      }
    });
  }
}
