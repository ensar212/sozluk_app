import 'package:sozluk_project/db/DatabaseHelper.dart';
import 'package:sozluk_project/db/Kelime.dart';

class KelimeDAO {
  
  Future<List<Kelime>> tumKelimeler() async { //Tüm kelimeleri getiren method
    
    var db = await DatabaseHelper.databaseErisim(); //Veritabanına artık erişiyoruz.

    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM sozluk");
    return List.generate(maps.length, (index){
      var satir = maps[index];
      var id = satir["ID"];
      var tr = satir["TR"];
      var en = satir["EN"];
      var url = satir["URL"];
      return Kelime(id, tr, en, url);
    });
  }
  Future<List<Kelime>> kelimeAra (String aramaKelime) async {
    var db = await DatabaseHelper.databaseErisim();
    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM sozluk WHERE TR LIKE '%$aramaKelime%' OR EN LIKE '%$aramaKelime%'",);
    return List.generate(maps.length, (index) {

      var satir = maps[index];
      var id = satir["ID"];
      var tr = satir["TR"];
      var en = satir["EN"];
      var url = satir["URL"];
      return Kelime(id, tr, en, url);
    });

  }
  }
