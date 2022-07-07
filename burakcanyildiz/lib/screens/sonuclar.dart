import 'package:burakcanyildiz/Helpers/Toastr.dart';
import 'package:burakcanyildiz/Helpers/api.dart';
import 'package:burakcanyildiz/Helpers/token.dart';
import 'package:burakcanyildiz/Models/test.dart';
import 'package:burakcanyildiz/Widgets/input.dart';
import 'package:flutter/material.dart';

class SonuclarScreen extends StatefulWidget {
  const SonuclarScreen({Key key}) : super(key: key);

  @override
  State<SonuclarScreen> createState() => _SonuclarScreenState();
}

class _SonuclarScreenState extends State<SonuclarScreen> {
  Api api = new Api();
  Token token = new Token();
  Toastr toastr = new Toastr();

  List<Test> tests = new List<Test>();

  @override
  void initState() {
    GetUserTests();

    super.initState();
  }

  Future<void> GetUserTests() async {
    final id = await token.ReadValue("id");

    final result = await api.GetSonuclar(id);

    if (result != null) {
      setState(() {
        tests = result;
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
              child: AkLabel(
                text: 'Sonuçlar',
                size: font.Small(context),
              )),
          SizedBox(height: 30),
          Expanded(
              child: ListView.builder(
                  itemCount: tests.length,
                  itemBuilder: (context, i) {
                    return Container(
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.orange),
                            borderRadius: BorderRadius.circular(30),
                            color: tests[i].isWon == 1
                                ? Colors.green
                                : tests[i].isWon == 2
                                    ? Colors.red
                                    : Colors.transparent),
                        child: Text(tests[i].burs.name +
                            " - Puan: " +
                            tests[i].puan.toString() +
                            " - " +
                            (tests[i].isWon == 0
                                ? "Açıklanmadı"
                                : tests[i].isWon == 1
                                    ? 'Bursu Kazandınız'
                                    : 'Bursu Kazanamadınız')));
                  }))
        ],
      )),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
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
}
