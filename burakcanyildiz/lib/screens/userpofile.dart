import 'dart:io';

import 'package:burakcanyildiz/Helpers/Toastr.dart';
import 'package:burakcanyildiz/Helpers/api.dart';
import 'package:burakcanyildiz/Helpers/token.dart';
import 'package:burakcanyildiz/Helpers/uploadApi.dart';
import 'package:burakcanyildiz/Models/user.dart';
import 'package:burakcanyildiz/Widgets/input.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  Api api = new Api();
  UploadApi upApi = new UploadApi();
  Token token = new Token();
  Toastr toastr = new Toastr();

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

  String pictureUrl = "";

  @override
  void initState() {
    GetUser();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(child: _profile()),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (value) {
          if (value == 1) {
            Navigator.popAndPushNamed(context, '/burslar');
          } else if (value == 2) {
            Navigator.popAndPushNamed(context, '/basvurdugumburslar');
          } else if (value == 3) {
            Navigator.popAndPushNamed(context, '/sonuclar');
          } else {
            Navigator.popAndPushNamed(context, '/userprofile');
          }
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profilim",
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.money),
              label: "Burslar",
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.contact_page),
              label: "Başvurduğum Burslar",
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.copy),
              label: "Sonuçlar",
              backgroundColor: Colors.black),
        ],
      ),
    );
  }

  Future<void> GetUser() async {
    final usId = await token.ReadValue("id");

    final result = await api.GetUserInfo(usId);

    if (result != null) {
      setState(() {
        rBirthDate.text = result.birthDate;
        rCity.text = result.city;
        rBolum.text = result.department;
        rEmail.text = result.email;
        rBabaAdi.text = result.fatherName;
        rName.text = result.firstName;
        rLastName.text = result.lastName;
        rAnneAdi.text = result.momName;
        rPassword.text = result.password;
        rPhone.text = result.phone;
        rOkul.text = result.school;
        rTCKN.text = result.tckn;
        pictureUrl = result.pictureUrl;
      });
    }
  }

  Future<void> UpdateProfile() async {
    final usId = await token.ReadValue("id");

    User us = new User();

    setState(() {
      us.id = int.parse(usId);
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

    final result = await api.UpdateUser(us);

    if (result != null) {
      toastr.show("Bilgileriniz Güncellenmiştir", true);
      await GetUser();
    }
  }

  _profile() {
    return Column(
      children: [
        SizedBox(height: 30),
        SizedBox(
          child: AkLabel(text: 'Burs Alan Profili', size: font.Medium(context)),
        ),
        pictureUrl != ""
            ? SizedBox(
                height: 450, child: pictureUrl != null ? CachedNetworkImage(imageUrl: "http://212.64.215.42:5005/images/" + pictureUrl) : Container())
            : Container(),
        SizedBox(height: 30),
        SizedBox(
            height: 30,
            child: InkWell(
                onTap: () async {
                  await _displayTextInputDialog(context);
                },
                child: Text('Resim Yükle',style: TextStyle(fontSize: 25)))),
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
                  await UpdateProfile();
                } else {
                  toastr.show("Tüm Alanları Doldurunuz", false);
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

                Navigator.popAndPushNamed(context, "/welcome");
              },
              child: AkButton(
                size: font.Medium(context),
                text: 'Çıkış Yap',
                isReverse: true,
              ),
            )),
        SizedBox(height: 30),
      ],
    );
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text('Dosya Seçiniz',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            content: SizedBox(
              height: 120,
              child: Column(
                children: [
                  InkWell(
                    onTap: () async {
                      await SelecImage(0);
                    },
                    child: SizedBox(
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        child: Text(
                          'Kamera',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: Colors.orange,
                                width: 2)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () async {
                      await SelecImage(1);
                    },
                    child: SizedBox(
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        child: Text(
                          'Galeri',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: Colors.orange,
                                width: 2)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  ImagePicker _picker = new ImagePicker();
   File _image;

  Future<void> SelecImage(statu) async {
    if (statu == 0) {
      try {
        final PickedFile pFile =
            await _picker.getImage(source: ImageSource.camera);
        setState(() {
          print(pFile.path);
          this._image = File(pFile.path);
        });
      } catch (e) {
        this._image = null;
      }
    } else {
      try {
        final PickedFile pFile =
            await _picker.getImage(source: ImageSource.gallery);
        setState(() {
          this._image = File(pFile.path);
        });
      } catch (e) {
        this._image = null;
      }
    }

    final id = await token.ReadValue("id");

    if (this._image != null) {
      toastr.show('Resim Yükleniyor', true);
      final result = await upApi.UserFile(this._image.path, id);

      if (result != null) {
        if (result == "Ok") {
          toastr.show('Resim Yüklendi', true);
          Navigator.pop(context);
          await GetUser();
        } else if (result != "Error") {
          toastr.show("Bir Sorun Oluştu", false);
        }
      } else {
        toastr.show("Bir Sorun Oluştu", false);
      }
    } else {
      toastr.show("Dosya Seçiniz", false);
    }
  }
}
