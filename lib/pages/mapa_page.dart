import 'dart:async'; // para poder usar el Completer

import 'package:flutter/material.dart';
// import 'package:qr_reader/models/scan_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; // del paquete de google maps 

import 'package:qr_reader/providers/db_provider.dart';

class MapaPage extends StatefulWidget {
   
  const MapaPage({Key? key}) : super(key: key);

  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {

  static const CameraPosition puntoInicial = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  // sirve para trabar con el hasta que tengamos el google maps
  final Completer<GoogleMapController> _controller = Completer(); // paquete para el Completer 'dart:async'
   
  @override
  Widget build(BuildContext context) {

    // esto es para acceder a los valores guardados como argumento en el context, algo parecido a variables de sesion
    final ScanModel? scan = ModalRoute.of(context)!.settings.arguments as ScanModel?; 
    // tuve que agregar  as ScanModel? porque no me leia el tipo de formato, me decia que era objeto
    
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Mapa')),
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: puntoInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}