import 'package:burakcanyildiz/Helpers/Toastr.dart';
import 'package:burakcanyildiz/Helpers/api.dart';
import 'package:burakcanyildiz/Helpers/token.dart';
import 'package:burakcanyildiz/Models/testcevap.dart';
import 'package:burakcanyildiz/Widgets/input.dart';
import 'package:flutter/material.dart';

class BasvuruCevapsScreen extends StatefulWidget {
  const BasvuruCevapsScreen({Key key}) : super(key: key);

  @override
  State<BasvuruCevapsScreen> createState() => _BasvuruCevapsScreenState();
}

class _BasvuruCevapsScreenState extends State<BasvuruCevapsScreen> {
  Api api = new Api();
  Token token = new Token();
  Toastr toastr = new Toastr();

  List<TestCevap> cevaps = new List<TestCevap>();

  @override
  void initState() {
    GetCevaps();

    super.initState();
  }

  GetCevaps() async {
    final usId = await token.ReadValue("id");
    final testId = await token.ReadValue("testId");

    final result = await api.GetTestCevaps(usId, testId);

    if (result != null) {
      setState(() {
        cevaps = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.popAndPushNamed(context, '/basvurular');
      },
      child: Scaffold(
        body: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(height: 30),
                Row(
                  children: [
                    SizedBox(
                        width: 50,
                        child: InkWell(
                            onTap: () {
                              Navigator.popAndPushNamed(context, '/basvurular');
                            },
                            child: Icon(Icons.arrow_back))),
                    SizedBox(width: 30),
                    Expanded(
                        flex: 1,
                        child: AkLabel(
                          size: font.Medium(context),
                          text: 'Cevaplar',
                        )),
                  ],
                ),
                SizedBox(height: 30),
                SizedBox(
                  height: 100,
                  child: AkLabel(
                      size: font.Small(context),
                      text: cevaps.length >= 1
                          ? cevaps[0].user.firstName +
                              " " +
                              cevaps[0].user.lastName +
                              " İsimli Öğrencinin Cevapları"
                          : "Hata Oluştu"),
                ),
                SizedBox(height: 30),
                Expanded(
                    flex: 1,
                    child: ListView.builder(
                        itemCount: cevaps.length,
                        itemBuilder: (context, i) {
                          return Container(
                            padding: EdgeInsets.all(20),
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.orange),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 30,
                                    child: Text(
                                      cevaps[i].soru.name,
                                      style: TextStyle(
                                          fontSize: font.XSmall(context)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    child: Text(
                                      "Cevap: " + cevaps[i].cevap.name,
                                      style: TextStyle(
                                          fontSize: font.XSmall(context)),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  SizedBox(
                                    height: 30,
                                    child: Text(
                                      cevaps[i].cevap.puan.toString() + " Puan",
                                      style: TextStyle(
                                          fontSize: font.XSmall(context)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }))
              ],
            )),
      ),
    );
  }
}
