import 'package:burakcanyildiz/Helpers/Toastr.dart';
import 'package:burakcanyildiz/Helpers/api.dart';
import 'package:burakcanyildiz/Helpers/token.dart';
import 'package:burakcanyildiz/Models/cevap.dart';
import 'package:burakcanyildiz/Models/soru.dart';
import 'package:burakcanyildiz/Widgets/input.dart';
import 'package:flutter/material.dart';

class SoruEkleScreen extends StatefulWidget {
  const SoruEkleScreen({Key key}) : super(key: key);

  @override
  State<SoruEkleScreen> createState() => _SoruEkleScreenState();
}

class _SoruEkleScreenState extends State<SoruEkleScreen> {
  Api api = new Api();
  Token token = new Token();
  Toastr toastr = new Toastr();

  List<Cevap> cevaplar = new List<Cevap>();

  TextEditingController soruName = new TextEditingController();

  Future<void> SoruOlustur() async {
    final bursId = await token.ReadValue("bursId");
    // soruları ve cevapları oluştur
    Soru soru = new Soru();

    setState(() {
      soru.bursId = int.parse(bursId);
      soru.id = 0;
      soru.name = soruName.text;
    });

    final result = await api.SoruOlustur(soru);

    if (result != null) {
      for (var i = 0; i < cevaplar.length; i++) {
        setState(() {
          cevaplar[i].id = 0;
          cevaplar[i].soruId = result.id;
        });
      }

      final result2 = await api.CevapOlustur(cevaplar);

      if (result2 != null) {
        toastr.show("Soru Ve Cevaplar Oluşturuldu", true);

        Navigator.popAndPushNamed(context, '/companyburss');
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
              SizedBox(
                  height: 30,
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.popAndPushNamed(context, '/bursver');
                          },
                          child: Icon(Icons.arrow_back)),
                      AkLabel(
                        size: font.Medium(context),
                        text: 'Soru Ekle',
                      ),
                    ],
                  )),
              SizedBox(height: 15),
              SizedBox(
                  height: 100,
                  child: AkInput(
                    hint: 'Soru Başlığı',
                    icon: Icons.question_answer,
                    control: soruName,
                  )),
              SizedBox(height: 15),
              SizedBox(
                  height: 30,
                  child: AkLabel(
                    size: font.Small(context),
                    text: 'Cevaplar',
                  )),
              SizedBox(height: 15),
              SizedBox(
                height: MediaQuery.of(context).size.height - 420,
                child: ListView.builder(
                    itemCount: cevaplar.length,
                    itemBuilder: (context, i) {
                      return Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(5),
                                margin: EdgeInsets.only(top: 10, bottom: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.orange),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) {
                                    setState(() {
                                      cevaplar[i].name = value;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    counterText: '',
                                    hintText: 'Seçenek',
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(fontSize: 17),
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(5),
                                margin: EdgeInsets.only(top: 10, bottom: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.orange),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) {
                                    setState(() {
                                      cevaplar[i].puan = int.parse(value);
                                    });
                                  },
                                  decoration: InputDecoration(
                                    counterText: '',
                                    hintText: 'Puan',
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(fontSize: 17),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
              SizedBox(height: 15),
              SizedBox(
                  height: 50,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        Cevap cev = new Cevap();

                        this.cevaplar.add(cev);
                      });
                    },
                    child: AkButton(
                      size: font.Small(context),
                      text: 'Seçenek Ekle',
                    ),
                  )),
              SizedBox(height: 30),
              SizedBox(
                  height: 50,
                  child: InkWell(
                    onTap: () async {
                      await SoruOlustur();
                    },
                    child: AkButton(
                      size: font.Small(context),
                      text: 'Soru Oluştur',
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
