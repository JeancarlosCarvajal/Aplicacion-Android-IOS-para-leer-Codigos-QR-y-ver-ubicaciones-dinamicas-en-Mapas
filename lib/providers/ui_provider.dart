import 'package:flutter/material.dart';



class UiProvider extends ChangeNotifier { // UiProvider extendemos de changeNotifier del paquete de material para que se tenga acceso a esata herramienta y notificar cambios en el valor de _selectedMenuOpt
  
  // se cambiara de manera condicional mendiante getters and setters, es privada con guion bajo
  int _selectedMenuOpt = 0;

  int get selectedMenuOpt {
    return this._selectedMenuOpt; // recuerda el this es opcional lo coloque como referencia
  }

  set selectedMenuOpt (int i) {
    this._selectedMenuOpt = i;
    
    // Ahora notificamos a cualquier widgets activo que se ha modificado el valor de _selectedMenuOpt
    notifyListeners(); // proviene de la extension ChangeNotifier del paquete de material
  }

}