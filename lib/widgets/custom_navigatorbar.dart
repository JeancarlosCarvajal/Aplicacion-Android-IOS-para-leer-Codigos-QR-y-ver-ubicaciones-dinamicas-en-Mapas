import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';

class CustomNavigatorBar extends StatelessWidget {
   
  const CustomNavigatorBar({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    // el acceso al provider esta en el context ahora debemos obtenerlo, Selected menu Opt, me va importar el paquete 'package:provider/provider.dart';
    // si lo dejo asi Provider.of(context) me va lanzar todo Dinamico debo especificarle de la siguiente manera el tipo de provider que quiero
    // Provider.of<UiProvider>(context) aqui le especifico el tipo de provider que quiero obtener del context, me va importar el paquete 'package:qr_reader/providers/ui_provider.dart';
    final uiProvider = Provider.of<UiProvider>(context); // si esto se mete dentro de una funcion se debe agregar despues del context listen: false para que no intente redibujar esa funcion nos daria error
    // (context, listen: true)  es el default
    
    final currentIndex = uiProvider.selectedMenuOpt;  // selectedMenuOpt es el getter que creamos en la clase UiProvider

    return BottomNavigationBar( // minimo dos elementos sino no funciona
      // onTap: (int i) => print('Opt: $i'), // metodo lee el index donde se hace click o touch es un evento del widget BottomNavigationBar
      onTap: (int i) => uiProvider.selectedMenuOpt = i, // metodo lee el index donde se hace click o touch es un evento del widget BottomNavigationBar
      currentIndex: currentIndex,
      elevation: 0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.map_outlined, size: 50),
          label: 'Mapa' 
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.compass_calibration, size: 50),
          label: 'Direcciones' 
        )
      ],
    );
  }
}