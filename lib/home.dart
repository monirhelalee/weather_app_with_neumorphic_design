import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather/locaton.dart';
import 'package:weather/weather_view_model.dart';

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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
                onTap: getLocationWithWeatherData,
                child: Icon(FontAwesomeIcons.arrowsRotate)),
          ),
        ],
      ),
      backgroundColor: Colors.grey[300],
      body: vm.shouldShowLoader
          ? SpinKitRotatingCircle(
              color: Colors.teal,
              size: 50.0,
            )
          : RefreshIndicator(
              onRefresh: getLocationWithWeatherData,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(10),
                        margin: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            //bottom right darker shadow
                            BoxShadow(
                              color: Colors.grey.shade600,
                              offset: Offset(4, 4),
                              blurRadius: 15,
                              spreadRadius: 1,
                            ),
                            //top left right lighter shadow
                            BoxShadow(
                              color: Colors.white,
                              offset: Offset(-4, -4),
                              blurRadius: 15,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: StreamBuilder(
                            stream: Stream.periodic(const Duration(seconds: 1)),
                            builder: (context, snapshot) {
                              return Center(
                                child: Text(
                                  "${DateFormat('hh:mm:ss a').format(DateTime.now())}\n${DateFormat('EEE, dd MMM yyyy').format(DateTime.now())}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(10),
                          margin: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              //bottom right darker shadow
                              BoxShadow(
                                color: Colors.grey.shade600,
                                offset: Offset(4, 4),
                                blurRadius: 15,
                                spreadRadius: 1,
                              ),
                              //top left right lighter shadow
                              BoxShadow(
                                color: Colors.white,
                                offset: Offset(-4, -4),
                                blurRadius: 15,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Image.asset(
                                vm.imagePath,
                                height: 100,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${weatherModel?.main?.temp?.toInt().toString()}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 90),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2.4,
                            padding: EdgeInsets.all(16),
                            margin: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                //bottom right darker shadow
                                BoxShadow(
                                  color: Colors.grey.shade600,
                                  offset: Offset(4, 4),
                                  blurRadius: 15,
                                  spreadRadius: 1,
                                ),
                                //top left right lighter shadow
                                BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(-4, -4),
                                  blurRadius: 15,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/windy.png",
                                  height: 30,
                                ),
                                Text(
                                  'Wind',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  '${weatherModel?.wind?.speed?.toString()} km/h',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2.4,
                            padding: EdgeInsets.all(16),
                            margin: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                //bottom right darker shadow
                                BoxShadow(
                                  color: Colors.grey.shade600,
                                  offset: Offset(4, 4),
                                  blurRadius: 15,
                                  spreadRadius: 1,
                                ),
                                //top left right lighter shadow
                                BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(-4, -4),
                                  blurRadius: 15,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/humidity.png",
                                  height: 30,
                                ),
                                Text(
                                  'Humidity',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  '${weatherModel?.main?.humidity.toString()} %',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2.4,
                            padding: EdgeInsets.all(16),
                            margin: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                //bottom right darker shadow
                                BoxShadow(
                                  color: Colors.grey.shade600,
                                  offset: Offset(4, 4),
                                  blurRadius: 15,
                                  spreadRadius: 1,
                                ),
                                //top left right lighter shadow
                                BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(-4, -4),
                                  blurRadius: 15,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/warm.png",
                                  height: 30,
                                ),
                                Text(
                                  'Feels Like',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  '${weatherModel?.main?.feelsLike?.toInt().toString()}°C',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2.4,
                            padding: EdgeInsets.all(16),
                            margin: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                //bottom right darker shadow
                                BoxShadow(
                                  color: Colors.grey.shade600,
                                  offset: Offset(4, 4),
                                  blurRadius: 15,
                                  spreadRadius: 1,
                                ),
                                //top left right lighter shadow
                                BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(-4, -4),
                                  blurRadius: 15,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/pressure.png",
                                  height: 30,
                                ),
                                Text(
                                  'Pressure',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  '${weatherModel?.main?.pressure.toString()} mb',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2.4,
                            padding: EdgeInsets.all(16),
                            margin: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                //bottom right darker shadow
                                BoxShadow(
                                  color: Colors.grey.shade600,
                                  offset: Offset(4, 4),
                                  blurRadius: 15,
                                  spreadRadius: 1,
                                ),
                                //top left right lighter shadow
                                BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(-4, -4),
                                  blurRadius: 15,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/sunrise.png",
                                  height: 30,
                                ),
                                Text(
                                  'Sunrise',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  '${DateFormat("hh:mm a").format(DateTime.fromMillisecondsSinceEpoch(weatherModel!.sys!.sunrise * 1000).toLocal())}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2.4,
                            padding: EdgeInsets.all(16),
                            margin: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                //bottom right darker shadow
                                BoxShadow(
                                  color: Colors.grey.shade600,
                                  offset: Offset(4, 4),
                                  blurRadius: 15,
                                  spreadRadius: 1,
                                ),
                                //top left right lighter shadow
                                BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(-4, -4),
                                  blurRadius: 15,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/sunset.png",
                                  height: 30,
                                ),
                                Text(
                                  'Sunset',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  '${DateFormat("hh:mm a").format(DateTime.fromMillisecondsSinceEpoch(weatherModel.sys!.sunset * 1000).toLocal())}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
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
    );
  }
}
