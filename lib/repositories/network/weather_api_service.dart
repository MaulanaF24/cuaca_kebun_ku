import 'dart:convert';
import 'package:cuaca_kebun_ku/models/weather_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';

class WeatherApiService {
  static const baseUrl = "https://api.openweathermap.org/data/2.5";
  static const apiKey = 'ccc5f058edb6c2e9317bd58911650752';
  Client httpClient = Client();

  Future<Weather> getWeatherByUserLocation(LatLng latLng) async {
    final url = Uri.https(baseUrl, "/weather", {
      'lat' : latLng.latitude,
      'lon' : latLng.longitude,
      'units' : 'metric',
      'appid' : apiKey
    });
    final response = await httpClient.get(url);
    final json = jsonDecode(response.body);
    return Weather.fromJson(json, isList: false);
  }

  Future<Weather> getWeatherByCity(String city) async {
    final url = Uri.https(baseUrl, "/weather", {
      'q' : city,
      'units' : 'metric',
      'appid' : apiKey
    });
    final response = await httpClient.get(url);
    final json = jsonDecode(response.body);
    return Weather.fromJson(json, isList: false);
  }

  Future<List<Weather?>> getListWeather(LatLng latLng) async {
    final url = Uri.https(baseUrl, "/weather", {
      'lat' : latLng.latitude,
      'lon' : latLng.longitude,
      'units' : 'metric',
      'cnt' : 10,
      'appid' : apiKey
    });
    final response = await httpClient.get(url);
    final json = jsonDecode(response.body);
    final weathers = Weather.fromForecastJson(json,true);
    return weathers;
  }

  Future<List<Weather?>> getForecast(String cityName) async {
    final url = Uri.https(baseUrl, "/weather", {
      'q' : cityName,
      'units' : 'metric',
      'appid' : apiKey
    });
    final res = await httpClient.get(url);
    final forecastJson = json.decode(res.body);
    List<Weather?> weathers = Weather.fromForecastJson(forecastJson,false);
    return weathers;
  }
}
