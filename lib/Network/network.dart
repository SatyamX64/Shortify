import 'package:http/http.dart' as http;

class NetworkLoader {
  String _apiKey = '09c5bc121e3bc5a78817d9e55f2bd458';
  String _url = 'https://cutt.ly/api/api.php'; 
  Future shortenURL({String url, String customCode}) async {
    print('NO');
    if (customCode == null) {
      print('NO');
      http.Response response = await http.get(
        '$_url?key=$_apiKey&short=$url',
      );
      print('NO');
      return response;
    } else {
      http.Response response = await http.get(
        '$_url?key=$_apiKey&short=$url&name=$customCode',
      );
      return response;
    }
  }

  Future analytics(url) async {
    http.Response response = await http.get('$_url?key=$_apiKey&stats=$url'); // Correct Request
    // http.Response response = await http.get(
    //     '$_url?key=$_apiKey&stats=https://cutt.ly/5dDAfYi'); // Fake Req created temporarily  to save state
    return response;
  }
}
