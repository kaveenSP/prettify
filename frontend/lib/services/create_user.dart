import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:prettify1/models/loginUser.dart';
import 'package:prettify1/models/user.dart';
import 'dart:convert';




class ServiceUser{
      static Future<dynamic> postUser(User user) async {
      try{
       
        const url = "http://10.0.2.2:8000/user";
        //const url = "http://10.0.2.2:8000/carcare/api/CreateJobService";
        final uri = Uri.parse(url);
        var response = await http.post(uri,body:json.encode(user),headers: {"Content-Type": "application/json"});
 
        return response.body;
      }catch(e){
        return e;      }
    }

    static Future<bool> getUser(LoginUser user) async {
      try{
       
        const url = "http://10.0.2.2:8000/userLogin";
        //const url = "http://10.0.2.2:8000/carcare/api/CreateJobService";
        final uri = Uri.parse(url);
        var response = await http.post(uri,body:json.encode(user),headers: {"Content-Type": "application/json"});

        if (response.statusCode == 200){
            return true;
        }else{
          return false;
        }

       
      }catch(e){
        return false;      }
    }
}

