import 'package:weather_appfix/services/location.dart';
import 'package:weather_appfix/services/network.dart';

const apikey='YOUR API KEY';
const openWeatherUrl='https://api.openweathermap.org/data/2.5/weather';

class WeatherModel{
  Future <dynamic> getCityWeather(String cityName)async{
    NetworkHelper networkhelper=NetworkHelper('$openWeatherUrl?q=$cityName&appid=$apikey&units=metric');
    var weatherData = await networkhelper.getData();
    return weatherData;
  }

  Future <dynamic> getLocationWeather()async{
    Location location=Location();
    await location.getCurrentLocation();

    NetworkHelper networkhelper = NetworkHelper('$openWeatherUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$apikey');
    var weatherData=await networkhelper.getData();
    return weatherData;
    
    
  }

  String ?getWeatherIcon(int condition) {
    
      if(condition>=199 && condition<=232){
        return 'thunderstorm';        
      }
      else if(condition>=299 && condition<=321){
          return 'drizzle';
      }      
      else if(condition>=499 && condition<=531){
          return 'rain';
      }
      else if(condition>=599 && condition<=623){
        return 'snow';  
      }
      else if(condition>=700 && condition<=782){
         if (condition==701){return 'Mist';}
         if (condition==711){return 'Smoke';}
         if (condition==721){return 'Haze';}
          if (condition==731){return 'sand/ dust whirls';}
           if (condition==741){return 'fog';}
            if (condition==751){return 'sand';}
             if (condition==761){return 'dust';}
              if (condition==762){return 'volcanic ash';}
               if (condition==771){return 'squalls';}
                if (condition==781){return 'tornado';}
      }
      else if(condition==800){
          return 'clear sky';
      }
      else if(condition>=800 && condition<=804){
          return 'cloudy';
      }
      else{
        return '🤔';
      }
    }

    String getMessage(int temp){
      if (temp>30){
        return 'it\'s icecream time';
      }
      else if(temp>25){
        return 'time for shorts and pant and AC';
      }
      else if (temp<16){
        return 'get to warm place';
      }
       else if (temp<5){
        return 'it\'s very cold outside';
      }
      else{
        return 'bring coat in case';
      }
    }
  }
