// import 'dart:convert';
// import 'dart:io';
import 'dart:convert';
import 'dart:io';

import 'package:burakcanyildiz/Models/burs.dart';
import 'package:burakcanyildiz/Models/cevap.dart';
import 'package:burakcanyildiz/Models/company.dart';
import 'package:burakcanyildiz/Models/soru.dart';
import 'package:burakcanyildiz/Models/test.dart';
import 'package:burakcanyildiz/Models/testcevap.dart';
import 'package:burakcanyildiz/Models/user.dart';

import 'toastr.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

import 'token.dart';

class Api {
  // static const baseUrl = "http://212.64.215.42:5005/api";
  static const baseUrl = "http://192.168.1.105:5005/api";
  static const uploadUrl = "http://212.64.215.42:5005/images/";
  Toastr toastr = new Toastr();

  UserLogin(String email, String password) async {
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);

      return http.get(
          Uri.parse(baseUrl +
              '/System/UserLogin?email=' +
              email +
              '&password=' +
              password),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            // HttpHeaders.authorizationHeader: 'Bearer ' + await GetToken(),
          }).then((data) {
        if (data.statusCode == 200) {
          User c = User.fromJson(jsonDecode(data.body));
          return c;
        }
        if (data.statusCode == 400 && data.body == "yanlış") {
          return "yanlış";
        }
        return null;
      });
    } catch (e) {
      print(e);
    }
  }

  CompanyLogin(String email, String password) async {
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);

      return http.get(
          Uri.parse(baseUrl +
              '/System/CompanyLogin?email=' +
              email +
              '&password=' +
              password),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            // HttpHeaders.authorizationHeader: 'Bearer ' + await GetToken(),
          }).then((data) {
        if (data.statusCode == 200) {
          Company c = Company.fromJson(jsonDecode(data.body));
          return c;
        }
        if (data.statusCode == 400 && data.body == "yanlış") {
          return "yanlış";
        }
        return null;
      });
    } catch (e) {
      print(e);
    }
  }

  UserRegister(User dto) async {
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    print(json.encode(dto.toJson()));
    return http
        .post(Uri.parse(baseUrl + '/System/UserRegister'),
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
            },
            body: json.encode(dto.toJson()))
        .then((data) {
      if (data.statusCode == 401) {
        toastr.show("Lütfen Giriş Yapınız.", false);
        return null;
      }
      if (data.statusCode == 200) {
        User c = User.fromJson(jsonDecode(data.body));
        return c;
      } else if (data.statusCode != 200 && data.body == "var") {
        return "var";
      }
      return null;
    });
  }

  CompanyRegister(Company dto) async {
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    print(json.encode(dto.toJson()));
    return http
        .post(Uri.parse(baseUrl + '/System/CompanyRegister'),
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
            },
            body: json.encode(dto.toJson()))
        .then((data) {
      if (data.statusCode == 401) {
        toastr.show("Lütfen Giriş Yapınız.", false);
        return null;
      }
      if (data.statusCode == 200) {
        Company c = Company.fromJson(jsonDecode(data.body));
        return c;
      } else if (data.statusCode != 200 && data.body == "var") {
        return "var";
      }
      return null;
    });
  }

  UpdateUser(User dto) async {
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    print(json.encode(dto.toJson()));
    return http
        .post(Uri.parse(baseUrl + '/System/UpdateUser'),
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
            },
            body: json.encode(dto.toJson()))
        .then((data) {
      if (data.statusCode == 401) {
        toastr.show("Lütfen Giriş Yapınız.", false);
        return null;
      }
      if (data.statusCode == 200) {
        User c = User.fromJson(jsonDecode(data.body));
        return c;
      } else if (data.statusCode != 200 && data.body == "var") {
        return "var";
      }
      return null;
    });
  }

  UpdateCompany(Company dto) async {
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    print(json.encode(dto.toJson()));
    return http
        .post(Uri.parse(baseUrl + '/System/UpdateCompany'),
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
            },
            body: json.encode(dto.toJson()))
        .then((data) {
      if (data.statusCode == 401) {
        toastr.show("Lütfen Giriş Yapınız.", false);
        return null;
      }
      if (data.statusCode == 200) {
        Company c = Company.fromJson(jsonDecode(data.body));
        return c;
      } else if (data.statusCode != 200 && data.body == "var") {
        return "var";
      }
      return null;
    });
  }

  GetUserInfo(id) async {
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);

      return http
          .get(Uri.parse(baseUrl + '/System/GetUserInfo?id=' + id), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        // HttpHeaders.authorizationHeader: 'Bearer ' + await GetToken(),
      }).then((data) {
        if (data.statusCode == 200) {
          User c = User.fromJson(jsonDecode(data.body));
          return c;
        }
        if (data.statusCode == 400 && data.body == "yanlış") {
          return "yanlış";
        }
        return null;
      });
    } catch (e) {
      print(e);
    }
  }

  GetCompanyInfo(id) async {
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);

      return http.get(Uri.parse(baseUrl + '/System/GetCompanyInfo?id=' + id),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            // HttpHeaders.authorizationHeader: 'Bearer ' + await GetToken(),
          }).then((data) {
        if (data.statusCode == 200) {
          Company c = Company.fromJson(jsonDecode(data.body));
          return c;
        }
        if (data.statusCode == 400 && data.body == "yanlış") {
          return "yanlış";
        }
        return null;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<List<Burs>> GetBurss(userId) async {
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);

    return http.get(Uri.parse(baseUrl + '/System/GetBurss?userId=' + userId), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    }).then((data) {
      if (data.statusCode == 200) {
        var datas = new List<Burs>();
        Iterable list = json.decode(data.body);
        datas = list.map((model) => Burs.fromJson(model)).toList();
        return datas;
      }
      if (data.statusCode == 401) {
        toastr.show("Lütfen Giriş Yapınız.", false);
        return null;
      }
      return null;
    });
  }

  Future<List<Test>> GetUserTests(id) async {
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);

    return http
        .get(Uri.parse(baseUrl + '/System/GetUserTests?id=' + id), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    }).then((data) {
      if (data.statusCode == 200) {
        var datas = new List<Test>();
        Iterable list = json.decode(data.body);
        datas = list.map((model) => Test.fromJson(model)).toList();
        return datas;
      }
      if (data.statusCode == 401) {
        toastr.show("Lütfen Giriş Yapınız.", false);
        return null;
      }
      return null;
    });
  }

  Future<List<Test>> GetSonuclar(id) async {
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);

    return http
        .get(Uri.parse(baseUrl + '/System/GetUserTests?id=' + id), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    }).then((data) {
      if (data.statusCode == 200) {
        var datas = new List<Test>();
        Iterable list = json.decode(data.body);
        datas = list.map((model) => Test.fromJson(model)).toList();
        return datas;
      }
      if (data.statusCode == 401) {
        toastr.show("Lütfen Giriş Yapınız.", false);
        return null;
      }
      return null;
    });
  }

  Future<List<Test>> GetBasvuranlar(id) async {
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);

    return http.get(
        Uri.parse(baseUrl + '/System/GetBasvuranlar?companyId=' + id),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        }).then((data) {
      if (data.statusCode == 200) {
        var datas = new List<Test>();
        Iterable list = json.decode(data.body);
        datas = list.map((model) => Test.fromJson(model)).toList();
        return datas;
      }
      if (data.statusCode == 401) {
        toastr.show("Lütfen Giriş Yapınız.", false);
        return null;
      }
      return null;
    });
  }

  Future<List<Test>> GetKazananlar(id) async {
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);

    return http.get(
        Uri.parse(baseUrl + '/System/GetKazananlar?companyId=' + id),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        }).then((data) {
      if (data.statusCode == 200) {
        var datas = new List<Test>();
        Iterable list = json.decode(data.body);
        datas = list.map((model) => Test.fromJson(model)).toList();
        return datas;
      }
      if (data.statusCode == 401) {
        toastr.show("Lütfen Giriş Yapınız.", false);
        return null;
      }
      return null;
    });
  }

  Future<List<Burs>> GetCompanyBurss(id) async {
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);

    return http.get(
        Uri.parse(baseUrl + '/System/GetCompanyBurss?companyId=' + id),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        }).then((data) {
      if (data.statusCode == 200) {
        var datas = new List<Burs>();
        Iterable list = json.decode(data.body);
        datas = list.map((model) => Burs.fromJson(model)).toList();
        return datas;
      }
      if (data.statusCode == 401) {
        toastr.show("Lütfen Giriş Yapınız.", false);
        return null;
      }
      return null;
    });
  }

  BursOlustur(Burs dto) async {
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    print(json.encode(dto.toJson()));
    return http
        .post(Uri.parse(baseUrl + '/System/CreateBurs'),
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
            },
            body: json.encode(dto.toJson()))
        .then((data) {
      if (data.statusCode == 401) {
        toastr.show("Lütfen Giriş Yapınız.", false);
        return null;
      }
      if (data.statusCode == 200) {
        Burs c = Burs.fromJson(jsonDecode(data.body));
        return c;
      } else if (data.statusCode != 200 && data.body == "var") {
        return "var";
      }
      return null;
    });
  }


  UpdateBurs(Burs dto) async {
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    print(json.encode(dto.toJson()));
    return http
        .post(Uri.parse(baseUrl + '/System/UpdateBurs'),
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
            },
            body: json.encode(dto.toJson()))
        .then((data) {
      if (data.statusCode == 401) {
        toastr.show("Lütfen Giriş Yapınız.", false);
        return null;
      }
      if (data.statusCode == 200) {
        Burs c = Burs.fromJson(jsonDecode(data.body));
        return c;
      } else if (data.statusCode != 200 && data.body == "var") {
        return "var";
      }
      return null;
    });
  }

  SoruOlustur(Soru dto) async {
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    print(json.encode(dto.toJson()));
    return http
        .post(Uri.parse(baseUrl + '/System/CreateSoru'),
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
            },
            body: json.encode(dto.toJson()))
        .then((data) {
      if (data.statusCode == 401) {
        toastr.show("Lütfen Giriş Yapınız.", false);
        return null;
      }
      if (data.statusCode == 200) {
        Soru c = Soru.fromJson(jsonDecode(data.body));
        return c;
      } else if (data.statusCode != 200 && data.body == "var") {
        return "var";
      }
      return null;
    });
  }

  CevapOlustur(List<Cevap> dto) async {
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);

    List jsonList = [];
    dto.map((item) => jsonList.add(item.toJson())).toList();

    return http
        .post(Uri.parse(baseUrl + '/System/CreateCevap'),
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
            },
            body: json.encode({"finalResponse": jsonList}["finalResponse"]))
        .then((data) {
      if (data.statusCode == 401) {
        toastr.show("Lütfen Giriş Yapınız.", false);
        return null;
      }
      if (data.statusCode == 200) {
        var datas = new List<Cevap>();
        Iterable list = json.decode(data.body);
        datas = list.map((model) => Cevap.fromJson(model)).toList();
        return datas;
      } else if (data.statusCode != 200 && data.body == "var") {
        return "var";
      }
      return null;
    });
  }

  GetBurs(id) async {
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);

      return http
          .get(Uri.parse(baseUrl + '/System/GetBurs?id=' + id), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        // HttpHeaders.authorizationHeader: 'Bearer ' + await GetToken(),
      }).then((data) {
        if (data.statusCode == 200) {
          Burs c = Burs.fromJson(jsonDecode(data.body));
          return c;
        }
        if (data.statusCode == 400 && data.body == "yanlış") {
          return "yanlış";
        }
        return null;
      });
    } catch (e) {
      print(e);
    }
  }

  GetSorus(id) async {
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);

      return http
          .get(Uri.parse(baseUrl + '/System/GetSorus?bursId=' + id), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        // HttpHeaders.authorizationHeader: 'Bearer ' + await GetToken(),
      }).then((data) {
        if (data.statusCode == 200) {
          var datas = new List<Soru>();
          Iterable list = json.decode(data.body);
          datas = list.map((model) => Soru.fromJson(model)).toList();
          return datas;
        }
        if (data.statusCode == 400 && data.body == "yanlış") {
          return "yanlış";
        }
        return null;
      });
    } catch (e) {
      print(e);
    }
  }

  GetCevaps(id) async {
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);

      return http
          .get(Uri.parse(baseUrl + '/System/GetCevaps?soruId=' + id), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        // HttpHeaders.authorizationHeader: 'Bearer ' + await GetToken(),
      }).then((data) {
        if (data.statusCode == 200) {
          var datas = new List<Cevap>();
          Iterable list = json.decode(data.body);
          datas = list.map((model) => Cevap.fromJson(model)).toList();
          return datas;
        }
        if (data.statusCode == 400 && data.body == "yanlış") {
          return "yanlış";
        }
        return null;
      });
    } catch (e) {
      print(e);
    }
  }

  CreateTest(Test dto) async {
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    print(json.encode(dto.toJson()));
    return http
        .post(Uri.parse(baseUrl + '/System/CreateTest'),
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
            },
            body: json.encode(dto.toJson()))
        .then((data) {
      if (data.statusCode == 401) {
        toastr.show("Lütfen Giriş Yapınız.", false);
        return null;
      }
      if (data.statusCode == 200) {
        Test c = Test.fromJson(jsonDecode(data.body));
        return c;
      } else if (data.statusCode != 200 && data.body == "var") {
        return "var";
      }
      return null;
    });
  }

  ChangeTestStatu(testId, statu) async {
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);

      return http.get(
          Uri.parse(baseUrl +
              '/System/ChangeTestStatu?testId=' +
              testId +
              "&statu=" +
              statu),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            // HttpHeaders.authorizationHeader: 'Bearer ' + await GetToken(),
          }).then((data) {
        if (data.statusCode == 200) {
          Test c = Test.fromJson(jsonDecode(data.body));
          return c;
        }
        if (data.statusCode == 400 && data.body == "yanlış") {
          return "yanlış";
        }
        return null;
      });
    } catch (e) {
      print(e);
    }
  }

  ChangeBursShown(bursId, statu) async {
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);

      return http.get(
          Uri.parse(baseUrl +
              '/System/ChangeBursShown?bursId=' +
              bursId +
              "&statu=" +
              statu),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            // HttpHeaders.authorizationHeader: 'Bearer ' + await GetToken(),
          }).then((data) {
        if (data.statusCode == 200) {
          Burs c = Burs.fromJson(jsonDecode(data.body));
          return c;
        }
        if (data.statusCode == 400 && data.body == "yanlış") {
          return "yanlış";
        }
        return null;
      });
    } catch (e) {
      print(e);
    }
  }


  ForgotPassword(email, statu) async {
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);

      return http.get(
          Uri.parse(baseUrl +
              '/System/ForgotPassword?email=' +
              email +
              "&statu=" +
              statu),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            // HttpHeaders.authorizationHeader: 'Bearer ' + await GetToken(),
          }).then((data) {
        if (data.statusCode == 200) {
          return data.body;
          // Burs c = Burs.fromJson(jsonDecode(data.body));
          // return c;
        }
        if (data.statusCode == 400 && data.body == "yok") {
          return "yok";
        }
        return null;
      });
    } catch (e) {
      print(e);
    }
  }

  GetTestCevaps(userId, testId) async {
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);

      return http.get(
          Uri.parse(baseUrl +
              '/System/GetTestCevaps?userId=' +
              userId +
              "&testId=" +
              testId),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            // HttpHeaders.authorizationHeader: 'Bearer ' + await GetToken(),
          }).then((data) {
        if (data.statusCode == 200) {
           var datas = new List<TestCevap>();
        Iterable list = json.decode(data.body);
        datas = list.map((model) => TestCevap.fromJson(model)).toList();
        return datas;
        }
        if (data.statusCode == 400 && data.body == "yok") {
          return "yok";
        }
        return null;
      });
    } catch (e) {
      print(e);
    }
  }

  CreateTestCevaps(List<TestCevap> dto) async {
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);

    List jsonList = [];
    dto.map((item) => jsonList.add(item.toJson())).toList();

    return http
        .post(Uri.parse(baseUrl + '/System/CreateTestCevaps'),
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
            },
            body: json.encode({"finalResponse": jsonList}["finalResponse"]))
        .then((data) {
      if (data.statusCode == 401) {
        toastr.show("Lütfen Giriş Yapınız.", false);
        return null;
      }
      if (data.statusCode == 200) {
        var datas = new List<TestCevap>();
        Iterable list = json.decode(data.body);
        datas = list.map((model) => TestCevap.fromJson(model)).toList();
        return datas;
      } else if (data.statusCode != 200 && data.body == "var") {
        return "var";
      }
      return null;
    });
  }

   BursSonuclandir(bursId) async {
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);

      return http.get(
          Uri.parse(baseUrl +
              '/System/Sonuclandir?bursId=' +
              bursId),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            // HttpHeaders.authorizationHeader: 'Bearer ' + await GetToken(),
          }).then((data) {
        if (data.statusCode == 200) {
         
         Burs c = Burs.fromJson(jsonDecode(data.body));
          return c;
        }
        if (data.statusCode == 400 && data.body == "yok") {
          return "yok";
        }
        return null;
      });
    } catch (e) {
      print(e);
    }
  }

  // Future<List<District>> GetDistricts(cityId) async {
  //   final ioc = new HttpClient();
  //   ioc.badCertificateCallback =
  //       (X509Certificate cert, String host, int port) => true;
  //   final http = new IOClient(ioc);

  //   return http.get(
  //       Uri.parse(
  //           baseUrl + '/Admin/GetDistrictsById?cityId=' + cityId.toString()),
  //       headers: {
  //         HttpHeaders.contentTypeHeader: 'application/json',
  //       }).then((data) {
  //     if (data.statusCode == 200) {
  //       var datas = new List<District>();
  //       Iterable list = json.decode(data.body);
  //       datas = list.map((model) => District.fromJson(model)).toList();
  //       return datas;
  //     }
  //     if (data.statusCode == 401) {
  //       toastr.show("Lütfen Giriş Yapınız.", false);
  //       return null;
  //     }
  //     return null;
  //   });
  // }

}
