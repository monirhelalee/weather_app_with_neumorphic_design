import 'package:flutter/material.dart';
import 'package:weather/appError.dart';
import 'package:weather/weather_model.dart';
import 'package:weather/weather_repository.dart';

class WeatherViewModel extends ChangeNotifier {
  WeatherModel? _weatherModel;
  AppError? _appError;
  bool _isFetchingData = false;

  String get imagePath {
    switch (_weatherModel?.weather?.first.main.toString().toLowerCase()) {
      case "thunderstorm":
        return "assets/storm.png";
      case "rain":
        return "assets/rainy.png";
      case "snow":
        return "assets/snowy.png";
      case "clouds":
        return "assets/cloud.png";
      default:
        return "assets/sun.png";
    }
  }

  Future<void> getWeatherData({double? lat, double? lon}) async {
    var res = await WeatherRepository().getWeatherData(lat: lat, long: lon);
    notifyListeners();
    res.fold((l) {
      _appError = l;
      notifyListeners();
    }, (r) {
      _weatherModel = r;
      notifyListeners();
    });
  }

  AppError? get appError => _appError;

  bool get isFetchingData => _isFetchingData;
  bool get shouldShowLoader => _weatherModel == null;

  WeatherModel? get weatherData => _weatherModel;
}
