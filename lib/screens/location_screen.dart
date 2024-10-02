import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/city_screen.dart';


class LocationScreen extends StatefulWidget {

  final loactionData;
  LocationScreen({this.loactionData});


  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late int temperature;
  late String cityName;
  WeatherModel weatherModel=WeatherModel();
  late String weatherIcon;
  late String message;


  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      updateUI(widget.loactionData);
    });
    super.initState();
  }
  void updateUI(dynamic weatherData){
    if(weatherData==null){
      temperature=0;
      cityName="位置区域";
      weatherIcon="🤷‍";
      message="Bring a 🧥 just in case";
    }else{
      temperature=int.parse(weatherData['results'][0]["now"]["temperature"]);
      cityName=weatherData['results'][0]['location']["name"];
      print(temperature);
      weatherIcon=weatherModel.getWeatherIcon(weatherData['results'][0]['now']["text"]);
      print(cityName);
      message=weatherModel.getMessage(temperature);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  MaterialButton(
                    onPressed: () async{
                        await weatherModel.getLocationWeather().then((value) => updateUI(value));
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  MaterialButton(
                    onPressed: () async {
                     var typeName= await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen();
                      }));
                     if(typeName!=null){
                       await weatherModel.getCityWeather(typeName).then((value) => setState(() {
                         updateUI(value);
                       }));
                     }

                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ),
                ],
              ),
              Text(
                '$message in $cityName',
                textAlign: TextAlign.right,
                style: kMessageTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
