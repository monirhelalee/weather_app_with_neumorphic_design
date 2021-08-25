import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:weather/weather_model.dart';

import 'appError.dart';

class WeatherRepository {
  Future<Either<AppError, WeatherModel>> getWeatherData(
      {double? lat, double? long}) async {
    var url =
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=2d3756085fc0365b81f6499194037e04";
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      var data = weatherModelFromJson(res.body);
      return Right(data);
    } else {
      BotToast.showText(text: 'Fail Data');
      return Left(AppError.serverError);
    }
  }
}
