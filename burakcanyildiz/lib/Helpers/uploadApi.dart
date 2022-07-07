import 'dart:convert';
import 'dart:io';
import 'package:burakcanyildiz/Helpers/Toastr.dart';
import 'package:burakcanyildiz/Helpers/token.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class UploadApi {
  static const baseUrl = "http://212.64.215.42:5005/api";
  Token token = new Token();
  Toastr toastr = new Toastr();

  UserFile(data, id) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse(baseUrl + '/System/UploadImage?id=' + id));
    request.files.add(http.MultipartFile(
        'picture', File(data).readAsBytes().asStream(), File(data).lengthSync(),
        filename: data.split("/").last));
    var res = await request.send();

    if (res != null && res.statusCode == 200) {
      return "Ok";
    } else {
      return "Error";
    }
  }

}
