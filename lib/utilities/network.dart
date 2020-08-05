import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper{

  Future getData(var url) async{
    try{
      http.Response response = await http.get(url);
      String body = response.body;
      return jsonDecode(body);

    }
    catch(e)
    {
      print(e);
    }
  }

  Future postData(var url, var data) async{
    try{

      http.Response response = await http.post(url, body: data,headers: {"Accept": "application/json"},);
      String body = response.body;
      return jsonDecode(body);

    }

    catch(e)
    {

      print(e);

    }
  }

  Future putData(var url, var data) async{
    try{

      http.Response response = await http.put(url, body: data,headers: {"Accept": "application/json"},);
      String body = response.body;
      return jsonDecode(body);

    }

    catch(e)
    {

      print(e);

    }
  }

}