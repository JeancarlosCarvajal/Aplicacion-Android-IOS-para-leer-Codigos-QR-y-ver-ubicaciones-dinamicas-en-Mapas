import 'dart:async'; // para poder usar el Completer

import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart'; // del paquete de google maps 

import 'package:qr_reader/providers/db_provider.dart';

class MapaPage extends StatefulWidget {
   
  const MapaPage({Key? key}) : super(key: key);

  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {

  // sirve para trabar con el hasta que tengamos el google maps
  // GoogleMapController controla la camara tipos de vista etc, crear polilines y muchas cosas mas
  final Completer<GoogleMapController> _controller = Completer(); // paquete para el Completer 'dart:async'

  // para modificarlo abajo ya que estamos en un satatefullwidget
  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {

    // esto es para acceder a los valores guardados como argumento en el context, algo parecido a variables de sesion
    final ScanModel? scan = ModalRoute.of(context)!.settings.arguments as ScanModel?; 
    // tuve que agregar  as ScanModel? porque no me leia el tipo de formato, me decia que era objeto
    
    final CameraPosition puntoInicial = CameraPosition(
      target: scan!.getLatLng(),
      zoom: 17.5,
      tilt: 50, // para que se vea en 3d inclinado
    );

    // Marcadores documentacion por google
    Set<Marker> markers = new Set<Marker>();
    markers.add(
      Marker(
        markerId: const MarkerId('Geo Location'),
        position: scan.getLatLng()      
      )
    );

    Future<void> _goToTheLake() async {
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(puntoInicial));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Mapa')),
        actions: [
          IconButton(
            icon: Icon(Icons.location_disabled),
            onPressed: () async {
              GoogleMapController controller = await _controller.future;
              controller.animateCamera(CameraUpdate.newCameraPosition(puntoInicial));
            }, 
          )
        ],
      ),
      body: GoogleMap(
        mapType: mapType, // tenia MapType.normal y movi arriba como variable para poder modiviar las capas del mapa
        initialCameraPosition: puntoInicial,
        markers: markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        }, 
      ),
      floatingActionButton: Container(
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton(
          child: const Icon(Icons.layers),
          onPressed: () {
            if(mapType == MapType.normal){
              mapType = MapType.satellite;
            }else{
              mapType = MapType.normal; 
            }
            // setState se usa para redibujar en un statefulwidget
            setState(() {});
        },),
      ),
      // floatingActionButton: Container(
      //   alignment: Alignment.bottomCenter,
      //   child: FloatingActionButton.extended(
      //     onPressed: _goToTheLake,
      //     label: const Icon(Icons.home_filled),
      //     // icon: Icon(Icons.home_filled),
      //   ),
      // ),
    );
  }
}