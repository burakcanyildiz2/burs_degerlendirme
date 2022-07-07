import 'package:burakcanyildiz/Helpers/Toastr.dart';
import 'package:burakcanyildiz/Helpers/api.dart';
import 'package:burakcanyildiz/Helpers/token.dart';
import 'package:burakcanyildiz/Models/burs.dart';
import 'package:burakcanyildiz/Widgets/input.dart';
import 'package:flutter/material.dart';

class CompanyBurss extends StatefulWidget {
  const CompanyBurss({Key key}) : super(key: key);

  @override
  State<CompanyBurss> createState() => _CompanyBurssState();
}

class _CompanyBurssState extends State<CompanyBurss> {
  Api api = new Api();
  Token token = new Token();
  Toastr toastr = new Toastr();

  List<Burs> burss = new List<Burs>();

  @override
  void initState() {
    GetCompanyBurss();

    super.initState();
  }

  Future<void> GetCompanyBurss() async {
    await token.deleteToken("bursId");
    final id = await token.ReadValue("id");

    final result = await api.GetCompanyBurss(id);

    if (result != null) {
      setState(() {
        burss = result;
      });
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
                  child: Row(
                    children: [
                      Expanded(
                        child: AkLabel(
                          text: 'Burslarım',
                          size: font.Small(context),
                        ),
                      ),
                      SizedBox(
                          width: 60,
                          height: 20,
                          child: InkWell(
                              onTap: () async {
                                Navigator.popAndPushNamed(context, '/bursver');
                              },
                              child: Icon(
                                Icons.add,
                                size: 30,
                              ))),
                    ],
                  )),
              SizedBox(height: 30),
              Expanded(
                  child: ListView.builder(
                      itemCount: burss.length,
                      itemBuilder: (context, i) {
                        return Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () async {
                                  await token.saveValue(
                                      "bursId", burss[i].id.toString());
                                  Navigator.popAndPushNamed(
                                      context, '/bursver');
                                },
                                child: Container(
                                    padding: EdgeInsets.all(20),
                                    margin:
                                        EdgeInsets.only(top: 10, bottom: 10),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.orange),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Text(burss[i].name)),
                              ),
                            ),
                            SizedBox(
                              width: 10, 
                            ),
                            SizedBox(
                              child: InkWell(
                                  onTap: () async {
                                    final result = await api.ChangeBursShown(
                                        burss[i].id.toString(),
                                        burss[i].isShow == 1 ? "0" : "1");

                                    if (result != null) {
                                      await GetCompanyBurss();
                                    }
                                  },
                                  child: Icon(burss[i].isShow == 1
                                      ? Icons.visibility_off
                                      : Icons.visibility,size: 30,)),
                            )
                          ],
                        );
                      }))
            ],
          )),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
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
              label: "Başvurdular",
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.copy),
              label: "Kazanan Kişiler",
              backgroundColor: Colors.black),
        ],
      ),
    );
  }
}
