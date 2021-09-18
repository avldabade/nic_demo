
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nic_demo/utils/sharedPrefrance.dart';
class ApiService{
  final BuildContext context;
   ApiService(this.context);

  ///Post Method With Auth
  Future<http.Response> postMethodWithAuth(String queryParam,String url) async {
    print(url);
    print(queryParam);
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${UserPreference.getAccessToken()}'
    };
    var response = await http.post(url,body: queryParam,headers: headers);
    return response;
  }

  ///Post Method Without Auth
  Future<http.Response> postMethod(String queryParam,String url) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
    };
    print(url);
    var response = await http.post(url,body: queryParam,headers: headers);
    return response;
  }

  ///Get Method
  Future<http.Response> getMethod(String url) async {
    print(url);
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${UserPreference.getAccessToken()}'
    };
    var response = await http.get(url,headers: headers);
    return response;
  }

  ///Get Method
  Future<http.Response> getMethodWithoutToken(String url) async {
    print(url);
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    print('apicall start');
    var response = await http.get(url,headers: headers);
    print('apicall end');
    return response;
  }

  ///Patch Method With Auth
  Future<http.Response> patchMethod(String queryParam,String url) async {
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ${UserPreference.getAccessToken()}'
    };

    print(headers);
    var response = await http.patch(url,body: queryParam,headers: headers);
    return response;
  }


  ///Patch Method Without Auth
  Future<http.Response> patchMethodWithoutAuth(String queryParam,String url) async {
    Map<String, String> headers = {
      'Content-type': 'application/json',
    };
    print(headers);
    var response = await http.patch(url,body: queryParam,headers: headers);
    return response;
  }
 }