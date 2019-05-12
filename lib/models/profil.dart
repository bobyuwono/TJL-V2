import 'package:firebase_database/firebase_database.dart';

class Profil {
  String key;
  String nama;
  String nomorhp;
  String kota;
  String userId;
  String kelas;
  

  Profil(this.nama, this.nomorhp,this.kota,this.userId, this.kelas);

  Profil.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        nama = snapshot.value["nama"],
        nomorhp = snapshot.value["nomorhp"],
        kota = snapshot.value["kota"],
        userId = snapshot.value["userId"],
        kelas= snapshot.value["kelas"];


  toJson() {
    return {
      "nama": nama,
      "nomorhp": nomorhp,
      "kota": kota,
      "kelas": kelas,
    };
  }
}
