import 'package:test/test.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
void main() {
  test("test unit",() async{
    print(Uri.encodeFull('10.220.8.242/a.mp4'));
    print(path.posix.normalize(path.join('10.220.8.242/','./a.mb4')));
  });
}