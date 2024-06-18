import 'dart:convert';

import 'package:http/http.dart' as http;

checking()async{
Map<String,String> json={
  'user':'aakash',
  'password':'1234'
};
final js= jsonEncode(json);
await http.post(Uri.parse(''),headers: {'content-type':'application/json'},body: js);
}