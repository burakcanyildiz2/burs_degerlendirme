import 'package:burakcanyildiz/Helpers/Toastr.dart';
import 'package:burakcanyildiz/Helpers/api.dart';
import 'package:burakcanyildiz/Helpers/token.dart';
import 'package:burakcanyildiz/Models/company.dart';
import 'package:burakcanyildiz/Widgets/input.dart';
import 'package:flutter/material.dart';

class CompanyLoginScreen extends StatefulWidget {
  const CompanyLoginScreen({Key key}) : super(key: key);

  @override
  State<CompanyLoginScreen> createState() => _CompanyLoginScreenState();
}

class _CompanyLoginScreenState extends State<CompanyLoginScreen> {
  int pageStatu = 0;
  int companyStatu = 0;

  Api api = new Api();
  Token token = new Token();
  Toastr toastr = new Toastr();

  TextEditingController lEmail = new TextEditingController();
  TextEditingController lPassword = new TextEditingController();

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

  TextEditingController fEmail = new TextEditingController();

  Company com = new Company();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
              child: pageStatu == 0
                  ? _login()
                  : pageStatu == 1
                      ? _register()
                      : _forgotPassword()),
        ),
      ),
    );
  }

  ForgotPassword() async {
    final result = await api.ForgotPassword(fEmail.text, 1);

    if (result != null) {
      if (result == "yok") {
        toastr.show("Kullan??c?? Bulunamad??", false);
      } else {
        toastr.show("??ifreniz G??nderilmi??tir", true);
        setState(() {
          this.pageStatu = 0;
        });
      }
    }
  }

  Future<void> CompanyLogin() async {
    final result = await api.CompanyLogin(lEmail.text, lPassword.text);

    if (result != null) {
      if (result == "yanl????") {
        toastr.show("Bilgiler Yanl????", false);
      } else {
        toastr.show("Ba??ar??yla Giri?? Yap??ld??", true);

        await token.saveValue("id", result.id.toString());
        await token.saveValue("isCompany", "1");
        Navigator.popAndPushNamed(context, "/companyprofile");
      }
    }
  }

  Future<void> CompanyRegister() async {
    final result = await api.CompanyRegister(com);

    if (result != null) {
      if (result == "var") {
        toastr.show("Bilgilere Ait Kullan??c?? Var", false);
      } else {
        toastr.show("Ba??ar??yla ??ye Oldunuz", true);
        await token.saveValue("id", result.id.toString());
        await token.saveValue("isCompany", "1");

        Navigator.popAndPushNamed(context, "/companyprofile");
      }
    }
  }

  _login() {
    return Column(
      children: [
        SizedBox(height: 30),
        SizedBox(
          child: Row(
            children: [
              SizedBox(
                  width: 50,
                  child: InkWell(
                      onTap: () {
                        Navigator.popAndPushNamed(context, '/welcome');
                      },
                      child: Icon(Icons.arrow_back))),
              Expanded(
                  flex: 1,
                  child: AkLabel(
                      text: 'Burs Veren Giri??i', size: font.Medium(context))),
            ],
          ),
        ),
        SizedBox(height: 30),
        SizedBox(
            height: 70,
            child: AkInput(
              hint: 'E-Mail',
              icon: Icons.person,
              control: lEmail,
              hideHint: true,
            )),
        SizedBox(height: 30),
        SizedBox(
            height: 70,
            child: AkInput(
              hint: '??ifre',
              icon: Icons.person,
              control: lPassword,
              hideHint: true,
            )),
        SizedBox(height: 30),
        SizedBox(
            height: 50,
            child: InkWell(
              onTap: () async {
                if (lEmail.text != null && lPassword.text != null) {
                  await CompanyLogin();
                } else {
                  toastr.show("T??m Alanlar?? Doldurunuz", false);
                }
              },
              child: AkButton(
                size: font.Medium(context),
                text: 'Giri?? Yap',
              ),
            )),
        SizedBox(height: 30),
        SizedBox(
            height: 20,
            child: InkWell(
                onTap: () async {
                  setState(() {
                    this.pageStatu = 2;
                  });
                },
                child: AkLabel(
                  size: font.XSmall(context),
                  text: "??ifremi Unuttum",
                ))),
        SizedBox(height: 30),
        SizedBox(
            height: 30,
            child: InkWell(
                onTap: () {
                  // Navigator.popAndPushNamed(context, '/userlogin');
                  setState(() {
                    this.pageStatu = 1;
                  });
                },
                child: AkLabel(text: '??ye Ol', size: font.Small(context)))),
        SizedBox(height: 30),
      ],
    );
  }

  _register() {
    return Column(
      children: [
        SizedBox(height: 30),
        SizedBox(
          child: Row(
            children: [
              SizedBox(
                  width: 50,
                  child: InkWell(
                      onTap: () {
                        Navigator.popAndPushNamed(context, '/welcome');
                      },
                      child: Icon(Icons.arrow_back))),
              Expanded(
                  flex: 1,
                  child: AkLabel(
                      text: 'Burs Veren ??ye Ol', size: font.Medium(context))),
            ],
          ),
        ),
        SizedBox(height: 30),
        SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width - 40,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        this.companyStatu = 0;
                      });
                    },
                    child: AkButton(
                      size: font.Small(context),
                      text: "Kurum",
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        this.companyStatu = 1;
                      });
                    },
                    child: AkButton(
                      size: font.Small(context),
                      text: "Ki??i",
                    ),
                  ),
                ),
              ],
            )),
        SizedBox(height: 30),
        Visibility(
          visible: companyStatu == 0,
          child: Column(
            children: [
              SizedBox(
                  height: 70,
                  child: AkInput(
                    hint: 'Kurum Ad??',
                    icon: Icons.person,
                    control: rCompanyName,
                    hideHint: true,
                  )),
              SizedBox(height: 30),
              SizedBox(
                  height: 70,
                  child: AkInput(
                    hint: 'Kurumun ??li',
                    control: rCity,
                    icon: Icons.person,
                    hideHint: true,
                  )),
              SizedBox(height: 30),
              SizedBox(
                  height: 70,
                  child: AkInput(
                    hint: 'Hizmet Alan??',
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
                    hint: '??ifre',
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
                    hint: '??sim',
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
                    hint: 'Do??um Tarihi',
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
                    hint: '??ifre',
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
                    hint: '??ehir',
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
                if (companyStatu == 0) {
                  // ki??iyse
                  if (rCompanyName.text != null &&
                      rCity.text != null &&
                      rServiceLane.text != null &&
                      rEmail.text != null &&
                      rPassword.text != null) {
                    setState(() {
                      com.id = 0;
                      com.isCompany = true;
                      com.companyName = rCompanyName.text;
                      com.city = rCity.text;
                      com.serviceLane = rServiceLane.text;
                      com.email = rEmail.text;
                      com.password = rPassword.text;

                      com.firstName = '';
                      com.lastName = '';
                      com.tckn = '';
                      com.birthDate = '';
                      com.phone = '';
                    });
                    await CompanyRegister();
                  } else {
                    toastr.show("T??m Alanlar?? Doldurunuz", false);
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
                      com.id = 0;
                      com.isCompany = false;
                      com.firstName = rName.text;
                      com.lastName = rLastName.text;
                      com.tckn = rTCKN.text;
                      com.birthDate = rBirthDate.text;
                      com.email = rEmail.text;
                      com.password = rPassword.text;
                      com.phone = rPhone.text;
                      com.city = rCity.text;

                      com.companyName = '';
                      com.serviceLane = '';
                    });
                    await CompanyRegister();
                  } else {
                    toastr.show("T??m Alanlar?? Doldurunuz", false);
                  }
                }
              },
              child: AkButton(
                size: font.Medium(context),
                text: '??ye Ol',
              ),
            )),
        SizedBox(height: 30),
        SizedBox(
            height: 30,
            child: InkWell(
                onTap: () {
                  // Navigator.popAndPushNamed(context, '/userlogin');
                  setState(() {
                    this.pageStatu = 0;
                  });
                },
                child: AkLabel(text: 'Giri?? Yap', size: font.Small(context)))),
        SizedBox(height: 30),
      ],
    );
  }

  _forgotPassword() {
    return Column(
      children: [
        SizedBox(height: 30),
        SizedBox(
          child: Row(
            children: [
              SizedBox(
                  width: 50,
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          this.pageStatu = 0;
                        });
                      },
                      child: Icon(Icons.arrow_back))),
              Expanded(
                  flex: 1,
                  child: AkLabel(
                      text: 'Burs Veren Giri??i', size: font.Medium(context))),
            ],
          ),
        ),
        SizedBox(height: 30),
        SizedBox(
            height: 70,
            child: AkInput(
              hint: 'E-Mail',
              icon: Icons.person,
              control: fEmail,
              hideHint: true,
            )),
        SizedBox(height: 30),
        SizedBox(
            height: 50,
            child: InkWell(
              onTap: () async {
                if (this.fEmail.text.isNotEmpty) {
                  await ForgotPassword();
                } else {
                  toastr.show("E-Mail Adresinizi Giriniz", false);
                }
              },
              child: AkButton(
                size: font.Medium(context),
                text: '??ifremi G??nder',
              ),
            )),
        SizedBox(height: 30),
      ],
    );
  }
}
