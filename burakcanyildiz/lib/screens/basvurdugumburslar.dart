import 'package:burakcanyildiz/Helpers/Toastr.dart';
import 'package:burakcanyildiz/Helpers/api.dart';
import 'package:burakcanyildiz/Helpers/token.dart';
import 'package:burakcanyildiz/Models/burs.dart';
import 'package:burakcanyildiz/Models/test.dart';
import 'package:burakcanyildiz/Widgets/input.dart';
import 'package:flutter/material.dart';

class BasvurdugumBurslarScreen extends StatefulWidget {
  const BasvurdugumBurslarScreen({Key key}) : super(key: key);

  @override
  State<BasvurdugumBurslarScreen> createState() =>
      _BasvurdugumBurslarScreenState();
}

class _BasvurdugumBurslarScreenState extends State<BasvurdugumBurslarScreen> {
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

    final result = await api.GetUserTests(id);

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
                    text: 'Başvurduğum Burslar',
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
                            ),
                            child: Text(tests[i].burs.name +
                                " - Puan: " +
                                tests[i].puan.toString()));
                      }))
            ],
          )),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
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
