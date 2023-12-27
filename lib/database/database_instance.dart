import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseInstance {
  DatabaseInstance._privateConst();
  static DatabaseInstance instance = DatabaseInstance._privateConst();

  final String _databaseName = 'sbpos.db';
  final int _databaseVersion = 1;

  Database? _database;

  // cek tersedia database
  Future<Database> database() async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // inisiasi database
  Future _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, _databaseName);
    return openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  // create table database
  Future _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE "level" (
      "id_level"	INTEGER NOT NULL,
      "level"	TEXT NOT NULL,
      "permission"	TEXT NOT NULL,
      "create_at"	DATETIME DEFAULT CURRENT_TIMESTAMP,
      "update_at"	DATETIME DEFAULT CURRENT_TIMESTAMP,
      PRIMARY KEY("id_level" AUTOINCREMENT)
    )''');
    await db.execute('''CREATE TABLE "users" (
      "id"	INTEGER NOT NULL,
      "user"	TEXT NOT NULL UNIQUE,
      "password"	TEXT NOT NULL,
      "level"	INTEGER NOT NULL,
      "create_at"	DATETIME DEFAULT CURRENT_TIMESTAMP,
      "update_at"	DATETIME DEFAULT CURRENT_TIMESTAMP,
      PRIMARY KEY("id" AUTOINCREMENT),
      FOREIGN KEY("level") REFERENCES "level"("id_level")
      ); 
    ''');
    await db.execute('''CREATE TABLE "kategori" (
      "id_kategori"	INTEGER NOT NULL,
      "nama"	TEXT NOT NULL UNIQUE,
      "create_at"	DATETIME DEFAULT CURRENT_TIMESTAMP,
      "update_at"	DATETIME DEFAULT CURRENT_TIMESTAMP,
      PRIMARY KEY("id_kategori" AUTOINCREMENT)
      );
    ''');
    await db.execute('''CREATE TABLE "master" (
      "kd_barang"	TEXT NOT NULL,
      "barcode"	TEXT NOT NULL,
      "nama"	TEXT NOT NULL,
      "stock"	INTEGER NOT NULL DEFAULT 0,
      "satuan"	TEXT NOT NULL,
      "harga_beli"	INTEGER NOT NULL,
      "harga_jual"	INTEGER NOT NULL,
      "kategori"	INTEGER NOT NULL,
      "create_at"	DATETIME DEFAULT CURRENT_TIMESTAMP,
      "update_at"	DATETIME DEFAULT CURRENT_TIMESTAMP,
      PRIMARY KEY("kd_barang"),
      FOREIGN KEY("kategori") REFERENCES kategori("id_kategori") ON UPDATE CASCADE
      );
    ''');
    await db.execute('''CREATE TABLE "penjualan"(
      "id_penjualan" TEXT NOT NULL UNIQUE,
      "total_item" INTEGER NOT NULL,
      "subtotal" INTEGER NOT NULL,
      "diskon" INTEGER NOT NULL,
      "jenis_pembayaran" TEXT NOT NULL,
      "user" TEXT NOT NULL,
      "create_at"	DATETIME DEFAULT CURRENT_TIMESTAMP,
      "update_at"	DATETIME DEFAULT CURRENT_TIMESTAMP,
      PRIMARY KEY("id_penjualan")
    );''');
    await db.execute('''CREATE TABLE "detail_penjualan(
      "id_detail_penjualan" INTEGER NOT NULL,
      "id_penjualan" TEXT,
      "kd_barang" TEXT,
      "nama" TEXT,
      "harga_jual" INTEGER,
      "jumlah" INTEGER,
      "diskon" INTEGER,
      "subtotal" INTEGER,
      "create_at"	DATETIME DEFAULT CURRENT_TIMESTAMP,
      "update_at"	DATETIME DEFAULT CURRENT_TIMESTAMP,
      PRIMARY KEY("id_detail_penjualan" AUTOINCREMENT);
    )''');
  }
}
