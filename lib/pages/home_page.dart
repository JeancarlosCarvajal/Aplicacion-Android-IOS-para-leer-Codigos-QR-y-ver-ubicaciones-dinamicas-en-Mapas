import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/pages/direcciones_page.dart';
import 'package:qr_reader/pages/mapas_page.dart';
import 'package:qr_reader/providers/db_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/widgets/custom_navigatorbar.dart';
import 'package:qr_reader/widgets/scan_buttom.dart';

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
            onPressed: (){}
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

    // TODO: temporal leer base de datos
    DBProvider.db.database;
    
    switch( currentIndex ) {
      case 0:
        return MapasPage();
      case 1:
        return DireccionesPage();
      default:
        return MapasPage(); 
    }
  }
}