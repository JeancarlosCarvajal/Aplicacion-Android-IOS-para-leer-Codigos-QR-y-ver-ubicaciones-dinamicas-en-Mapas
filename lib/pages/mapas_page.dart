import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/theme/app_theme.dart';


// se usara como el cuerpo del scaffold para mostar el mapa es como un Iframe en HTML
class MapasPage extends StatelessWidget {
   
  const MapasPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    // una pista cuando estemo dentro de un build se coloca el Listen y en lo metodos (funciones) no se coloca
    final scanListProvider = Provider.of<ScanListProvider>(context); // Aqui necesito volver a redibujar el canvas
    final scans = scanListProvider.scans;

    return ListView.builder(
      itemCount: scans.length, // scans es un array
      itemBuilder: (_, i) => ListTile(
        leading: const Icon(Icons.map, color: AppTheme.activeLight),
        title: Text(scans[i].valor),
        subtitle: Text(scans[i].id.toString()),
        trailing: const Icon(Icons.keyboard_arrow_right, color: AppTheme.unactiveLight),
        onTap: () => print('Valores de ID: ${scans[i].id}'), // evento al hacer click en la lista  
      ), 
    );
  }
}