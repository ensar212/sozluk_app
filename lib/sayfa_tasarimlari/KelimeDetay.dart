import 'package:flutter/material.dart';
import 'package:sozluk_project/db/Kelime.dart';

class KelimeDetay extends StatefulWidget {
  Kelime kelime;
  KelimeDetay(this.kelime);

  @override
  State<KelimeDetay> createState() => _KelimeDetayState();
}

class _KelimeDetayState extends State<KelimeDetay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 300, height: 300,
              child: ClipRRect(borderRadius: BorderRadius.circular(150),
              child: FadeInImage.assetNetwork(placeholder: "resimler/image.png", image: widget.kelime.URL ),
              ),
            ),
            Text(widget.kelime.EN,style: 
            TextStyle(fontSize: 35,)),
            Text(widget.kelime.TR,style: 
            TextStyle(fontSize: 28,),),
            
          ],
        ),
      ),
    );
  }
}