import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffectScreen extends StatelessWidget {
  static const routeName = "/shimmer-effect";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shimmer Effect'),
      ),
      body: Center(
        //Untuk implementasi shimmer, install paket shimmer, dan bungkus dengan stack bagian yg hendak di shimmer
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  width: 200,
                  height: 300,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://static.republika.co.id/uploads/images/inpicture_slide/menteri-bumn-erick_200923154807-928.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                //ini yang dibuat effect shimmer nya, shimmer ini butuh gradian, yang membuat efek kilau nya
                Shimmer(
                  //stops ini adalah titik henti, misal Colors.blacks yg 1 titik hentinya 0.4, yang Colors.yellow hentinya di 0.5
                  //titik henti dimaksud adalah titik dimana gradient yg berjalan berhenti
                  //berapa kali terjadi aliran maka menggunakan loop
                  loop: 5,
                  gradient: LinearGradient(
                      /* begin: Alignment.bottomLeft,
                    end: Alignment.topRight, */
                      begin: Alignment(-1, 0.25),
                      end: Alignment(1, -0.25),
                      stops: [
                        0.4,
                        0.5,
                        0.6
                      ],
                      colors: [
                        Colors.white.withOpacity(0),
                        Colors.white.withOpacity(0.5),
                        Colors.white.withOpacity(0),
                      ]),
                  child: Container(
                    width: 200,
                    height: 300,
                    color: Colors.red,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Shimmer(
              direction: ShimmerDirection.btt,
              period: Duration(seconds: 5),
              //berapa kali terjadi aliran maka menggunakan loop
              loop: 2,
              gradient: LinearGradient(
                  begin: Alignment(-1, 0.25),
                  end: Alignment(1, -0.25),
                  stops: [
                    0.4,
                    0.5,
                    0.6
                  ],
                  colors: [
                    Colors.black,
                    Colors.white,
                    Colors.black,
                  ]),
              child: Text(
                'test saja',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
