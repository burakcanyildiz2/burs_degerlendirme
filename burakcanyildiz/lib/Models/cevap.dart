import 'package:burakcanyildiz/Models/soru.dart';

class Cevap {
  int id;
  int soruId;
  Soru soru;
  String name;
  int puan;

  Cevap({this.id, this.soruId,this.soru,this.name,this.puan});

  Cevap.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    soruId = json['soruId'];
    soru = json['soru'] != null ? Soru.fromJson(json['soru']) : null;
    name = json['name'];
    puan = json['puan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['soruId'] = this.soruId;
    data['soru'] = this.soru;
    data['name'] = this.name;
    data['puan'] = this.puan;
    return data;
  }
}
