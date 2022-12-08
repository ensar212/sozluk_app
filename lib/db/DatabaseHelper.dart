import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  
  static final String databaseName = "sozluk.sqlite";

  static Future<Database> databaseErisim () async {

    String databaseYolu = join(await getDatabasesPath(), databaseName);

    if (await databaseExists(databaseYolu)) {
      print("DB zaten var. Kopyalamaya gerek yok");
    } else{ //veritabanı yok hadi oluşturalım
      ByteData data = await rootBundle.load("veritabani_dosya/$databaseName");

      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      
      await File(databaseYolu).writeAsBytes(bytes, flush: true);
      print("DB oluştu");
    }
      return openDatabase(databaseYolu);
  }
}