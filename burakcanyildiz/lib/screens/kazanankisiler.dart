import 'dart:io';

import 'package:burakcanyildiz/Helpers/Toastr.dart';
import 'package:burakcanyildiz/Helpers/api.dart';
import 'package:burakcanyildiz/Helpers/token.dart';
import 'package:burakcanyildiz/Models/test.dart';
import 'package:burakcanyildiz/Widgets/input.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

class KazananKisilerScreen extends StatefulWidget {
  const KazananKisilerScreen({Key key}) : super(key: key);

  @override
  State<KazananKisilerScreen> createState() => _KazananKisilerScreenState();
}

class _KazananKisilerScreenState extends State<KazananKisilerScreen> {
  Api api = new Api();
  Token token = new Token();
  Toastr toastr = new Toastr();

  List<Test> kazananlar = new List<Test>();

  @override
  void initState() {
    GetKazananlar();

    super.initState();
  }

  Future<void> GetKazananlar() async {
    final id = await token.ReadValue("id");

    final result = await api.GetKazananlar(id);

    if (result != null) {
      setState(() {
        kazananlar = result;
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
                    text: 'Kazanan Kişiler',
                    size: font.Small(context),
                  )),
              SizedBox(height: 30),
              Expanded(
                  child: ListView.builder(
                      itemCount: kazananlar.length,
                      itemBuilder: (context, i) {
                        return Container(
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
                                  child: Text(kazananlar[i].user.firstName +
                                      " " +
                                      kazananlar[i].user.lastName +
                                      " - Puan: " +
                                      kazananlar[i].puan.toString()),
                                ),
                                InkWell(
                                    onTap: () async {
                                      final result = await api.ChangeTestStatu(
                                          kazananlar[i].id.toString(), "2");

                                      if (result != null) {
                                        await GetKazananlar();
                                      }
                                    },
                                    child: SizedBox(
                                        width: 75,
                                        child: Text('Reddet',
                                            style:
                                                TextStyle(color: Colors.red))))
                              ],
                            ));
                      })),
              SizedBox(
                  height: 50,
                  child: InkWell(
                    onTap: () async {
                      // TODO: pdf indirilecek

                      // Directory appDocDirectory = await getApplicationDocumentsDirectory();

                      final pdf = pw.Document();

                      pdf.addPage(pw.Page(
                          pageFormat: PdfPageFormat.a4,
                          build: (pw.Context context) {
                            for (var i = 0; i < kazananlar.length; i++) {
                              return pw.Text(kazananlar[i].user.firstName +
                                    " " +
                                    kazananlar[i].user.lastName +
                                    " - Puan: " +
                                    kazananlar[i].puan.toString() +
                                    " - Sehir: " +
                                    kazananlar[i].user.city); // Center
                            }
                          })); // Page

//                         new Directory(appDocDirectory.path+'/'+'dir').create(recursive: true)
// // The created directory is returned as a Future.
//     .then((Directory directory) {
//   print('Path of New Dir: '+directory.path);
// });
                      var status = await Permission.storage.status;
                      if (!status.isGranted) {
                        await Permission.storage.request();
                      }

                      final file =
                          File("/storage/emulated/0/Download/example.pdf");
                      await file.writeAsBytes(await pdf.save());
                      print(file.path);
                    },
                    child: AkButton(
                      size: font.Medium(context),
                      text: 'İndir',
                      isReverse: true,
                    ),
                  ))
            ],
          )),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
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
}
