import 'package:geolocator/geolocator.dart';


class Location {
  double latitude=0;
  double longitude=0;
  Future<void> getCurrentLocation() async {
    LocationPermission permission=await Geolocator.checkPermission();
    bool isEnabled = await Geolocator.isLocationServiceEnabled();
    if(!isEnabled){
      await Geolocator.openLocationSettings();
    }else{
      if(permission==LocationPermission.denied){
        print("Permission denied");
        permission=await Geolocator.requestPermission();
        if(permission==LocationPermission.whileInUse || permission==LocationPermission.always){
          await getPosition();
        }
        return;
      }else if(permission==LocationPermission.deniedForever){
        print("Permission denied forever");
        permission=await Geolocator.requestPermission();
        if(permission==LocationPermission.whileInUse || permission==LocationPermission.always){
          await getPosition();
        }
      }else if(permission==LocationPermission.whileInUse || permission==LocationPermission.always){
        //forceAndroidLocationManager 真机需要设置为true
        await getPosition();
      }
    }
  }

  Future<void> getPosition() async {
    try{
      print("Permission granted");
      Position location = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print("latitude:${location.latitude}");
      print("longitude:${location.longitude}");
      latitude=location.latitude;
      longitude=location.longitude;
    }catch(e){
      print(e);
    }
  }
}

