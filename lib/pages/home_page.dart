import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/pages/direcciones_page.dart';
import 'package:qr_reader/pages/mapas_page.dart';
import 'package:qr_reader/providers/scan_list_provider.dart'; 
import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/widgets/custom_navigatorbar.dart';
import 'package:qr_reader/widgets/scan_buttom.dart';
import 'package:qr_reader/widgets/scan_tiles.dart';

class HomePage extends StatelessWidget {
   
  const HomePage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) { 

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Historial')),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: (){
              Provider.of<ScanListProvider>(context, listen: false).borrarTodos();
            }
          ),
        ],
      ),
      body: _HomePageBody(),
      bottomNavigationBar: CustomNavigatorBar(),
      floatingActionButton: ScanButtom(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // el acceso al provider esta en el context ahora debemos obtenerlo, Selected menu Opt, me va importar el paquete 'package:provider/provider.dart';
    // si lo dejo asi Provider.of(context) me va lanzar todo Dinamico debo especificarle de la siguiente manera el tipo de provider que quiero
    // Provider.of<UiProvider>(context) aqui le especifico el tipo de provider que quiero obtener del context, me va importar el paquete 'package:qr_reader/providers/ui_provider.dart';
    final uiProvider = Provider.of<UiProvider>(context); // si esto se mete dentro de una funcion se debe agregar despues del context listen: false para que no intente redibujar esa funcion nos daria error
    // (context, listen: true)  es el default

    // uiProvider nos da acceso a todas las propiedades y metodos contenidos en esa clase que creamos
    
    // Cambiar para mostrar la pagina respectiva
    // para mantener centralizado este valor se usa GESTOR de ESTADOS, Provider es el mas papolar
    final currentIndex  = uiProvider.selectedMenuOpt; // selectedMenuOpt es el getter que creamos en la clase UiProvider

    // TODO: INICIO temporal Interactuar y Leer base de datos
    // con esto probamos la creacion de la base de datos
    // DBProvider.db.database;

    // con esto probamos la insercion de datos en la base de datos
      // creamos los datos temporales
    // final tempScan = new ScanModel(valor: 'https://nftlatinoamerica.com/'); // el new es opcional
    // print(tempScan);
      // accionames el metodo nuevoScan para insertarlo en la base de datos
    // DBProvider.db.nuevoScan(tempScan); 

    // Seleccionar datos de la base de datos
    // DBProvider.db.getScanById(3); // una forma de verlo 
    // DBProvider.db.getScanById(3).then((scan) => print(scan!.valor)); // otra forma de verlo por valores individuales getTodosLosScans

    // ver todos los scans getTodosLosScans, agrege .toString() para ver los datos y que no me aparezca "instancia de...."
    // DBProvider.db.getTodosLosScans().then((scan) => print(scan.toString())); // otra forma de verlo por valores individuales 

    // ver los scans getScansPorTipo
    // DBProvider.db.getScansPorTipo('https').then((scan) => print(scan)); // otra forma de verlo por valores individuales 

    // Actualizar los scans updateScan
    // final tempUpdteScan = ScanModel(valor: 'https://nftlatinoamerica.com/44', id: 4, tipo: 'https'); // el new es opcional
    // DBProvider.db.updateScan(tempUpdteScan).then((scan) => print(scan)); // otra forma de verlo por valores individuales    

    // Borrar datos de la base de datos por Id
    // DBProvider.db.deleteScan(4).then((scan) => print(scan)); // otra forma de verlo por valores individuales   

    // Borrar datos de la base de datos por Id
    // DBProvider.db.deleteAllScans().then((scan) => print(scan)); // otra forma de verlo por valores individuales
    // TODO: FIN temporal Interactuar y Leer base de datos

    // Accedemos a los metodos que nos proporciona el Provider
    final scanListProvider = Provider.of<ScanListProvider>(context, listen: false); // listen false pa que no se redibuje no lo necesitamos

    switch( currentIndex ) {
      case 0:
        // Carga los datos desde la base de datos del telefono en el array scans y tenerlos listo para ser usado
        scanListProvider.cargarScansPorTipo('geo');
        return const ScanTiles(icon: Icons.map_outlined); // era  MapasPage();
      case 1:
        scanListProvider.cargarScansPorTipo('http');
        return const ScanTiles(icon: Icons.home_outlined); // era DireccionesPage()
      default:
        scanListProvider.cargarScansPorTipo('geo');
        return const ScanTiles(icon: Icons.map_outlined); // era  MapasPage();
    }
  }
}