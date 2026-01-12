import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_scan/models/scan_model.dart';

class MapaScreen extends StatefulWidget {
  const MapaScreen({Key? key}) : super(key: key);

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  MapType _mapType = MapType.normal;
  late CameraPosition _puntInicial;
  late CameraPosition _puntCentrat;
  bool _inclinat = false;
  late LatLng _posicio;

  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;

    _posicio = scan.getLatLng();

    _puntInicial = CameraPosition(
      target: _posicio,
      zoom: 17,
      tilt: 50,
    );

    _puntCentrat = CameraPosition(
      target: _posicio,
      zoom: 17,
      tilt: 0,
    );

    final Set<Marker> markers = {
      Marker(
        markerId: const MarkerId('id1'),
        position: _posicio,
      ),
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: _centrarMapa,
          ),
          IconButton(
            icon: const Icon(Icons.threed_rotation),
            onPressed: _toggleInclinacio,
          ),
        ],
      ),
      body: GoogleMap(
        markers: markers,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        mapType: _mapType,
        initialCameraPosition: _puntInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.layers),
        onPressed: _cambiarMapType,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  Future<void> _centrarMapa() async {
    final controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(_puntCentrat),
    );
    _inclinat = false;
  }

  Future<void> _toggleInclinacio() async {
    final controller = await _controller.future;
    _inclinat = !_inclinat;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _posicio,
          zoom: 17,
          tilt: _inclinat ? 50 : 0,
        ),
      ),
    );
  }

  void _cambiarMapType() {
    setState(() {
      _mapType =
          (_mapType == MapType.normal) ? MapType.hybrid : MapType.normal;
    });
  }
}
