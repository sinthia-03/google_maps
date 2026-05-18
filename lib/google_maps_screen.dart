import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsScreen extends StatefulWidget {
  const GoogleMapsScreen({super.key});

  @override
  State<GoogleMapsScreen> createState() => _GoogleMapsScreenState();
}

class _GoogleMapsScreenState extends State<GoogleMapsScreen> {

  late GoogleMapController _googleMapController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Location')),
      body: GoogleMap(
        zoomControlsEnabled: true,
        zoomGesturesEnabled: true,
        onTap: (LatLng latLng){
          print('Clicked on $latLng');
        },
        onLongPress: (LatLng latLng){
          print('Clicked on $latLng');
        },
        trafficEnabled: true,
        initialCameraPosition: CameraPosition(
          target: LatLng(23.878936212493475, 90.31951546712412),
          zoom: 16
        ),
        onMapCreated: (GoogleMapController controller){
          _googleMapController = controller;
        },

        onCameraIdle: (){
          print('Dancing animation');
        },
        onCameraMove: (CameraPosition movingPosition){
          print(movingPosition.target);
        },
        onCameraMoveStarted: (){
          print('Hide/do something');
        },
        mapType: MapType.hybrid,
      ),
    );
  }

  @override
  void dispose() {
    _googleMapController?.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
