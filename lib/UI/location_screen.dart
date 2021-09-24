import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:weather_appfix/UI/city_screen.dart';
import 'package:weather_appfix/services/weather.dart';

class LocationScreen extends StatefulWidget {
  
  const LocationScreen({this.locationWeather});

 
 final locationWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather=WeatherModel();
  late int temperature;
  late String weatherIcon;
  late String cityName;
  late String weatherMessage;
  late int hum;
  late int wind;
  late String max;
  late String bgimg;
  var now = DateFormat.yMMMd().add_jm().format(DateTime.now());
  var daytoday= DateFormat.E().format(DateTime.now());
  

  @override
  void initState() { 
    super.initState();
    updateUI(widget.locationWeather);
  }
  
  void updateUI(dynamic weatherData){
    setState(() {
      if (weatherData==null){
        temperature =0;
        weatherIcon= 'error';
        weatherMessage='unable to find anything';
        cityName= 'could not find';
        wind= 0;
        max='';
        hum=0;

      }else{
      var  temp= weatherData['main']['temp'];
      temperature =temp.toInt();
      var condition=weatherData['weather'][0]['id'];
      weatherIcon=weather.getWeatherIcon(condition)!;
      weatherMessage=weather.getMessage(temperature);
      cityName= weatherData['name'];
      int humidity=weatherData['main']['humidity'];
      hum=humidity.toInt();
      var windspeed= weatherData['wind']['speed'];
      double max_temp= weatherData['main']['temp_max'];
      wind=windspeed.toInt();
      max=max_temp.toString();
      }
    });    
  }
  
   

  
  @override
  Widget build(BuildContext context) {
   if (weatherIcon=='thunderstorm' || weatherIcon=='drizzle' || weatherIcon=='rain'){
    bgimg='images/rainy.jpg';
   }
   else if (weatherIcon=='snow'){
     bgimg='images/snow.jpg';
   }
   else if(weatherIcon=='Mist'){
     bgimg='images/mist.jpg';
   }
   else if(weatherIcon=='Smoke'){
       bgimg='images/smoke.jpg';
   }
   else if(weatherIcon=='Haze'){
     bgimg='images/haze.jpg';
   }
   else if (weatherIcon=='sand/ dust whirls'){
     bgimg='images/sand.jpg';
   }
   else if(weatherIcon=='fog'){
     bgimg='images/fog.jpg';
   }
   else if(weatherIcon=='sand' || weatherIcon=='dust'){
     bgimg='images/sandy.jpg';
   }
   else if (weatherIcon=='volcanic ash'){
     bgimg='images/volcanic ash.jpg';
   }
   else if (weatherIcon=='squalls'){
     bgimg='images/squalls.jpg';
   }
   else if(weatherIcon=='tornado'){
     bgimg='images/tornado.jpg';
   }
   else if(weatherIcon=='clear sky'){
     bgimg='images/clear sky.jpg';
   }
   else if(weatherIcon=='cloudy'){
     bgimg='images/cloudy.jpg';
   }
   else{bgimg='images/error.png';}


    return Scaffold(
      resizeToAvoidBottomInset: false,
       extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () async{                      
                     var typedname= await Navigator.push(context, MaterialPageRoute(builder: (context){
                       return CityScreen();                      
                     }));                    
                     if (typedname!=null){
                       var weatherData =await weather.getCityWeather(typedname);
                      //var condition=weatherData['weather'][0]['id'];
                       updateUI(weatherData);
                     }
                   },
          icon: Icon(
            Icons.search,
            size: 30,
            color: Colors.white,
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 12, 20, 0),
            child: GestureDetector(
              onTap: () async{
                     var weatherData=await  weather.getLocationWeather();
                     updateUI(weatherData);
                   },
              child: SvgPicture.asset(
                'assets/menu.svg',
                height: 35,
                width: 30,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
       body: Stack(
         children:[ Container(
           decoration: BoxDecoration(
               image: DecorationImage(image: AssetImage(bgimg),
               fit: BoxFit.cover,
               colorFilter: ColorFilter.mode(Colors.white, BlendMode.dstATop),
               )
           ),
           constraints: BoxConstraints.expand(),          
         ),
         Container(
              decoration: BoxDecoration(color: Colors.black38),
            ),
            SafeArea(
             child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [              
                     
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 150,
                        ),
                        Text(
                          cityName,
                          style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '$daytoday, $now ,',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$temperature°C',
                          style: TextStyle(
                            fontSize: 85,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '$weatherIcon',
                          style: TextStyle(
                            fontSize: 55,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ),                    
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 40),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Wind',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '$wind',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'km/h',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Stack(
                            children: [
                              Container(
                                height: 5,
                                width: 50,
                                color: Colors.white38,
                              ),
                              Container(
                                height: 5,
                                width: wind/2,
                                color: Colors.greenAccent,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Rain',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'no rain',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '%',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Stack(
                            children: [
                              Container(
                                height: 5,
                                width: 50,
                                color: Colors.white38,
                              ),
                              Container(
                                height: 5,
                                width: 5,
                                color: Colors.redAccent,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Humidy',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '$hum',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '%',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Stack(
                            children: [
                              Container(
                                height: 5,
                                width: 50,
                                color: Colors.white38,
                              ),
                              Container(
                                height: 5,
                                width: hum/2,
                                color: Colors.redAccent,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
             )
             ),
         ]
       )
    );
  }
}