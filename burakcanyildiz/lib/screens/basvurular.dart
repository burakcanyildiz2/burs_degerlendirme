import 'package:burakcanyildiz/Helpers/Toastr.dart';
import 'package:burakcanyildiz/Helpers/api.dart';
import 'package:burakcanyildiz/Helpers/token.dart';
import 'package:burakcanyildiz/Models/test.dart';
import 'package:burakcanyildiz/Models/user.dart';
import 'package:burakcanyildiz/Widgets/input.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BasvurularScreen extends StatefulWidget {
  const BasvurularScreen({Key key}) : super(key: key);

  @override
  State<BasvurularScreen> createState() => _BasvurularScreenState();
}

class _BasvurularScreenState extends State<BasvurularScreen> {
  Api api = new Api();
  Token token = new Token();
  Toastr toastr = new Toastr();

  List<Test> tests = new List<Test>();

  User user = new User();

  @override
  void initState() {
    GetBasvuranlar();

    super.initState();
  }

  Future<void> GetBasvuranlar() async {
    final id = await token.ReadValue("id");

    final result = await api.GetBasvuranlar(id);

    if (result != null) {
      setState(() {
        tests = result;
      });
    }
  }

  GetUserInfo(id) async {
    final result = await api.GetUserInfo(id);

    if (result != null) {
      setState(() {
        user = result;
      });
      await _showUserInfo(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 30),
              SizedBox(
                  height: 20,
                  child: AkLabel(
                    text: 'Başvurular',
                    size: font.Small(context),
                  )),
              SizedBox(height: 30),
              Expanded(
                  child: ListView.builder(
                      itemCount: tests.length,
                      itemBuilder: (context, i) {
                        return Row(
                          children: [
                            Expanded(
                              child: Container(
                                  padding: EdgeInsets.all(20),
                                  margin: EdgeInsets.only(top: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.orange),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: InkWell(
                                          onTap: () async {
                                            await GetUserInfo(
                                                tests[i].userId.toString());
                                          },
                                          child: Text(tests[i].user.firstName +
                                              " " +
                                              tests[i].user.lastName +
                                              " - Puan: " +
                                              tests[i].puan.toString()),
                                        ),
                                      ),
                                      tests[i].isWon == 0
                                          ? InkWell(
                                              onTap: () async {
                                                final result =
                                                    await api.ChangeTestStatu(
                                                        tests[i].id.toString(),
                                                        "1");

                                                if (result != null) {
                                                  await GetBasvuranlar();
                                                }
                                              },
                                              child: SizedBox(
                                                  width: 70,
                                                  child: Text('Kabul Et',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.green))))
                                          : Container(),
                                      tests[i].isWon == 0
                                          ? InkWell(
                                              onTap: () async {
                                                final result =
                                                    await api.ChangeTestStatu(
                                                        tests[i].id.toString(),
                                                        "2");

                                                if (result != null) {
                                                  await GetBasvuranlar();
                                                }
                                              },
                                              child: SizedBox(
                                                  width: 70,
                                                  child: Text('Reddet',
                                                      style: TextStyle(
                                                          color: Colors.red))))
                                          : Container(),
                                    ],
                                  )),
                            ),
                            SizedBox(
                              child: InkWell(
                                  onTap: () async {
                                    await token.saveValue("testId", tests[i].id.toString());
                                    Navigator.popAndPushNamed(context, "/basvurucevaps");
                                  },
                                  child: Icon(Icons.visibility,size: 30,)),
                            )
                          ],
                        );
                      }))
            ],
          )),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        onTap: (value) {
          if (value == 1) {
            Navigator.popAndPushNamed(context, '/companyburss');
          } else if (value == 2) {
            Navigator.popAndPushNamed(context, '/basvurular');
          } else if (value == 3) {
            Navigator.popAndPushNamed(context, '/kazanankisiler');
          } else {
            Navigator.popAndPushNamed(context, '/companyprofile');
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
              label: "Başvurular",
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.copy),
              label: "Kazanan Kişiler",
              backgroundColor: Colors.black),
        ],
      ),
    );
  }

  Future<void> _showUserInfo(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Bilgi',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: font.Medium(context),
                )),
            content: SizedBox(
              height: MediaQuery.of(context).size.height / 1.35,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    user.pictureUrl != null
                        ? SizedBox(
                            height: 400,
                            child: CachedNetworkImage(
                                imageUrl: "http://212.64.215.42:5005/images/" +
                                    user.pictureUrl))
                        : Container(),
                    SizedBox(height: 15),
                    SizedBox(
                        height: 30,
                        child: Text(
                            'İsim: ' + user.firstName + " " + user.lastName)),
                    SizedBox(height: 15),
                    SizedBox(height: 30, child: Text('TCKN: ' + user.tckn)),
                    SizedBox(height: 15),
                    SizedBox(
                        height: 30,
                        child: Text('Doğum Tarihi: ' + user.birthDate)),
                    SizedBox(height: 15),
                    SizedBox(height: 30, child: Text('E-Posta: ' + user.email)),
                    SizedBox(height: 15),
                    SizedBox(height: 30, child: Text('Telefon: ' + user.phone)),
                    SizedBox(height: 15),
                    SizedBox(height: 30, child: Text('Şehir: ' + user.city)),
                    SizedBox(height: 15),
                    SizedBox(height: 30, child: Text('Okul: ' + user.school)),
                    SizedBox(height: 15),
                    SizedBox(
                        height: 30, child: Text('Bölüm: ' + user.department)),
                    SizedBox(height: 15),
                    SizedBox(
                        height: 30, child: Text('Anne Adı: ' + user.momName)),
                    SizedBox(height: 15),
                    SizedBox(
                        height: 30,
                        child: Text('Baba Adı: ' + user.fatherName)),
                    SizedBox(height: 15),
                    SizedBox(
                        height: 50,
                        child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.orange),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Text('Kapat')))),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
