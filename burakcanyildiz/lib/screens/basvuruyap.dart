import 'package:burakcanyildiz/Helpers/Toastr.dart';
import 'package:burakcanyildiz/Helpers/api.dart';
import 'package:burakcanyildiz/Helpers/token.dart';
import 'package:burakcanyildiz/Models/burs.dart';
import 'package:burakcanyildiz/Models/cevap.dart';
import 'package:burakcanyildiz/Models/soru.dart';
import 'package:burakcanyildiz/Models/test.dart';
import 'package:burakcanyildiz/Models/testcevap.dart';
import 'package:burakcanyildiz/Widgets/input.dart';
import 'package:flutter/material.dart';

class BasvuruYapScreen extends StatefulWidget {
  const BasvuruYapScreen({Key key}) : super(key: key);

  @override
  State<BasvuruYapScreen> createState() => _BasvuruYapScreenState();
}

class _BasvuruYapScreenState extends State<BasvuruYapScreen> {
  Api api = new Api();
  Token token = new Token();
  Toastr toastr = new Toastr();

  List<Soru> sorular = new List<Soru>();
  List<Cevap> cevaplar = new List<Cevap>();

  String bursName = "";
  String soruName = "";

  int soruIndex = 0;
  int point = 0;

  Burs burs = new Burs();
  List<TestCevap> testcevaps = new List<TestCevap>();

  @override
  void initState() {
    GetSorus();
    GetBursInfo();

    super.initState();
  }

  GetBursInfo() async {
    final bursId = await token.ReadValue("bursId");

    final result = await api.GetBurs(bursId);

    if (result != null) {
      setState(() {
        burs = result;
      });
    }
  }

  GetSorus() async {
    final bursId = await token.ReadValue("bursId");

    final result = await api.GetSorus(bursId);

    if (result != null) {
      setState(() {
        sorular = result;
      });

      final result2 = await api.GetCevaps(sorular[soruIndex].id.toString());

      if (result2 != null) {
        setState(() {
          cevaplar = result2;
        });
      }
    }
  }

  GetCevaps() async {
    final result = await api.GetCevaps(sorular[soruIndex].id.toString());

    if (result != null) {
      setState(() {
        cevaplar = result;
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
                  height: 50,
                  child: AkLabel(
                      text: sorular != null && sorular[soruIndex].name != null
                          ? sorular[soruIndex].name
                          : 'Soru Başlığı',
                      size: font.Small(context))),
              SizedBox(height: 30),
              Expanded(
                flex: 1,
                child: cevaplar != null && cevaplar.length >= 1
                    ? ListView.builder(
                        itemCount: cevaplar.length,
                        itemBuilder: (context, i) {
                          return InkWell(
                            onTap: () async {
                              final usId = await token.ReadValue("id");
                              point += cevaplar[i].puan;
                              TestCevap cevap = new TestCevap();
                              setState(() {
                                cevap.id = 0;
                                cevap.cevapId = cevaplar[i].id;
                                cevap.userId = int.parse(usId);
                                cevap.soruId = sorular[soruIndex].id;
                                testcevaps.add(cevap);
                              });
                              if (soruIndex == sorular.length - 1) {
                                // sınav tamamlandı
                                final usId = await token.ReadValue("id");
                                final bursId = await token.ReadValue("bursId");
                                Test test = new Test();
                                setState(() {
                                  test.bursId = int.parse(bursId);
                                  test.id = 0;
                                  test.isWon = 0;
                                  test.puan = point;
                                  test.userId = int.parse(usId);
                                });

                                final result = await api.CreateTest(test);

                                if (result != null) {
                                  for (var i = 0; i < testcevaps.length; i++) {
                                    setState(() {
                                      testcevaps[i].testId = result.id;
                                    });
                                  }

                                  final result2 =
                                      await api.CreateTestCevaps(testcevaps);

                                  if (result2 != null) {
                                    toastr.show("Başvurunuz Alınmıştır", true);
                                    Navigator.popAndPushNamed(
                                        context, '/burslar');
                                  }
                                }
                              } else {
                                setState(() {
                                  soruIndex++;
                                });
                                await GetCevaps();
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(20),
                              margin: EdgeInsets.only(top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.orange),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(cevaplar[i].name),
                            ),
                          );
                        })
                    : Container(),
              ),
            ],
          )),
    );
  }
}
