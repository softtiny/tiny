import 'package:scoped_model/scoped_model.dart';

class AppStateModel extends Model {
  String _pythonurl ="";
  String _vlcurl = "";
  String get pythonurl {
    return _pythonurl;
  }
  String get vlcurl {
    return _vlcurl;
  }
  void setPythonurl(String url) {
    _pythonurl = url;
  }
  void setVlcurl(String url) {
    _vlcurl = url;
  }
}