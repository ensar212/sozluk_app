import 'package:flutter/material.dart';
import 'package:sozluk_project/DAO/KelimeDAO.dart';
import 'package:sozluk_project/sayfa_tasarimlari/KelimeDetay.dart';

import '../db/Kelime.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  
  Future<List<Kelime>> KelimeListele () async {
    var kelimeListele = await KelimeDAO().tumKelimeler();
    return kelimeListele;
  }

  Future<List<Kelime>> kelimeAra (String AraKelime) async{
    var kelimeAra = await KelimeDAO().kelimeAra(AraKelime);
    return kelimeAra;
  } 

  @override
  void initState() {
  super.initState();
  KelimeListele();
  }
  
  

  bool aramaYapiliyorMu = false;
  String KelimeARA = "";
  
  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.of(context);
    final double ekranGenisligi = ekranBilgisi.size.width;
    final double ekranYuksekligi = ekranBilgisi.size.height;
    return Scaffold(
      appBar: AppBar(centerTitle: true,
        title: aramaYapiliyorMu? TextField(onChanged: (AraKelime) {
          setState(() {
            KelimeARA = AraKelime;
          });
        },):Text("SÖZLÜK DÜNYASI"),
       actions: [
        IconButton(onPressed: (){
          setState(() {
            aramaYapiliyorMu =!aramaYapiliyorMu;
          });
        }, icon: aramaYapiliyorMu ? Icon(Icons.cancel): Icon(Icons.search)),
       ],     
      ),
      body: FutureBuilder<List<Kelime>> (
        future:aramaYapiliyorMu? kelimeAra(KelimeARA): KelimeListele(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var kelimeListesi = snapshot.data;
            return ListView.builder(
              itemCount:kelimeListesi!.length,
              itemBuilder: (context, index) {
                var kelime = kelimeListesi[index];
                return CardKelime(kelime, ekranGenisligi, ekranYuksekligi);
              },
              );
          } else {
            return Center();
            }
        }, 
        ),

      
    );
  }
}

class CardKelime extends StatelessWidget { 
  
   Kelime kelime;
   final double ekranGenisligi;
    final double ekranYuksekligi;
   CardKelime(this.kelime, this.ekranGenisligi,this.ekranYuksekligi);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: () {
      Navigator.push(context, MaterialPageRoute(builder:  (context) => KelimeDetay(kelime),));
    },
      child: Card(elevation: 2,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:SizedBox(height: 40,width: ekranGenisligi /3.3,
              child: Text(kelime.TR,textAlign: TextAlign.center,)),
            ),
            SizedBox(height:40,width: ekranGenisligi /3.3,
              child: Icon(Icons.arrow_forward_ios_sharp)),
            SizedBox(height: 40,width: ekranGenisligi /3.3,
              child: Text(kelime.EN,textAlign: TextAlign.center,)),
            
          ],
        ),
      ),
    );
  }
}


