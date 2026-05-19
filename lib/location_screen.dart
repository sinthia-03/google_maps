import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
Position? _cuurentPosition;
StreamSubscription?  _locationSubscriber;



void _listenCurrenLocation(){
  _locationSubscriber = Geolocator.getPositionStream().listen((Position){
    print(Position);
    _cuurentPosition = Position;
    setState(() {

    });
  });
}

void _cancleCurrentLocationStream(){
  _locationSubscriber?.cancel();

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Location'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text('Current Location: $_cuurentPosition',textAlign: .center),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: .spaceEvenly,
        children: [
          FloatingActionButton(onPressed: (){
            _onTapMyCurrentLocation();
          },
          child: Icon(Icons.location_history),
          ),
          FloatingActionButton(onPressed: (){
            _onTapMyCurrentLocation();
          },
            child: Icon(Icons.my_location),
          ),
          FloatingActionButton(onPressed: (){
            _onTapMyCurrentLocation();
          },
            child: Icon(Icons.location_disabled),
          ),
        ],
      ),



    );
  }

  Future<void> _onTapMyCurrentLocation()async{
    bool hasPermission = await _hasLocationPermission();
    if(hasPermission == false){
      //request permissi
      bool requestedPermission = await _requestLocationPermission();
      if(requestedPermission == false){
        return ;
      }
    }
    //Gps service user permission

    // ckeck Gps service enbale

    bool gpsEnable = await Geolocator.isLocationServiceEnabled();
    if(gpsEnable == false){
      Geolocator.openLocationSettings();
    }

    //Get current location
    _cuurentPosition = await Geolocator.getCurrentPosition();
    print(_cuurentPosition);
    setState(() {
    });
  }
 // method for permission
  Future<bool> _hasLocationPermission()async{
    LocationPermission permissionStatus = await Geolocator.checkPermission();
    return permissionStatus == .always || permissionStatus == .whileInUse;
  }

  Future<bool> _requestLocationPermission()async{
    LocationPermission permissionStatus = await Geolocator.requestPermission();
    return permissionStatus == .always || permissionStatus == .whileInUse;
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _locationSubscriber?.cancel();
  }
}
