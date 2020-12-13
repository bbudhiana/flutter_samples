import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

/*
source : 
https://github.com/tekartik/sqflite/blob/master/sqflite/doc/sql.md
https://pub.dev/packages/sqflite
*/

class DBHelper {
  //0. Buat Future Database gar tidak ada pengulangan
  static Future<Database> database() async {
    //1. TENTUKAN PATH DIMANA DB BERADA
    final dbPath = await sql.getDatabasesPath();

    //2. Kembalikan database jika ada, jika belum ada dibuat 'places.db' dan juga table user_places
    return sql.openDatabase(
      path.join(dbPath, 'places.db'),
      //jika places.db tidak ditemukan maka onCreate dilakukan untuk inisialisasi table
      onCreate: (db, version) {
        //akhirnya kita eksekusi dari sql statement nya, yaitu buat table user_places
        return db.execute(
            'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, loc_lat REAL, loc_lng REAL, address TEXT)');
      },
      version: 1,
    );
  }

  //Static Function untuk dapat menyimpan data ke database sqlite
  static Future<void> insert(String table, Map<String, Object> data) async {
    /* //jika belum ada database nya maka buat lebih dulu

    //1. Definisi letak databases. getDatabasesPath mendefinisikan baik android dan iOS untuk letak file DB nya
    final dbPath = await sql.getDatabasesPath();

    //2. Open database nya berdasarkan path di atas, gunakan onCreate yg jika tidak ditemukan maka buat baru file db nya
    final sqlDb = await sql.openDatabase(
      path.join(dbPath, 'places.db'),
      //jika places.db tidak ditemukan maka onCreate dilakukan
      onCreate: (db, version) {
        //akhirnya kita eksekusi dari sql statement nya, yaitu buat table user_places
        return db.execute(
            'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
      },
      version: 1,
    ); */

    //3. db file terbentuk dan table terbentuk, maka tinggal  but insert nya
    /* sqlDb.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    ); */

    //1. GUNAKAN KONEKSI DARI Future<Database> database() di atas
    final db = await DBHelper.database();

    //2. LAKUKAN PROSES SQL NYA
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  //static Function berikut untuk fetch data
  //table akan menampung List dari Type data Map yang berisi String dan Dynamic
  static Future<List<Map<String, dynamic>>> getData(String table) async {
    //1. GUNAKAN KONEKSI DARI Future<Database> database() di atas
    final db = await DBHelper.database();

    //2. jalankan sql nya dan kembalikan hasilnya dalam List<Map>
    return db.query(table);
  }
}
