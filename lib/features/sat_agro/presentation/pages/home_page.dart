import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
                  currentAccountPicture: const Center(child: FaIcon(FontAwesomeIcons.userLarge, size:60)),
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
                      },
                    ),
                    ListTile(
                      title: const Text('Terrain map'),
                      onTap: () {
                        context.read<SatAgroBloc>().add(ChangeMap(MapType.terrain));
                      },
                    ),
                    ListTile(
                      title: const Text('Satellite map'),
                      onTap: () {
                        context.read<SatAgroBloc>().add(ChangeMap(MapType.satellite));
                      },
                    ),
                    ListTile(
                      title: const Text('Hybrid map'),
                      onTap: () {
                        context.read<SatAgroBloc>().add(ChangeMap(MapType.hybrid));
                      },
                    ),
                    ListTile(
                      title: const Text('Emit error'),
                      onTap: () {
                        context.read<SatAgroBloc>().add(ErrorEvent());
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
          } else if (state is Error){
            return MessageDisplay(
              message: state.message,
            );
          }
          // initial state
          return googleMap();
        }),
      ),
    );
  }

  googleMap() => GoogleMap(
        initialCameraPosition: cameraPosition,
        mapType: _mapType,
        myLocationEnabled: true,
        polygons: polygon,
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
      );
}
