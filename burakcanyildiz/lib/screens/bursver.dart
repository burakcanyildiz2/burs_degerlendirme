import 'package:burakcanyildiz/Helpers/Toastr.dart';
import 'package:burakcanyildiz/Helpers/api.dart';
import 'package:burakcanyildiz/Helpers/token.dart';
import 'package:burakcanyildiz/Models/burs.dart';
import 'package:burakcanyildiz/Models/soru.dart';
import 'package:burakcanyildiz/Widgets/input.dart';
import 'package:flutter/material.dart';

class BursVerScreen extends StatefulWidget {
  const BursVerScreen({Key key}) : super(key: key);

  @override
  State<BursVerScreen> createState() => _BursVerScreenState();
}

class _BursVerScreenState extends State<BursVerScreen> {
  Api api = new Api();
  Token token = new Token();
  Toastr toastr = new Toastr();

  List<Soru> sorular = new List<Soru>();

  TextEditingController bursName = new TextEditingController();
  TextEditingController bursDesc = new TextEditingController();
  TextEditingController kontenjan = new TextEditingController();

  int globursId = 0;

  @override
  void initState() {
    CheckBurs();

    super.initState();
  }

  CheckBurs() async {
    final bursId = await token.ReadValue("bursId");

    if (bursId != null && int.parse(bursId) != 0) {
      // burs görüntüle
      final result = await api.GetBurs(bursId);

      if (result != null) {
        setState(() {
          globursId = result.id;
          bursName.text = result.name;
          bursDesc.text = result.description;
          kontenjan.text = result.kontenjan.toString();
        });

        final result2 = await api.GetSorus(bursId);

        if (result2 != null) {
          setState(() {
            sorular = result2;
          });
        }
      }
    }
  }

  Future<void> BursOlustur() async {
    final id = await token.ReadValue("id");
    final bursId = await token.ReadValue("bursId");
    if (bursId != null) {
      Navigator.popAndPushNamed(context, "/soruekle");
    } else {
      Burs burs = new Burs();

      setState(() {
        burs.id = 0;
        burs.name = bursName.text;
        burs.description = bursDesc.text;
        burs.isShow = 0;
        burs.companyId = int.parse(id);
        burs.kontenjan = int.parse(kontenjan.text);
      });

      final result = await api.BursOlustur(burs);

      if (result != null) {
        await token.saveValue("bursId", result.id.toString());
        toastr.show("Burs Oluşturuldu", true);

        Navigator.popAndPushNamed(context, "/soruekle");
      }
    }
  }

  Future<void> UpdateBurs() async {
    final id = await token.ReadValue("id");
    final bursId = await token.ReadValue("bursId");
    if (bursId != null) {
      Burs burs = new Burs();

      setState(() {
        burs.id = int.parse(bursId);
        burs.name = bursName.text;
        burs.description = bursDesc.text;
        burs.isShow = 1;
        burs.companyId = int.parse(id);
        burs.kontenjan = int.parse(kontenjan.text);
      });

      final result = await api.UpdateBurs(burs);

      if (result != null) {
        await token.saveValue("bursId", result.id.toString());
        toastr.show("Burs Güncellendi", true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 30),
                Row(
                  children: [
                    SizedBox(
                        width: 50,
                        child: InkWell(
                            onTap: () {
                              Navigator.popAndPushNamed(
                                  context, '/companyburss');
                            },
                            child: Icon(Icons.arrow_back))),
                    SizedBox(width: 10),
                    Expanded(
                        flex: 1,
                        child: AkLabel(
                          size: font.Medium(context),
                          text: 'Burs Ver',
                        )),
                  ],
                ),
                SizedBox(height: 10),
                SizedBox(
                    height: 70,
                    child: AkInput(
                      hint: 'Burs Adı',
                      control: bursName,
                      icon: Icons.copy,
                      hideHint: true,
                    )),
                SizedBox(height: 10),
                SizedBox(
                    height: 70,
                    child: AkInput(
                      hint: 'Burs Açıklaması',
                      control: bursDesc,
                      icon: Icons.copy,
                      hideHint: true,
                    )),
                SizedBox(height: 10),
                SizedBox(
                    height: 70,
                    child: AkInput(
                      hint: 'Burs Kontenjan',
                      control: kontenjan,
                      icon: Icons.copy,
                      hideHint: true,
                    )),
                SizedBox(height: 10),
                SizedBox(
                    height: 20,
                    child: AkLabel(
                      size: font.Small(context),
                      text: 'Sorular',
                    )),
                SizedBox(height: 30),
                SizedBox(
                  height: MediaQuery.of(context).size.height - 570,
                  child: ListView.builder(
                      itemCount: sorular.length,
                      itemBuilder: (context, i) {
                        return Container(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.orange),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: AkLabel(
                            size: font.XSmall(context),
                            text: sorular[i].name,
                          ),
                        );
                      }),
                ),
                SizedBox(height: 30),
                SizedBox(
                    height: 50,
                    child: InkWell(
                      onTap: () async {
                        if (bursName.text != null && bursDesc.text != null) {
                          await BursOlustur();
                        } else {
                          toastr.show("Tüm Alanları Doludunuz", false);
                        }
                      },
                      child: AkButton(
                        size: font.Medium(context),
                        text: 'Soru Ekle',
                        isReverse: true,
                      ),
                    )),
                SizedBox(height: 10),
                globursId != null && globursId != 0
                    ? SizedBox(
                        height: 50,
                        child: InkWell(
                          onTap: () async {
                            if (bursName.text != null &&
                                bursDesc.text != null) {
                              await UpdateBurs();
                            } else {
                              toastr.show("Tüm Alanları Doludunuz", false);
                            }
                          },
                          child: AkButton(
                            size: font.Medium(context),
                            text: 'Bursu Kaydet',
                            isReverse: true,
                          ),
                        ))
                    : Container(),
                SizedBox(height: 10),
                globursId != null && globursId != 0
                    ? SizedBox(
                        height: 50,
                        child: InkWell(
                          onTap: () async {
                            final bursId = await token.ReadValue("bursId");

                            final result = await api.BursSonuclandir(bursId);

                            if (result != null) {
                              toastr.show("Burs Sonuçlandırıldı", true);
                            }
                          },
                          child: AkButton(
                            size: font.Medium(context),
                            text: 'Bursu Sonuçlandır',
                            isReverse: true,
                          ),
                        ))
                    : Container(),
              ],
            ),
          )),
    );
  }
}
