import 'package:hive/hive.dart';
part 'monster.g.dart';
/*
ini akan di generate oleh build_runner
di terminal : flutter packages pub run build_runner build
*/

@HiveType(typeId: 0)
class Monster {
  @HiveField(0)
  String name;
  @HiveField(1)
  int level;

  Monster(this.name, this.level);
  /*
  agar dapat disimpan dalam hive maka dibuat dulu type adapter nya
  */
}
