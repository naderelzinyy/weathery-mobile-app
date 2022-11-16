import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHandler {
  NetworkHandler(this.url);
  var url;

  Future getData() async {
    url = Uri.parse(url);

    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }
}
