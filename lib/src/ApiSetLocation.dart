import 'package:http/http.dart' as http;

class ApiSetting {
  String url = " ";
  int timeIntervalForLocation = 0;
  bool isBackgroundMdoe = false;
  bool hasPermission = false;

  String get getUrl {
    return url;
  }

  set setUrl(value) {
    url = value;
  }

  int get gettimeInterval {
    return timeIntervalForLocation;
  }

  set setInterval(int value) {
    timeIntervalForLocation = value;
  }

  bool get getBackGroundMode {
    return isBackgroundMdoe;
  }

  set setBackGroundMode(value) {
    isBackgroundMdoe = value;
  }

  bool get getPermmision {
    return hasPermission;
  }

  set setPermission(value) {
    hasPermission = value;
  }
}
