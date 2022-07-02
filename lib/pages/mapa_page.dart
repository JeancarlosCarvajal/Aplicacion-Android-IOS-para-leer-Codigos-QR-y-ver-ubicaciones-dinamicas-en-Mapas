import 'package:flutter/material.dart';
import 'package:qr_reader/models/scan_model.dart';

class MapaPage extends StatelessWidget {
   
  const MapaPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    // esto es para acceder a los valores guardados como argumento en el context, algo parecido a variables de sesion
    final ScanModel? scan = ModalRoute.of(context)!.settings.arguments as ScanModel?; 
    // tuve que agregar  as ScanModel? porque no me leia el tipo de formato, me decia que era objeto
    
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Mapa')),
      ),
      body: Center(
         child: Text((scan!.valor)),
      ),
    );
  }
}