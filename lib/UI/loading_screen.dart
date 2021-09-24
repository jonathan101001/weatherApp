import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_appfix/UI/location_screen.dart';
import 'package:weather_appfix/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override

  @override
  void initState() { 
    super.initState();
    getLocationData();
  }

   void getLocationData()async{
   var weatherData= await WeatherModel().getLocationWeather();
   Navigator.push(context, MaterialPageRoute(builder: (context){
     return LocationScreen(
       locationWeather: weatherData,
     );
   }));
  }
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(
         child: SpinKitCircle (
           color: Colors.white,
           size:75,
         ),
       ),
    );
  }
}