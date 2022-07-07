import 'package:burakcanyildiz/Models/burs.dart';
import 'package:burakcanyildiz/Models/user.dart';

class Test {
  int id;
  int bursId;
  Burs burs;
  int userId;
  User user;
  int puan;
  int isWon;

  Test({this.id, this.bursId, this.userId, this.puan, this.isWon,this.user,this.burs});

  Test.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bursId = json['bursId'];
    userId = json['userId'];
    puan = json['puan'];
    isWon = json['isWon'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    burs = json['burs'] != null ? Burs.fromJson(json['burs']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bursId'] = this.bursId;
    data['userId'] = this.userId;
    data['puan'] = this.puan;
    data['isWon'] = this.isWon;
    data['burs'] = this.burs;
    data['user'] = this.user;
    return data;
  }
}
