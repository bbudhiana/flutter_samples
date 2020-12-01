import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'model/monster.dart';

class HiveScreen extends StatelessWidget {
  static const routeName = '/hive-screen';

  /*
  Sekilas tentang Hive :
  - database local seperti misal sqlite
  - no native dependency
  - gampang
  - ringan
  - kinerja tinggi, lebih bagus dari sqlite dan share preferences

  Hive : terdiri banyak box
  box  : menyimpan banyak data merupakan pasangan key=>value dan hanya string dan integer, juga List, Map, dan DateTime
  Untuk simpan kelas buatan sendiri : kita harus convert ke json baru masukin ke hive, juga bisa pake TypeAdapter
  All data stored in Hive is organized in boxes. A box can be compared to a table in SQL, but it does not have a structure and can contain anything

  Create data : use add(value),
  Retrieve data : use getAt(index),
  Update data : use putAt(index),
  Delete data: use deleteAt(index)
  Untuk rebuild UI ketika ada value yg berubah dalam box, maka gunakan WatchBoxBuilder (deprecated)
  diganti oleh ValueListenableBuilder

  SUMBER : https://docs.hivedb.dev/#/
  */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hive - Database Lokal'),
      ),
      body: FutureBuilder(
        //openBox kira-kira sama dengan open table
        future: Hive.openBox("monsters"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error),
              );
            } else {
              //ambil data nya dengan cara Hive.box(nama_data)
              var monstersBox = Hive.box("monsters");
              if (monstersBox.length == 0) {
                monstersBox.add(Monster('vampire', 1));
                monstersBox.add(Monster('dracula', 4));
              }
              return ValueListenableBuilder(
                //ValueListenableBuilder mendeteksi, jika ada perubahan box maka rebuild kembali
                //valueListenable: Hive.box("monsters").listenable(),
                valueListenable: monstersBox.listenable(),
                //box : box yg di listen yaitu "monsters", child : kalo ada widget tambahan (masuk sebagai ch)
                child: Text('your monster : '),
                builder: (context, box, ch) => Container(
                  margin: EdgeInsets.all(20),
                  child: ListView.builder(
                    //itemCount: monstersBox.length,
                    itemCount: box.length,
                    itemBuilder: (context, index) {
                      Monster monster = box.getAt(index);
                      return Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              offset: Offset(3, 3),
                              blurRadius: 6,
                            )
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ch,
                            Text(monster.name +
                                "[" +
                                monster.level.toString() +
                                "]"),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.trending_up,
                                  ),
                                  color: Colors.green,
                                  onPressed: () {
                                    //monstersBox.putAt(index,Monster(monster.name, monster.level + 1));
                                    box.putAt(
                                        index,
                                        Monster(
                                            monster.name, monster.level + 1));
                                  },
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.content_copy,
                                  ),
                                  color: Colors.amber,
                                  onPressed: () {
                                    //monstersBox.add(Monster(monster.name, monster.level));
                                    box.add(
                                        Monster(monster.name, monster.level));
                                  },
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                  ),
                                  color: Colors.red,
                                  onPressed: () {
                                    //monstersBox.deleteAt(index);
                                    box.deleteAt(index);
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
            }
          } else {
            //jika masih loading maka tampilkan loading
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
