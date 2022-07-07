import 'package:burakcanyildiz/screens/basvurdugumburslar.dart';
import 'package:burakcanyildiz/screens/basvurucevaps.dart';
import 'package:burakcanyildiz/screens/basvurular.dart';
import 'package:burakcanyildiz/screens/basvuruyap.dart';
import 'package:burakcanyildiz/screens/burslar.dart';
import 'package:burakcanyildiz/screens/bursver.dart';
import 'package:burakcanyildiz/screens/companyburss.dart';
import 'package:burakcanyildiz/screens/companylogin.dart';
import 'package:burakcanyildiz/screens/companyprofile.dart';
import 'package:burakcanyildiz/screens/kazanankisiler.dart';
import 'package:burakcanyildiz/screens/sonuclar.dart';
import 'package:burakcanyildiz/screens/soruekle.dart';
import 'package:burakcanyildiz/screens/userlogin.dart';
import 'package:burakcanyildiz/screens/userpofile.dart';
import 'package:burakcanyildiz/screens/welcome.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => WelcomeScreen());
      case '/welcome':
        return MaterialPageRoute(builder: (_) => WelcomeScreen());
      case '/userlogin':
        return MaterialPageRoute(builder: (_) => UserLoginScreen());
      case '/companylogin':
        return MaterialPageRoute(builder: (_) => CompanyLoginScreen());
      case '/userprofile':
        return MaterialPageRoute(builder: (_) => UserProfileScreen());
      case '/companyprofile':
        return MaterialPageRoute(builder: (_) => CompanyProfileScreen());
      case '/basvurdugumburslar':
        return MaterialPageRoute(builder: (_) => BasvurdugumBurslarScreen());
      case '/basvurular':
        return MaterialPageRoute(builder: (_) => BasvurularScreen());
      case '/burslar':
        return MaterialPageRoute(builder: (_) => BurslarScreen());
      case '/bursver':
        return MaterialPageRoute(builder: (_) => BursVerScreen());
      case '/kazanankisiler':
        return MaterialPageRoute(builder: (_) => KazananKisilerScreen());
      case '/sonuclar':
        return MaterialPageRoute(builder: (_) => SonuclarScreen());
      case '/soruekle':
        return MaterialPageRoute(builder: (_) => SoruEkleScreen());
      case '/companyburss':
        return MaterialPageRoute(builder: (_) => CompanyBurss());
      case '/basvuruyap':
        return MaterialPageRoute(builder: (_) => BasvuruYapScreen());
      case '/basvurucevaps':
        return MaterialPageRoute(builder: (_) => BasvuruCevapsScreen());
     

      default:
        return _errorRoute(settings.name);
    }
    
  }

  static Route<dynamic> _errorRoute(String r) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Hata Oluştu'),
          actions: <Widget>[
            InkWell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.refresh),
              ),
              onTap: () {
                // _isOnline().then((value) {
                //   if (value) Navigator.pushNamed(_, '/');
                // });
                Navigator.pushNamed(_, '/');
              },
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              r,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 32),
            ),
          ],
        ),
      );
    });
  }
}

class Splash1 {}
