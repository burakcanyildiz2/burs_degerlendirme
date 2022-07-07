import 'package:burakcanyildiz/Helpers/Toastr.dart';
import 'package:burakcanyildiz/Helpers/api.dart';
import 'package:burakcanyildiz/Helpers/token.dart';
import 'package:burakcanyildiz/Models/burs.dart';
import 'package:burakcanyildiz/Widgets/input.dart';
import 'package:flutter/material.dart';

class BurslarScreen extends StatefulWidget {
  const BurslarScreen({Key key}) : super(key: key);

  @override
  State<BurslarScreen> createState() => _BurslarScreenState();
}

class _BurslarScreenState extends State<BurslarScreen> {
  Api api = new Api();
  Token token = new Token();
  Toastr toastr = new Toastr();

  List<Burs> burss = new List<Burs>();

  @override
  void initState() {
    GetBurss();

    super.initState();
  }

  Future<void> GetBurss() async {
    final usId = await token.ReadValue("id");
    final result = await api.GetBurss(usId);

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
                  child: AkLabel(
                    text: 'Burslar',
                    size: font.Small(context),
                  )),
              SizedBox(height: 30),
              Expanded(
                flex: 1,
                  child: ListView.builder(
                      itemCount: burss.length,
                      itemBuilder: (context, i) {
                        return Container(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.orange),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: InkWell(
                              onTap: () async {
                                await token.saveValue(
                                    "bursId", burss[i].id.toString());

                                Navigator.popAndPushNamed(
                                    context, '/basvuruyap');
                              },
                              child: Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 30,
                                      child: Text(
                                        burss[i].name,
                                        style: TextStyle(
                                            fontSize: font.Small(context)),
                                      ),
                                    ),
                                    burss[i].description != null
                                              ?  Expanded(
                                      flex: 1,
                                      child: Text( 
                                          burss[i].description,
                                          style: TextStyle(
                                              fontSize: font.XSmall(context))),
                                    ) : Expanded(
                                      flex: 1,
                                      child: Text(
                                          '',
                                          style: TextStyle(
                                              fontSize: font.XSmall(context))),
                                    ),
                                  ],
                                ),
                              )),
                        );
                      }))
            ],
          )),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
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
