import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:satagro/features/sat_agro/presentation/bloc/sat_agro_bloc.dart';
import 'package:satagro/features/sat_agro/presentation/widgets/loading_widget.dart';
import 'package:satagro/features/sat_agro/presentation/widgets/message_display.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  late GoogleMapController mapController;
  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(53, 19),
    zoom: 6,
  );
  MapType _mapType = MapType.hybrid;
  Set<Polygon> polygon = HashSet<Polygon>();
  bool permissionsChecked = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sat Agro'),
      ),
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Drawer(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent[700],
                  ),
                  accountName:
                      const Text("User Name", style: TextStyle(color: Colors.white, fontSize: 24)),
                  accountEmail:
                      const Text("User Email", style: TextStyle(color: Colors.white, fontSize: 24)),
                  currentAccountPicture:
                      const Center(child: FaIcon(FontAwesomeIcons.userLarge, size: 60)),
                ),
              ),
              SliverFillRemaining(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    ListTile(
                      title: const Text('Load test field'),
                      onTap: () {
                        context.read<SatAgroBloc>().add(LoadField());
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: const Text('Terrain map'),
                      onTap: () {
                        context.read<SatAgroBloc>().add(ChangeMap(MapType.terrain));
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: const Text('Satellite map'),
                      onTap: () {
                        context.read<SatAgroBloc>().add(ChangeMap(MapType.satellite));
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: const Text('Hybrid map'),
                      onTap: () {
                        context.read<SatAgroBloc>().add(ChangeMap(MapType.hybrid));
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: const Text('Emit error'),
                      onTap: () {
                        context.read<SatAgroBloc>().add(ErrorEvent());
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<SatAgroBloc, SatAgroState>(builder: (context, state) {
          if (state is Loading) {
            return Stack(children: [
              googleMap(),
              const LoadingWidget(),
            ]);
          } else if (state is Loaded) {
            polygon.clear();
            cameraPosition = CameraPosition(
                target: LatLng(state.points.first.latitude, state.points.first.longitude),
                zoom: 15);
            polygon.add(Polygon(
              polygonId: const PolygonId('PolygonId'),
              fillColor: Colors.green.withOpacity(0.4),
              points: state.points,
              holes: state.holes,
              strokeColor: Colors.red,
              strokeWidth: 4,
            ));
            mapController.moveCamera(CameraUpdate.newCameraPosition(cameraPosition));
            return googleMap();
          } else if (state is MapFoundationChanged) {
            _mapType = state.mapType;
            return googleMap();
          } else if (state is Error) {
            return MessageDisplay(
              message: state.message,
            );
          }
          // initial state
          if (permissionsChecked == true) {
            return googleMap();
          }
          checkLocationPermission();
          return const MessageDisplay(
            message: "No location permissions",
          );
        }),
      ),
    );
  }

  googleMap() => Stack(children: [
        GoogleMap(
          initialCameraPosition: cameraPosition,
          mapType: _mapType,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          polygons: polygon,
          onMapCreated: (GoogleMapController controller) {
            mapController = controller;
          },
          padding: EdgeInsets.only(top: 40.0, right: 40),
        ),
      ]);

  checkLocationPermission() {
    Permission.location.status.then((PermissionStatus status) {
      if (status == PermissionStatus.granted) {
        setState(() {
          permissionsChecked = true;
        });
      } else if (Platform.isAndroid || status == PermissionStatus.denied) {
        Permission.locationWhenInUse.request().then((status) {
          setState(() {
            // if not granted, map will work the same but user location will not be shown
            permissionsChecked = true;
          });
        });
      } else {
        // iOS permission previously denied
        AlertDialog(
          title: const Text("Open App Settings"),
          content: const Text(
              "You have previously disabled the camera permission. If you want to enable it again, you need to do so from the app's settings menu. Would you like to go there now?"),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  permissionsChecked = true;
                });

                openAppSettings();
              },
              child: const Text("Open", textAlign: TextAlign.center),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // map will work the same but user location will not be shown
                  permissionsChecked = true;
                });
              },
              child: const Text("Cancel", textAlign: TextAlign.center),
            )
          ],
        );
      }
    });
  }
}
