//YANG DIPERLUKAN ADALAH BUAT KELAS OBSERVER dan KELAS ACTION nya
//DEFENDENCY : mobx
import 'package:mobx/mobx.dart';

//kasih info bahwa counter.g.dart adalah bagian dari kelas ini
part 'counter.g.dart';

//buat kelas countermobx nya bisa digunakan
//kelas CounterMobx adalah turunan dari _CounterMobx kemudian implement dengan _$CounterMobx
//si _$CounterMobx yang implement akan di generate oleh build_runner
//di terminal : flutter packages pub run build_runner build
class CounterMobx = _CounterMobx with _$CounterMobx;

//mixin Store (punya nya mobx_codegen)
abstract class _CounterMobx with Store {
  //kasih annotation @observable (value adalah nilai yg di obser)
  @observable
  int value = 0;

  //method increment dan decrement ini yang disebut dengan action
  //kasih annotation @action agar ketika di generate build_runner dapat dibaca
  //akan di generate build_runner dengan nama counter.g.dart
  @action
  void increment() {
    value++;
  }

  @action
  void decrement() {
    value--;
  }
}
