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
        mapType: MapType.normal, //map type set
        markers: <Marker>{ // marker set
          Marker(
              markerId: MarkerId('home'),
            position: LatLng(23.8812505449456, 90.3209863230586),
            infoWindow: InfoWindow(
              title: 'Home',
              onTap: (){

              }
            )
          ),
          Marker(
              markerId: MarkerId('office'),
              position: LatLng(23.87710623884813, 90.32010555267334),
              infoWindow: InfoWindow(
                  title: 'office',
                onTap: (){

                }
              ),
            // marker er color set
           icon: BitmapDescriptor.defaultMarkerWithHue(
               BitmapDescriptor.hueAzure),
            //custom icon set
            //icon: await BitmapDescriptor.asset(
              //  ImageConfiguration(), 'path of icon');


          ),
        },
        circles: <Circle>{
          Circle(
              circleId: CircleId('red - Zoon'),
            center: LatLng(23.885769643281883, 90.32407857477665),
            radius: 200,
            fillColor: Colors.red.withAlpha(50),
            strokeColor: Colors.red,
            strokeWidth: 3,
            consumeTapEvents: true,
            onTap: (){
            print('tapped on circle');
            }
            
          ),
          Circle(
              circleId: CircleId('green-Zoon'),
              center: LatLng(23.87306082909841, 90.30978742986917),
              radius: 200,
              fillColor: Colors.green.withAlpha(50),
              strokeColor: Colors.green,
              strokeWidth: 3,
              consumeTapEvents: true,
              onTap: (){
                print('tapped on  green zoon circle');
              }

          )
        },
        polylines:<Polyline>{
          Polyline(
            polylineId: PolylineId('home-to-office'),
            points: [

              LatLng(23.8812505449456, 90.3209863230586),
              LatLng(23.87710623884813, 90.32010555267334),
              LatLng(23.87306082909841, 90.30978742986917),
            ],
            width: 4,
            color: Colors.blue,
            endCap: .roundCap,
            visible: true,
            startCap: .roundCap
          )
        },
        polygons: <Polygon>{
          Polygon(
            polygonId: PolygonId('danger-area'),
            points: [
              LatLng(23.868675578647682, 90.32634034752846),
              LatLng(23.866857724160475, 90.33268008381128),
              LatLng(23.868910435368935, 90.3347135335207)
            ],
            fillColor: Colors.red.withAlpha(50),
            strokeColor: Colors.orange,
            strokeWidth: 3,
            consumeTapEvents: true,
            onTap: (){
              print('Tapped on danger area');
            }
          )
        },


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
