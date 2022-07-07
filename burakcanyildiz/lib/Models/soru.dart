
import 'package:burakcanyildiz/Models/burs.dart';

class Soru {
  int id;
  int bursId;
  Burs burs;
  String name;

  Soru({this.id, this.bursId, this.burs, this.name});

  Soru.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bursId = json['bursId'];
    burs = json['company'] != null ? Burs.fromJson(json['burs']) : null;
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bursId'] = this.bursId;
    data['burs'] = this.burs;
    data['name'] = this.name;
    return data;
  }
}
