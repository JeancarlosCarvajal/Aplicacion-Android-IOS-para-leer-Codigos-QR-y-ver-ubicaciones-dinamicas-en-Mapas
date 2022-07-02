



import 'package:flutter/material.dart';
import 'package:qr_reader/providers/db_provider.dart'; 

// sera un servicio centralizado para buscar cambios en los scans o informacion relacionada a ellos
class ScanListProvider extends ChangeNotifier {

  List<ScanModel> scans = [];

  //opcion seleccionada por default
  String tipoSeleccionado = 'http';

  // creamos los metodos necesario
  Future<ScanModel> nuevoScan(String valor) async {

    // creamos la instancia del nuevo scan
    final nuevoScan = new ScanModel(valor: valor);

    // Insertamos el Id en la Base de Datos
    final id = await DBProvider.db.nuevoScan(nuevoScan); // me retorna el id insertado

    // Asignar el Id de la Base de datos al Modelo
    nuevoScan.id = id;

    // print(nuevoScan.tipo);

    // esto aplica solo para los links de las direcicones de las paginas que usan http para ser mostradas en el screen de direcciones
    // si no hago esto me va mostrar los datos en geolocation tambien y no lo quiero alli 
    if(this.tipoSeleccionado == nuevoScan.tipo){ 
      print('Son igules');
      // insertar el nuevo scan al listado de scan creado arriiba llamado scans
      this.scans.add(nuevoScan); // usamos el add para insertar otro elemento en el array
      // ahora notificamos a cualquier widget o agente usuario que hay un cambio en los scans
      notifyListeners(); // este metodo es propio del Provider
    } 

    // tipoSeleccionado = nuevoScan.tipo!;
    // cargarScansPorTipo( nuevoScan.tipo! );
    return nuevoScan;

  }

  cargarScans() async {
    // obtenermos todos los scans de la base de datos
    final scans_new = await DBProvider.db.getTodosLosScans();
    // igualo el scans creado arriba a los datos de la base de datos
    this.scans = [...scans_new!];
    // notifico a todo aquel widget insteresado en el cambio
    notifyListeners();
  }

  cargarScansPorTipo( String tipo ) async {
    // obtenermos todos los scans de la base de datos
    final scans_new = await DBProvider.db.getScansPorTipo(tipo);
    // igualo el scans creado arriba a los datos de la base de datos por tipo
    this.scans = [...scans_new!];
    // notifico a todo aquel widget insteresado en el cambio
    notifyListeners();
  }

  borrarTodos() async {
    // Borramos todos los scans de la base de datos
    await DBProvider.db.deleteAllScans();
    // remuevo el scans borrado arriba  
    this.scans = [];
    // notifico a todo aquel widget insteresado en el cambio
    notifyListeners();
  }

  borrarScanPorId(int id) async {
    // Borramos el scans de la base de datos
    await DBProvider.db.deleteScan(id);
    // vuelvo a llamar el metodo para llenar los tipos sin el id que borre
    // this.cargarScansPorTipo(this.tipoSeleccionado); // lo comente porque el widget Dismissible usado en las pages me elimina la lista moviendolas a los lados y no necesito redibujar el canvas
  }

}