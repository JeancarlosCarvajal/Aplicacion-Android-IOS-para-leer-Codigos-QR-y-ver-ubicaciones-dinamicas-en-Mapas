



import 'package:flutter/material.dart';
import 'package:qr_reader/providers/db_provider.dart'; 

// sera un servicio centralizado para buscar cambios en los scans o informacion relacionada a ellos
class ScanListProvider extends ChangeNotifier {

  List<ScanModel> scans = [];

  //opcion seleccionada por default
  String tipoSeleccionado = 'http';

  // creamos los metodos necesario
  nuevoScan(String valor) async {

    // creamos la instancia del nuevo scan
    final nuevoScan = new ScanModel(valor: valor);

    // Insertamos el Id en la Base de Datos
    final id = await DBProvider.db.nuevoScan(nuevoScan); // me retorna el id insertado

    // Asignar el Id de la Base de datos al Modelo
    nuevoScan.id = id;

    // esto aplica solo para los links de las direcicones de las paginas que usan http para ser mostradas en el screen de direcciones
    // si no hago esto me va mostrar los datos en geolocation tambien y no lo quiero alli 
    if(this.tipoSeleccionado == nuevoScan.tipo){ 
      // insertar el nuevo scan al listado de scan creado arriiba llamado scans
      this.scans.add(nuevoScan); // usamos el add para insertar otro elemento en el array

      // ahora notificamos a cualquier widget o agente usuario que hay un cambio en los scans
      notifyListeners(); // este metodo es propio del Provider
    } 

  }


}