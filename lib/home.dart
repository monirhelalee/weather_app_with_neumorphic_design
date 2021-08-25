import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather/locaton.dart';
import 'package:weather/weather_view_model.dart';
import 'package:timezone/timezone.dart' as tz;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> getLocationWithWeatherData() async {
    Location location = Location();
    await location.getCurrantLocation();
    Provider.of<WeatherViewModel>(context, listen: false)
        .getWeatherData(lat: location.latitude, lon: location.longitude);
  }

  @override
  void initState() {
    getLocationWithWeatherData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<WeatherViewModel>(context);
    var weatherModel = vm.weatherData;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(widget.title),
      ),
      backgroundColor: Colors.grey[200],
      body: vm.shouldShowLoader
          ? SpinKitRotatingCircle(
              color: Colors.teal,
              size: 50.0,
            )
          : RefreshIndicator(
              onRefresh: getLocationWithWeatherData,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: StreamBuilder(
                          stream: Stream.periodic(const Duration(seconds: 1)),
                          builder: (context, snapshot) {
                            return Center(
                              child: Text(
                                "${DateFormat('hh:mm:ss a').format(DateTime.now())}\n${DateFormat('EEE, dd MMM yyyy').format(DateTime.now())}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                          color: Colors.grey[200],
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              Image.asset(
                                vm.imagePath,
                                height: 150,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${weatherModel?.main?.temp?.toInt().toString()}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 100),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '°C',
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '${weatherModel?.weather?.first.main}',
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Text(
                                '${weatherModel?.weather?.first.description}',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                height: 20,
                              )
                            ],
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/windy.png",
                                  height: 30,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Wind',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Text(
                                        '${weatherModel?.wind?.speed?.toString()} km/h',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/humidity.png",
                                  height: 30,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Humidity',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Text(
                                        '${weatherModel?.main?.humidity.toString()} %',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/warm.png",
                                  height: 30,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Feels Like',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Text(
                                        '${weatherModel?.main?.feelsLike?.toInt().toString()}°C',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/pressure.png",
                                  height: 30,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Pressure',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Text(
                                        '${weatherModel?.main?.pressure.toString()} mb',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/sunrise.png",
                                  height: 30,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Sunrise',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Text(
                                        '${DateFormat("hh:mm a").format(DateTime.fromMillisecondsSinceEpoch(weatherModel!.sys!.sunrise * 1000).toLocal())}',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/sunset.png",
                                  height: 30,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Sunset',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Text(
                                        '${DateFormat("hh:mm a").format(DateTime.fromMillisecondsSinceEpoch(weatherModel.sys!.sunset * 1000).toLocal())}',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     getLocationWithWeatherData();
      //   },
      //   tooltip: 'Current Location Weather',
      //   child: Icon(Icons.cloud),
      // ),
    );
  }
}
