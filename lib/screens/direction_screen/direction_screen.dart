import 'dart:async';

import 'package:ecommerce/constants.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/mapview.dart';
import 'package:geolocator/geolocator.dart';
import 'package:here_sdk/routing.dart';
import 'package:here_sdk/routing.dart' as here;
import 'package:here_sdk/search.dart';

class DirectionScreen extends StatefulWidget {
  static String route = '/direction_screen';
  final String destinationPlace;

  const DirectionScreen({
    Key? key,
    required this.destinationPlace,
  }) : super(key: key);

  @override
  State<DirectionScreen> createState() => _DirectionScreenState();
}

class _DirectionScreenState extends State<DirectionScreen> {
  late Position position;
  late RoutingEngine routingEngine;
  late SearchEngine searchEngine;
  late Place destinationPlace;
  late LocationIndicator current;

  @override
  void initState() {
    searchEngine = SearchEngine();
    routingEngine = RoutingEngine();
    getCurrentLocation();
    super.initState();
  }

  void getCurrentLocation() async {
    LocationPermission locationPermission = await Geolocator.requestPermission();
    if (locationPermission == LocationPermission.whileInUse ||
        locationPermission == LocationPermission.always) {
      position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    } else {
      Fluttertoast.showToast(msg: 'Cant obtain permission');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Navigation',
        ),
        backgroundColor: cPrimaryColor,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [HereMap(onMapCreated: _onMapCreated)],
      ),
    );
  }

  void _onMapCreated(HereMapController hereMapController) {
    hereMapController.mapScene.loadSceneForMapScheme(MapScheme.normalDay, (MapError? error) {
      if (error == null) {
        Waypoint start =
            Waypoint.withDefaults(GeoCoordinates(position.latitude, position.longitude));

        hereMapController.camera.lookAtPointWithDistance(start.coordinates, 5000);
        hereMapController.mapScene.addMapMarker(
          MapMarker(
            start.coordinates,
            MapImage.withFilePathAndWidthAndHeight('assets/images/origin.png', 70, 70),
          ),
        );

        print('start: ${position.latitude} ${position.longitude}');

        AddressQuery query =
            AddressQuery.withAreaCenter(widget.destinationPlace, start.coordinates);
        searchEngine.searchByAddress(query, SearchOptions(LanguageCode.viVn, 20),
            (SearchError? searchError, List<Place>? list) {
          destinationPlace = list![0];

          print(
              'des: ${destinationPlace.geoCoordinates!.latitude} ${destinationPlace.geoCoordinates!.longitude}');

          Waypoint destination = Waypoint.withDefaults(GeoCoordinates(
              destinationPlace.geoCoordinates!.latitude,
              destinationPlace.geoCoordinates!.longitude));

          List<Waypoint> waypoints = [start, destination];
          routingEngine.calculateCarRoute(
            waypoints,
            CarOptions.withDefaults(),
            (RoutingError? routingError, List<here.Route>? routeList) async {
              if (routingError == null) {
                // When error is null, then the list guaranteed to be not null.
                here.Route route = routeList!.first;
                GeoPolyline routeGeoPolyline = GeoPolyline(route.polyline);

                double widthInPixels = getProportionateScreenWidth(20);
                MapPolyline routeMapPolyline =
                    MapPolyline(routeGeoPolyline, widthInPixels, cPrimaryColor);

                hereMapController.mapScene.addMapPolyline(routeMapPolyline);

                hereMapController.mapScene.addMapMarker(
                  MapMarker(
                    destination.coordinates,
                    MapImage.withFilePathAndWidthAndHeight('assets/images/destination.png', 70, 70),
                  ),
                );
                hereMapController.camera.lookAtPointWithGeoOrientationAndDistance(
                  start.coordinates,
                  GeoOrientationUpdate(
                      Geolocator.bearingBetween(position.latitude, position.longitude,
                          destination.coordinates.latitude, destination.coordinates.longitude),
                      0),
                  5000,
                );
              } else {
                var error = routingError.toString();
                print('Error while calculating a route: $error');
              }
            },
          );
        });
      } else {
        print("Map scene not loaded. MapError: " + error.toString());
      }
    });
  }
}
