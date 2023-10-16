import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/home.dart';
import 'package:weather/weather_view_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WeatherViewModel()),
      ],
      child: MaterialApp(
        title: 'Weather',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Weather'),
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
      ),
    );
  }
}
