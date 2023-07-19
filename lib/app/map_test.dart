
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';




class MyMap  extends StatefulWidget {

  double height;
  double width;
  GeoPoint latLng;
  MyMap({required this.height, required this.width, required this.latLng});

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  @override
  void initState() {
    if(markers.isNotEmpty){
      setState(() {
        showMap=true;
      });
    }
    //List<String> ll= widget.latLng.split(',');

    //GeoPoint sd= GeoPoint(double.parse(removeLastTwoDigits(ll.first)), double.parse(removeLastTwoDigits(ll.last)));

    //print(removeLastTwoDigits(ll.first).toString()+'dddddddddddddddddd');
    // markers.add(
    //   Marker(
    //     markerId: MarkerId('${removeLastTwoDigits(ll.first)},${removeLastTwoDigits(ll.last)}'),
    //     position: LatLng(double.parse(removeLastTwoDigits(ll.first)), double.parse(removeLastTwoDigits(ll.last))),
    //   ),
    // );
    print(widget.latLng.latitude.toString()+'========ddddddddd'+widget.latLng.latitude.toString());
    markers.add(
      Marker(
        markerId: MarkerId('${widget.latLng.latitude},${widget.latLng.longitude}'),
        position: LatLng(widget.latLng.latitude, widget.latLng.longitude),
      ),
    );
    super.initState();
  }

  String removeLastTwoDigits(String str) {
    print(str.toString()+'============');
    print(str.substring(0, str.length - 2)+'====-------========');
    return str.substring(0, str.length - 2);
  }

  late GoogleMapController googleMapController;

  List<Marker> markers=[];

  bool showMap= true;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return showMap? SizedBox(
      width: widget.width,
      height: widget.height,
      child: GoogleMap(
        onMapCreated: (controller){
          googleMapController= controller;
        },
        buildingsEnabled: true,
        onTap:(LatLng latLng){},
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.latLng.latitude, widget.latLng.longitude),
          zoom: 15,
        ),
        markers: Set<Marker>.of(markers),
        mapType: MapType.normal,
      ),
    )
        : Center(child: CircularProgressIndicator());
  }
}

