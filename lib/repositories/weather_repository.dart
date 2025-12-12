import 'package:cuaca_kebun_ku/models/weather_model.dart';
import 'package:cuaca_kebun_ku/repositories/network/weather_api_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class WeatherRepository {
 final WeatherApiService _weatherApiService = WeatherApiService();

  Future<Weather> getWeatherByUserLocation(LatLng latLng) async {
    final response = await _weatherApiService.getWeatherByUserLocation(latLng);
    return response;
  }

 Future<Weather> getWeatherByCity(String city) async {
   final response = await _weatherApiService.getWeatherByCity(city);
   return response;
 }

 Future<List<Weather?>> getListWeather(LatLng latLng) async {
    final response = await _weatherApiService.getForecast(latLng);
    return response;
 }

 Future<List<Weather?>> getMapWeather(LatLng latLng) async {
   final response = await _weatherApiService.getListWeather(latLng);
   return response;
 }
}
