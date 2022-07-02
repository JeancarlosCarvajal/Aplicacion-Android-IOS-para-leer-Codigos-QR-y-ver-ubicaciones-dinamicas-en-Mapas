



import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart'; 
import 'package:path/path.dart'; // para poder usar el join()
import 'package:qr_reader/models/scan_model.dart';
export 'package:qr_reader/models/scan_model.dart'; // para cuando se use este db_provider.dart de una vez se incluya scan_model.dart la exporto

class DBProvider {


  static Database? _database; 
  // Creamos la instancia de la clase DBProvider
  static final DBProvider db = DBProvider._(); // _() es un constructor privado 
  // creando el constructo privado, cuando se haga un new del provider siempre me mostrata la misma instancia
  DBProvider._(); // de esta manera puedo acceder de esta forma DBProvider.db.database;

  // acceder el objeto del _database
  Future<Database?> get database async { // async es porque la base de datos toma timepo en responder 
    if(_database != null) return _database;

    // regresa la base de datos
    _database = await initDB();

    return _database;

  }
  // Creacion de la base de datos dentro del telefono 
  Future<Database> initDB() async {
    // path donde almacenaremos la base de datos 
    // se importo dart:io con el Directory. y getApplicationDocumentsDirectory() es proveniente de la instalacion del paquete pathprovider instalado anterirmente
    // getApplicationDocumentsDirectory detecta automaticamente la ubicacion de la base de datos en el telefono
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    // print(documentsDirectory.path);
    // creando el path de la base de datos usando los paquetes instalados y los ya disponibles
    final path = join( documentsDirectory.path, 'ScansDB.db' ); // importar paquete 'package:path/path.dart' para usar join(), permite unir URLs
    // print(path);

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

  // Insertar datos en la Base de datos. metodo mas largo y complicado
  // Future<int> nuevoScanRaw( ScanModel nuevoScan) async {

  //   final id    = nuevoScan.id;
  //   final tipo  = nuevoScan.tipo;
  //   final valor = nuevoScan.valor;

  //   // verificar la base de datos, crear este final se activa el getter y crea la base de datos en caso que no se haya creado
  //   final db = await database; // database es nuestro getter OJO

  //   // para convertir el dato en string se envuarle en '$valor'
  //   final res = await db!.rawInsert('''
  //     INSERT INTO Scans(id, tipo, valor)
  //       VALUES( $id, '$tipo', '$valor')
  //   ''');

  //   return res; // en un entero
  // }

  // Insertar datos en la Base de datos. metodo mas corto y sensillo
  Future<int> nuevoScan (ScanModel nuevoScan) async {

    // verificar la base de datos, crear este final se activa el getter y crea la base de datos en caso que no se haya creado
    final db = await database;
    print('Desde base de datos creando nuevo tipo: ${nuevoScan.tipo}');
    // inserta los valor desde formato json en la base de datos
    final res = await db!.insert('Scans', nuevoScan.toMap());
    // retorna el id insertado en la base de datos
    print('Id Insertado: $res');
    return res;

  }

  // Seleccionar dato Individual en la base de datos
  Future<ScanModel?> getScanById (int id)  async {

    // verificar la base de datos, crear este final se activa el getter y crea la base de datos en caso que no se haya creado
    final db = await database; // database es nuestro getter OJO

    // query me muestra todos los dato de la tabla que le indiques en este caso es 'Scans'
    final res = await db!.query('Scans', where: 'id = ?', whereArgs: [id]);
    //  print('Id Insertado: $res');
    return res.isNotEmpty // si no esta vacio muestrame el primero el cual es el unico
      ? ScanModel.fromMap(res.first)
      : null;
  }

  // Seleccionar todos los scans en la base de datos
  Future<List<ScanModel>?> getTodosLosScans ()  async {

    // verificar la base de datos, crear este final se activa el getter y crea la base de datos en caso que no se haya creado
    final db = await database; // database es nuestro getter OJO

    // query me muestra todos los dato de la tabla que le indiques en este caso es 'Scans'
    final res = await db!.query('Scans');
    // print('Select Todos Scans: $res');
    return res.isNotEmpty // si no esta vacio muestrame el primero el cual es el unico
      ? res.map((scan)=>ScanModel.fromMap(scan)).toList()
      : [];
  }

  // Seleccionar por tipo los scans en la base de datos
  Future<List<ScanModel>?> getScansPorTipo (String tipo)  async {

    // verificar la base de datos, crear este final se activa el getter y crea la base de datos en caso que no se haya creado
    final db = await database; // database es nuestro getter OJO

    // query me muestra todos los dato de la tabla que le indiques en este caso es 'Scans'
    // rawQuery es otra forma de hacerlo
    final res = await db!.rawQuery('''
      SELECT * FROM Scans WHERE tipo = '$tipo'
    '''); 
    // print('Select por Tipo: $res');
    return res.isNotEmpty // si no esta vacio muestrame el primero el cual es el unico
      ? res.map((scan)=>ScanModel.fromMap(scan)).toList()
      : [];
  }

  // Actualiza los scans en la base de datos
  Future<int> updateScan (ScanModel nuevoScan)  async {

    // verificar la base de datos, crear este final se activa el getter y crea la base de datos en caso que no se haya creado
    final db = await database; // database es nuestro getter OJO

    // query me Actualiza todos los dato de la tabla que le indiques en este caso es 'Scans' 
    final res = await db!.update('Scans', nuevoScan.toMap(), where: 'id = ?', whereArgs: [nuevoScan.id]); 
    // print('Actualizado: $res');
    return res;
  }

  // Borra un scan por id
  Future<int> deleteScan (int id)  async {

    // verificar la base de datos, crear este final se activa el getter y crea la base de datos en caso que no se haya creado
    final db = await database; // database es nuestro getter OJO

    // query me Borra todos los dato de la tabla que le indiques con el Id
    final res = await db!.delete('Scans', where: 'id = ?', whereArgs: [id]); 
    // print('Borrado: $res');
    return res;
  }

  // Borra todos los scans en la base de datos
  Future<int> deleteAllScans ()  async {

    // verificar la base de datos, crear este final se activa el getter y crea la base de datos en caso que no se haya creado
    final db = await database; // database es nuestro getter OJO

    // query me Borra todos los dato de la tabla
      // forma facil
    // final res = await db!.delete('Scans');
      // forma mas larga
    final res = await db!.rawDelete('''
      DELETE FROM Scans
    '''); // forma mas larga
    // print('Borrado: $res');
    return res; // devuelve la cantidad de registros borrados
  }


}