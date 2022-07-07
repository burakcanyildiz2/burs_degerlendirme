import 'package:burakcanyildiz/Helpers/Toastr.dart';
import 'package:burakcanyildiz/Helpers/api.dart';
import 'package:burakcanyildiz/Helpers/token.dart';
import 'package:burakcanyildiz/Models/user.dart';
import 'package:burakcanyildiz/Widgets/input.dart';
import 'package:flutter/material.dart';

class UserLoginScreen extends StatefulWidget {
  const UserLoginScreen({Key key}) : super(key: key);

  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  int pageStatu = 0;

  TextEditingController lEmail = new TextEditingController();
  TextEditingController lPassword = new TextEditingController();

  TextEditingController rName = new TextEditingController();
  TextEditingController rLastName = new TextEditingController();
  TextEditingController rTCKN = new TextEditingController();
  TextEditingController rBirthDate = new TextEditingController();
  TextEditingController rEmail = new TextEditingController();
  TextEditingController rPassword = new TextEditingController();
  TextEditingController rPhone = new TextEditingController();
  TextEditingController rCity = new TextEditingController();
  TextEditingController rOkul = new TextEditingController();
  TextEditingController rBolum = new TextEditingController();
  TextEditingController rAnneAdi = new TextEditingController();
  TextEditingController rBabaAdi = new TextEditingController();

  TextEditingController fEmail = new TextEditingController();

  Api api = new Api();
  Token token = new Token();
  Toastr toastr = new Toastr();

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
                      : _forgotPassword(),),
        ),
      ),
    );
  }

  ForgotPassword() async {
    final result = await api.ForgotPassword(fEmail.text, 0);

    if (result != null) {
      if (result == "yok") {
        toastr.show("Kullanıcı Bulunamadı", false);
      } else {
        toastr.show("Şifreniz Gönderilmiştir", true);
        setState(() {
          this.pageStatu = 0;
        });
      }
    }
  }

  Future<void> UserLogin() async {
    final result = await api.UserLogin(lEmail.text, lPassword.text);

    if (result != null) {
      if (result == "yanlış") {
        toastr.show("Bilgiler Yanlış", false);
      } else {
        toastr.show("Başarıyla Giriş Yaptınız", true);

        await token.saveValue("id", result.id.toString());
        Navigator.popAndPushNamed(context, "/userprofile");
      }
    }
  }

  Future<void> UserRegister() async {
    User us = new User();

    setState(() {
      us.id = 0;
      us.birthDate = rBirthDate.text;
      us.city = rCity.text;
      us.department = rBolum.text;
      us.email = rEmail.text;
      us.fatherName = rBabaAdi.text;
      us.firstName = rName.text;
      us.lastName = rLastName.text;
      us.momName = rAnneAdi.text;
      us.password = rPassword.text;
      us.phone = rPhone.text;
      us.school = rOkul.text;
      us.tckn = rTCKN.text;
    });

    final result = await api.UserRegister(us);

    if (result != null) {
      toastr.show("Başarıyla Üye Oldunuz", true);

      await token.saveValue("id", result.id.toString());
      Navigator.popAndPushNamed(context, "/userprofile");
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
                      text: 'Öğrenci Girişi', size: font.Medium(context))),
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
              hint: 'Şifre',
              icon: Icons.person,
              control: lPassword,
              hideHint: true,
            )),
        SizedBox(height: 30),
        SizedBox(
            height: 50,
            child: InkWell(
              onTap: () async {
                if (this.lEmail.text != null && this.lPassword.text != null) {
                  await UserLogin();
                } else {
                  toastr.show("Tüm Alanları Doldurunuz", false);
                }
              },
              child: AkButton(
                size: font.Medium(context),
                text: 'Giriş Yap',
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
                  text: "Şifremi Unuttum",
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
                child: AkLabel(text: 'Üye Ol', size: font.Small(context)))),
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
                      text: 'Öğrenci Üye Ol', size: font.Medium(context))),
            ],
          ),
        ),
        SizedBox(height: 30),
        SizedBox(
            height: 70,
            child: AkInput(
              hint: 'Adınız',
              icon: Icons.person,
              control: rName,
              hideHint: true,
            )),
        SizedBox(height: 30),
        SizedBox(
            height: 70,
            child: AkInput(
              hint: 'Soyadınız',
              icon: Icons.person,
              control: rLastName,
              hideHint: true,
            )),
        SizedBox(height: 30),
        SizedBox(
            height: 70,
            child: AkInput(
              hint: 'TCKN',
              icon: Icons.confirmation_number,
              control: rTCKN,
              hideHint: true,
            )),
        SizedBox(height: 30),
        SizedBox(
            height: 70,
            child: AkInput(
              hint: 'Doğum Tarihi',
              icon: Icons.calendar_today,
              control: rBirthDate,
              hideHint: true,
            )),
        SizedBox(height: 30),
        SizedBox(
            height: 70,
            child: AkInput(
              hint: 'E-Posta',
              icon: Icons.mail,
              control: rEmail,
              hideHint: true,
            )),
        SizedBox(height: 30),
        SizedBox(
            height: 70,
            child: AkInput(
              hint: 'Şifre',
              icon: Icons.lock,
              control: rPassword,
              hideHint: true,
            )),
        SizedBox(height: 30),
        SizedBox(
            height: 70,
            child: AkInput(
              hint: 'Telefon',
              icon: Icons.phone,
              control: rPhone,
              hideHint: true,
            )),
        SizedBox(height: 30),
        SizedBox(
            height: 70,
            child: AkInput(
              hint: 'Şehir',
              icon: Icons.home,
              control: rCity,
              hideHint: true,
            )),
        SizedBox(height: 30),
        SizedBox(
            height: 70,
            child: AkInput(
              hint: 'Okul',
              icon: Icons.school,
              control: rOkul,
              hideHint: true,
            )),
        SizedBox(height: 30),
        SizedBox(
            height: 70,
            child: AkInput(
              hint: 'Bölüm',
              icon: Icons.school,
              control: rBolum,
              hideHint: true,
            )),
        SizedBox(height: 30),
        SizedBox(
            height: 70,
            child: AkInput(
              hint: 'Anne Adı',
              icon: Icons.pregnant_woman_rounded,
              control: rAnneAdi,
              hideHint: true,
            )),
        SizedBox(height: 30),
        SizedBox(
            height: 70,
            child: AkInput(
              hint: 'Baba Adı',
              icon: Icons.person,
              control: rBabaAdi,
              hideHint: true,
            )),
        SizedBox(height: 30),
        SizedBox(
            height: 50,
            child: InkWell(
              onTap: () async {
                if (rBirthDate.text != null &&
                    rCity.text != null &&
                    rBolum.text != null &&
                    rEmail.text != null &&
                    rBabaAdi.text != null &&
                    rName.text != null &&
                    rLastName.text != null &&
                    rAnneAdi.text != null &&
                    rPassword.text != null &&
                    rPhone.text != null &&
                    rOkul.text != null &&
                    rTCKN.text != null) {
                  await UserRegister();
                } else {
                  toastr.show("Tüm Alanları Doldurunuz", false);
                }
              },
              child: AkButton(
                size: font.Medium(context),
                text: 'Üye Ol',
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
                child: AkLabel(text: 'Giriş Yap', size: font.Small(context)))),
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
                      text: 'Öğrenci Girişi', size: font.Medium(context))),
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
                text: 'Şifremi Gönder',
              ),
            )),
        SizedBox(height: 30),
      ],
    );
  }
}
