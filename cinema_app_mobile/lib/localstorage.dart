import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';

class Token {
  static final storage = new FlutterSecureStorage();
  static late bool connected = false;
  static Future getToken(k) async {
    return await storage.read(key: k);
  }

  static deleteToken(k) async {
    await storage.delete(key: k);
  }

  static addToken(k, val) async {
    await storage.write(key: k, value: val);
  }

  static Future<Map<String, dynamic>> decodeToken() async {
    return Jwt.parseJwt(await getToken("token"));
  }
}
