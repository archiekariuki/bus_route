import 'package:bus_route/styles/styles.dart';
import 'package:bus_route/widgets/BrandDivider.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'dart:io';

class MainPage extends StatefulWidget {
  static const String id = 'MainPage';

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  GlobalKey<ScaffoldState> globalKey = new GlobalKey<ScaffoldState>();
  double searchSheetHeight = (Platform.isIOS) ? 310 : 280;
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;
  double mapBottomPadding = 0;

  var geoLocator = new Geolocator();
  Position currentPosition;

  void setUpPositionLocator() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentPosition = position;
    LatLng pos = LatLng(position.latitude, position.longitude);
    CameraPosition cp = new CameraPosition(target: pos, zoom: 14);
    mapController.animateCamera(CameraUpdate.newCameraPosition(cp));
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: globalKey,
        drawer: Container(
            width: 250,
            color: Colors.white,
            child: Drawer(
              child: ListView(
                padding: EdgeInsets.all(0),
                children: [
                  Container(
                    color: Colors.white,
                    height: 160,
                    child: DrawerHeader(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            Image.asset('images/user_icon.png'),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Kariuki',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat-Bold',
                                      fontSize: 18),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text('View Profile')
                              ],
                            )
                          ],
                        )),
                  ),
                  BrandDivider(),
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    leading: Icon(OMIcons.cardGiftcard),
                    title: Text(
                      'Free Ride',
                      style: KDrawerItemStyle,
                    ),
                  ),
                  ListTile(
                    leading: Icon(OMIcons.creditCard),
                    title: Text(
                      'Payment',
                      style: KDrawerItemStyle,
                    ),
                  ),
                  ListTile(
                    leading: Icon(OMIcons.history),
                    title: Text(
                      'Ride History',
                      style: KDrawerItemStyle,
                    ),
                  ),
                  ListTile(
                    leading: Icon(OMIcons.contactSupport),
                    title: Text(
                      'Support',
                      style: KDrawerItemStyle,
                    ),
                  ),
                  ListTile(
                    leading: Icon(OMIcons.info),
                    title: Text(
                      'About',
                      style: KDrawerItemStyle,
                    ),
                  ),
                ],
              ),
            )),
        body: Stack(
          children: [
            GoogleMap(
              padding: EdgeInsets.only(bottom: mapBottomPadding),
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                mapController = controller;
                setState(() {
                  mapBottomPadding = searchSheetHeight;
                });
                setUpPositionLocator();
              },
            ),

            ///MenuButton
            Positioned(
              top: 44,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  globalKey.currentState.openDrawer();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5.0,
                            spreadRadius: 0.5,
                            offset: Offset(0.7, 0.7))
                      ]),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30,
                    child: Icon(
                      Icons.menu,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),

            ///SearchSheet
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: searchSheetHeight,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 15.0,
                          spreadRadius: 0.5,
                          offset: Offset(0.7, 0.7))
                    ]),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Nice to see you',
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'Where are you going?',
                        style: TextStyle(
                            fontFamily: 'Montserrat-Bold',
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration:
                            BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5.0,
                              spreadRadius: 0.5,
                              offset: Offset(0.7, 0.7))
                        ]),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.search,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Search Destination',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: Colors.grey,
                                    fontFamily: 'MontSerrat-Regular'),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 22.0,
                      ),
                      Row(
                        children: [
                          Icon(
                            OMIcons.home,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Add Home'),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                'Your Residential Address',
                                style:
                                    TextStyle(fontSize: 11, color: Colors.grey),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      BrandDivider(),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Icon(
                            OMIcons.workOutline,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Add Work'),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                'Your Office Address',
                                style:
                                    TextStyle(fontSize: 11, color: Colors.grey),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
