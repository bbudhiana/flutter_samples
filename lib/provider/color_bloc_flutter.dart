//import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:flutter/material.dart';

//https://github.com/felangel/bloc/blob/master/packages/hydrated_bloc/README.md

//tentukan eventnya
enum ColorEvent { to_ember, to_light_blue }

//kelas bloc ini memerlukan Event nya apa (color event), State nya (color) apa
//Bloc<SomethingEvent, State>
/// * ini buatan [bana] nilai defaulnya `asik` ini *miring* kalo ini **tebal**
/// contoh :
/// ```
/// final UserProfile profile = UserProfile(
///    name: "nama kamu",
///    role: "peran kamu",
///    photo: "kamu kamu",
/// );
/// ```
//Bloc<event, state>
class ColorBlocFlutter extends Bloc<ColorEvent, Color> with HydratedMixin {
  //DEFAULT NYA BISA DISET KALO BELUM ADA
  //jika menggunakan hydrated,maka gak perlu lagi simpen state nya, akan disimpan otomatis oleh kelas bloc
  //Color _color = Colors.amber;

  //ColorBlocFlutter(Color initialState) : super(initialState);
  ColorBlocFlutter() : super(Colors.amber) {
    //untuk ambil state terakhir dari storage
    hydrate();
  }
  /* ColorBlocFlutter() : super(Colors.amber) {
    super.state ?? Colors.amber;
    hydrate();
  } */

  /* @override
  Color get initialState => super.initialState ?? Colors.amber; */

  //Disinilah letak method untuk menghubungkan event dengan perubahan state nya, state nya dikirim berupa Stream
  @override
  Stream<Color> mapEventToState(ColorEvent event) async* {
    //_color = (event == ColorEvent.to_ember) ? Colors.amber : Colors.lightBlue;
    //yield adalah perintah untuk memasukkan data ke dalam stream, output nya adalah Stream<state>
    yield (event == ColorEvent.to_ember) ? Colors.amber : Colors.lightBlue;
  }

  /*
  Bagian dibawah ini adalah bagian hydrated, yaitu untuk menyimpan state
  Color fromJson : mengembalikan state dari tipe json (Map<String, dynamic>) 
  Map<String, int> toJson : menyimpan state Color saat ini ke json dalam storage
  Color tidak dapat disimpan ke json dalam tipe Color, karenanya gunakan state.value untuk konversi ke integer
  */

  @override
  Color fromJson(Map<String, dynamic> json) {
    try {
      //Color(int value) : create Color dari 32bit int value
      return Color((json['color'] as int));
    } catch (_) {
      //throw UnimplementedError();
      return null;
    }
  }

  //Kenapa tidak Map<String, Color> toJson, karena Color tidak dapat diubah ke json, karenanya harus diubah ke int dulu dari value nya
  @override
  Map<String, int> toJson(Color state) {
    try {
      return {'color': state.value};
    } catch (_) {
      //throw UnimplementedError();
      return null;
    }
  }
}
