class Company {
  int id;
  String companyName;
  String city;
  String serviceLane;
  String email;
  String password;
  String firstName;
  String lastName;
  String tckn;
  String birthDate;
  String phone;
  bool isCompany;

  Company(
      {this.id,
      this.companyName,
      this.city,
      this.serviceLane,
      this.email,
      this.password,
      this.firstName,
      this.lastName,
      this.tckn,
      this.birthDate,
      this.phone,
      this.isCompany});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['companyName'];
    city = json['city'];
    serviceLane = json['serviceLane'];
    email = json['email'];
    password = json['password'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    tckn = json['tckn'];
    birthDate = json['birthDate'];
    phone = json['phone'];
    isCompany = json['isCompany'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['companyName'] = this.companyName;
    data['city'] = this.city;
    data['serviceLane'] = this.serviceLane;
    data['email'] = this.email;
    data['password'] = this.password;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['tckn'] = this.tckn;
    data['birthDate'] = this.birthDate;
    data['phone'] = this.phone;
    data['isCompany'] = this.isCompany;
    return data;
  }
}
