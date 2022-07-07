import 'package:burakcanyildiz/Helpers/Toastr.dart';
import 'package:burakcanyildiz/Helpers/api.dart';
import 'package:burakcanyildiz/Helpers/token.dart';
import 'package:burakcanyildiz/Models/company.dart';
import 'package:burakcanyildiz/Widgets/input.dart';
import 'package:flutter/material.dart';

class CompanyProfileScreen extends StatefulWidget {
  const CompanyProfileScreen({Key key}) : super(key: key);

  @override
  State<CompanyProfileScreen> createState() => _CompanyProfileScreenState();
}

class _CompanyProfileScreenState extends State<CompanyProfileScreen> {
  int companyStatu = 0;

  Api api = new Api();
  Token token = new Token();
  Toastr toastr = new Toastr();

  Company com = new Company();

  TextEditingController rCompanyName = new TextEditingController();
  TextEditingController rCity = new TextEditingController();
  TextEditingController rServiceLane = new TextEditingController();
  TextEditingController rEmail = new TextEditingController();
  TextEditingController rPassword = new TextEditingController();

  TextEditingController rName = new TextEditingController();
  TextEditingController rLastName = new TextEditingController();
  TextEditingController rTCKN = new TextEditingController();
  TextEditingController rBirthDate = new TextEditingController();
  TextEditingController rPhone = new TextEditingController();

  @override
  void initState() {
    GetCompanyInfo();

    super.initState();
  }

  Future<void> UpdateCompany() async {
    setState(() {
      com.companyName = rCompanyName.text;
      com.city = rCity.text;
      com.serviceLane = rServiceLane.text;
      com.email = rEmail.text;
      com.password = rPassword.text;

      com.isCompany = companyStatu == 0 ? true : false;

      com.firstName = rName.text;
      com.lastName = rLastName.text;
      com.tckn = rTCKN.text;
      com.birthDate = rBirthDate.text;
      com.phone = rPhone.text;
    });

    final result = await api.UpdateCompany(com);

    if (result != null) {
      toastr.show("Profiliniz Güncelledi", true);

      await GetCompanyInfo();
    }
  }

