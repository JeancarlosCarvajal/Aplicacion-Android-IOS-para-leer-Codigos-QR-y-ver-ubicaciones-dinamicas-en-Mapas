



import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart'; // para poder usar el join()

class DBProvider {


  static Database? _database; 
  // Creamos la instancia de la clase DBProvider
  static final DBProvider db = DBProvider._(); // _() es un constructor privado 
  // creando el constructo privado, cuando se haga un new del provider siempre me mostrata la misma instancia
  DBProvider._(); // de esta manera puedo acceder de esta forma DBProvider.db.database;

  // acceder el objeto del _database
  Future<Database?> get database async {// async es porque la base de datos toma timepo en responder 
    if(_database != null) return _database;

    // regresa la base de datos
    _database = await initDB();

    return _database;

  }
  
  Future<Database> initDB() async {
    // path donde almacenaremos la base de datos 
    // se importo dart:io con el Directory. y getApplicationDocumentsDirectory() es proveniente de la instalacion del paquete pathprovider instalado anterirmente
    // getApplicationDocumentsDirectory detecta automaticamente la ubicacion de la base de datos en el telefono
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    print(documentsDirectory.path);
    // creando el path de la base de datos usando los paquetes instalados y los ya disponibles
    final path = join( documentsDirectory.path, 'ScansDB.db' ); // importar paquete 'package:path/path.dart' para usar join(), permite unir URLs
    print(path);

    //Creacion de la base de datos
    return await openDatabase(
      path,
      version: 1, // debemos cambiar la version de las bases de datos,m cada ves que se hace un cambio a la base de datos, borrar tablas actualizar estructuras de tablas etc
      onOpen: (db){},
      onCreate: (Database db, int version) async {
        // creamos un string multiliea
        await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            tipo TEXT,
            valor TEXT
          );
        ''');
      },
    );
  }

}