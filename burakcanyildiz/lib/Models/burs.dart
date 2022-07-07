import 'package:burakcanyildiz/Models/company.dart';

class Burs {
  int id;
  int companyId;
  Company company;
  String name;
  String description;
  int isShow;
  int kontenjan;

  Burs({this.id, this.companyId, this.company, this.name, this.description,this.isShow,this.kontenjan});

  Burs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['companyId'];
    company =
        json['company'] != null ? Company.fromJson(json['company']) : null;
    name = json['name'];
    description = json['description'];
    isShow = json['isShow'];
    kontenjan = json['kontenjan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['companyId'] = this.companyId;
    data['company'] = this.company;
    data['name'] = this.name;
    data['description'] = this.description;
    data['isShow'] = this.isShow;
    data['kontenjan'] = this.kontenjan;
    return data;
  }
}