  Future<void> GetCompanyInfo() async {
    final id = await token.ReadValue("id");

    final result = await api.GetCompanyInfo(id);

    if (result != null) {
      setState(() {
        rCompanyName.text = result.companyName;
        rCity.text = result.city;
        rServiceLane.text = result.serviceLane;
        rEmail.text = result.email;
        rPassword.text = result.password;

        if (result.isCompany == true) {
          companyStatu = 0;
        } else {
          companyStatu = 1;
        }

        rName.text = result.firstName;
        rLastName.text = result.lastName;
        rTCKN.text = result.tckn;
        rBirthDate.text = result.birthDate;
        rPhone.text = result.phone;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
              child: Column(
            children: [
              SizedBox(height: 30),
              SizedBox(
                child: AkLabel(text: 'Burs Veren Profili', size: font.Medium(context)),
              ),
              SizedBox(height: 30),
              Visibility(
                visible: companyStatu == 0,
                child: Column(
                  children: [
                    SizedBox(
                        height: 70,
                        child: AkInput(
                          hint: 'Kurum Adı',
                          icon: Icons.person,
                          control: rCompanyName,
                          hideHint: true,
                        )),
                    SizedBox(height: 30),
                    SizedBox(
                        height: 70,
                        child: AkInput(
                          hint: 'Kurumun İli',
                          control: rCity,
                          icon: Icons.person,
                          hideHint: true,
                        )),
                    SizedBox(height: 30),
                    SizedBox(
                        height: 70,
                        child: AkInput(
                          hint: 'Hizmet Alanı',
                          control: rServiceLane,
                          icon: Icons.confirmation_number,
                          hideHint: true,
                        )),
                    SizedBox(height: 30),
                    SizedBox(
                        height: 70,
                        child: AkInput(
                          hint: 'Kurum E-Posta',
                          control: rEmail,
                          icon: Icons.calendar_today,
                          hideHint: true,
                        )),
                    SizedBox(height: 30),
                    SizedBox(
                        height: 70,
                        child: AkInput(
                          hint: 'Şifre',
                          control: rPassword,
                          icon: Icons.mail,
                          hideHint: true,
                        )),
                    SizedBox(height: 30),
                  ],
                ),
              ),
              Visibility(
                visible: companyStatu == 1,
                child: Column(
                  children: [
                    SizedBox(
                        height: 70,
                        child: AkInput(
                          hint: 'İsim',
                          icon: Icons.lock,
                          control: rName,
                          hideHint: true,
                        )),
                    SizedBox(height: 30),
                    SizedBox(
                        height: 70,
                        child: AkInput(
                          hint: 'Soyisim',
                          icon: Icons.phone,
                          control: rLastName,
                          hideHint: true,
                        )),
                    SizedBox(height: 30),
                    SizedBox(
                        height: 70,
                        child: AkInput(
                          hint: 'TCKN',
                          icon: Icons.home,
                          control: rTCKN,
                          hideHint: true,
                        )),
                    SizedBox(height: 30),
                    SizedBox(
                        height: 70,
                        child: AkInput(
                          hint: 'Doğum Tarihi',
                          control: rBirthDate,
                          icon: Icons.school,
                          hideHint: true,
                        )),
                    SizedBox(height: 30),
                    SizedBox(
                        height: 70,
                        child: AkInput(
                          hint: 'E-Posta',
                          control: rEmail,
                          icon: Icons.school,
                          hideHint: true,
                        )),
                    SizedBox(height: 30),
                    SizedBox(
                        height: 70,
                        child: AkInput(
                          hint: 'Şifre',
                          icon: Icons.pregnant_woman_rounded,
                          control: rPassword,
                          hideHint: true,
                        )),
                    SizedBox(height: 30),
                    SizedBox(
                        height: 70,
                        child: AkInput(
                          hint: 'Telefon',
                          icon: Icons.person,
                          control: rPhone,
                          hideHint: true,
                        )),
                    SizedBox(height: 30),
                    SizedBox(
                        height: 70,
                        child: AkInput(
                          hint: 'Şehir',
                          icon: Icons.person,
                          control: rCity,
                          hideHint: true,
                        )),
                    SizedBox(height: 30),
                  ],
                ),
              ),
              SizedBox(
                  height: 50,
                  child: InkWell(
                    onTap: () async {
                      final id = await token.ReadValue("id");
                      if (companyStatu == 0) {
                        // kişiyse
                        if (rCompanyName.text != null &&
                            rCity.text != null &&
                            rServiceLane.text != null &&
                            rEmail.text != null &&
                            rPassword.text != null) {
                          setState(() {
                            com.id = int.parse(id);
                            com.companyName = rCompanyName.text;
                            com.city = rCity.text;
                            com.serviceLane = rServiceLane.text;
                            com.email = rEmail.text;
                            com.password = rPassword.text;
                          });
                          await UpdateCompany();
                        } else {
                          toastr.show("Tüm Alanları Doldurunuz", false);
                        }
                      } else {
                        // kurumsa
                        if (rName.text != null &&
                            rLastName.text != null &&
                            rTCKN.text != null &&
                            rBirthDate.text != null &&
                            rEmail.text != null &&
                            rPassword.text != null) {
                          setState(() {
                            com.id = int.parse(id);
                            com.firstName = rName.text;
                            com.lastName = rLastName.text;
                            com.tckn = rTCKN.text;
                            com.birthDate = rBirthDate.text;
                            com.email = rEmail.text;
                            com.password = rPassword.text;
                            com.phone = rPhone.text;
                            com.city = rCity.text;
                          });
                          await UpdateCompany();
                        } else {
                          toastr.show("Tüm Alanları Doldurunuz", false);
                        }
                      }
                    },
                    child: AkButton(
                      size: font.Medium(context),
                      text: 'Güncelle',
                    ),
                  )),
              SizedBox(height: 30),
              SizedBox(
                  height: 50,
                  child: InkWell(
                    onTap: () async {
                      await token.deleteToken("id");
                      await token.deleteToken("isCompany");

                      toastr.show("Çıkış Yapıldı", true);

                      Navigator.popAndPushNamed(context, '/welcome');
                    },
                    child: AkButton(
                      size: font.Medium(context),
                      text: 'Çıkış Yap',
                      isReverse: true,
                    ),
                  )),
            ],
          )),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (value) {
          if (value == 1) {
            Navigator.popAndPushNamed(context, '/companyburss');
          }
          else if (value == 2) {
            Navigator.popAndPushNamed(context, '/basvurular');
          }
          else if (value == 3) {
            Navigator.popAndPushNamed(context, '/kazanankisiler');
          }
          else {
            Navigator.popAndPushNamed(context, '/companyprofile');
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profilim",backgroundColor: Colors.black),
          BottomNavigationBarItem(icon: Icon(Icons.money), label: "Burslar",backgroundColor: Colors.black),
          BottomNavigationBarItem(icon: Icon(Icons.contact_page), label: "Başvurdular",backgroundColor: Colors.black),
          BottomNavigationBarItem(icon: Icon(Icons.copy), label: "Kazanan Kişiler",backgroundColor: Colors.black),
        ],
      ),
    );
  }
}
