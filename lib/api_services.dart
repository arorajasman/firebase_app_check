import 'dart:convert';
import 'dart:developer';

import 'package:firebase_project/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  Future<bool> playIntegrity(String token) async {
    bool isValidAppCheckToken = false;
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.usersEndpoint);
      // String token =
      //     "eyJraWQiOiJsWUJXVmciLCJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiIxOjIwNzk5NjI4NTMwODphbmRyb2lkOmFiNThlYWZkNTUyNjE4ZWI3MDM0ZjkiLCJhdWQiOlsicHJvamVjdHNcLzIwNzk5NjI4NTMwOCIsInByb2plY3RzXC9kZXZpY2V0aHJlYWQiXSwicHJvdmlkZXIiOiJwbGF5X2ludGVncml0eSIsImlzcyI6Imh0dHBzOlwvXC9maXJlYmFzZWFwcGNoZWNrLmdvb2dsZWFwaXMuY29tXC8yMDc5OTYyODUzMDgiLCJleHAiOjE2ODU5NTk2MTAsImlhdCI6MTY4NTM1NDgxMCwianRpIjoiTWk5X2Jod0ZwYUJZRnhvY3RPdnh3MjNRSjZvNFdLSnU1WTdIYVVYMVhTYyJ9.TvqIpwxbwYeb8t1kT1Lh395KeNoBp1x9yrnRm3p9AP_xoR94GZItIZ3mjfD5DSsQ6jmpMaLd3uVenQteB6IAm3CZOctMGSTdWLfqf0QTf9FN4mc9sWEl1XfmxmeeAkw6tnMZsVzxaUqXYty8glCBC9qeRzMjpFsUqCDX-sHPJYmEUXtEaSmvgHxuStQUTEAZGVfNhRx5aw_ku-j0MCdltXyiN4CLqhoZ-9cb3cXHTtQd9UK-ns9mN_C_EzDF0rOx42YYRJVw0y7eA_j9Z3ct1430rKmkkTGJ-p5o4gR86YfqyVc-f1168GHrrVjjVHo4z6LY3RMIoE3xhPrtvmxDyR4rKWyla2AOsy9nqV0AVmhRLCUnZc2jc2SHQTe4EQuBmkXPSU_M3plV0SS_C_CnB3By5TTHTj-Kayu3KVhNt23kqlByHdRTBJaHzAJF6HBrIQQPzHO-SGmRtXBLfZT8GO2bmsG-SLRvEW_UzCW9PjqIh808xkInnwOT1WV3M01i";
      Map<String, String> playintegrityheaders = {
        ApiConstants.authorization: '${ApiConstants.bearer} $token',
        "Content-Type": "application/json"
      };
      var response = await http.get(url, headers: playintegrityheaders);
      if (response.statusCode == 200) {
        isValidAppCheckToken =
            jsonDecode(response.body)["data"]["isValidAppCheckToken"];

        setVerification(
            jsonDecode(response.body)["data"]["isValidAppCheckToken"]);
      }
    } catch (e) {
      log(e.toString());
    }
    setToken(true);
    return isValidAppCheckToken;
  }
}

setToken(bool istokenCalled) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(ApiConstants.IS_FIREBASE_APPCHECK_TOKEN_CALLED, istokenCalled);
}

setVerification(bool isVerified) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(ApiConstants.IS_VERIFIED, isVerified);
}
