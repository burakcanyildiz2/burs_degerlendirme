class User {
  int id;
  String firstName;
  String lastName;
  String tckn;
  String pictureUrl;
  String birthDate;
  String password;
  String email;
  String phone;
  String city;
  String school;
  String department;
  String momName;
  String fatherName;

  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.tckn,
      this.pictureUrl,
      this.birthDate,
      this.password,
      this.email,
      this.phone,
      this.city,
      this.school,
      this.department,
      this.momName,
      this.fatherName});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    tckn = json['tckn'];
    pictureUrl = json['pictureUrl'];
    birthDate = json['birthDate'];
    password = json['password'];
    email = json['email'];
    phone = json['phone'];
    city = json['city'];
    school = json['school'];
    department = json['department'];
    momName = json['momName'];
    fatherName = json['fatherName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['tckn'] = this.tckn;
    data['pictureUrl'] = this.pictureUrl;
    data['birthDate'] = this.birthDate;
    data['password'] = this.password;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['city'] = this.city;
    data['school'] = this.school;
    data['department'] = this.department;
    data['momName'] = this.momName;
    data['fatherName'] = this.fatherName;
    return data;
  }
}
