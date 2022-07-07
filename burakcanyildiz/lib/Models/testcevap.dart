import 'package:burakcanyildiz/Models/cevap.dart';
import 'package:burakcanyildiz/Models/soru.dart';
import 'package:burakcanyildiz/Models/test.dart';
import 'package:burakcanyildiz/Models/user.dart';

class TestCevap {
  int id;
  int userId;
  User user;
  int testId;
  Test test;
  int cevapId;
  Cevap cevap;
  int soruId;
  Soru soru;

  TestCevap(
      {this.id,
      this.userId,
      this.user,
      this.testId,
      this.test,
      this.cevapId,
      this.cevap,
      this.soruId,
      this.soru});

  TestCevap.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    testId = json['testId'];
    test = json['test'] != null ? Test.fromJson(json['test']) : null;
    cevapId = json['cevapId'];
    cevap = json['cevap'] != null ? Cevap.fromJson(json['cevap']) : null;
    soruId = json['soruId'];
    soru = json['soru'] != null ? Soru.fromJson(json['soru']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cevapId'] = this.cevapId;
    data['cevap'] = this.cevap;
    data['testId'] = this.testId;
    data['test'] = this.test;
    data['userId'] = this.userId;
    data['user'] = this.user;
    data['soruId'] = this.soruId;
    data['soru'] = this.soru;
    return data;
  }
}
