import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class ApiCalls {
  static void importUser(email, displayName, [avatar]) async {
    String url = 'https://api.ditmenavi.com/user/import/';
    Map<String, dynamic> data = {'email': email, 'displayName': displayName, 'avatar': avatar};
    String jsonData = jsonEncode(data);
    try {
      HttpRequest request = await HttpRequest.request(
        url,
        method: 'POST',
        requestHeaders: {'Content-Type': 'application/json;charset=UTF-8'},
        sendData: jsonData,
      );
      print(request.responseText);
    } catch (e) {
      print(e);
    }
  }
}

Future<String> getUserDisplayName(String email) async {
  final url = Uri.parse('https://api.ditmenavi.com/user/email/$email');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    final displayName = jsonResponse['user_displayname'];
    return displayName;
  } else {
    throw Exception('Failed to load user display name');
  }
}
