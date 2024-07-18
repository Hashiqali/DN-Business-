import 'package:detail_dex/screens/user/home_screen/home_screen.dart';
import 'package:detail_dex/screens/user/splash/splash.dart';

sortbymyclients() {
  List result = [];
  for (var i in alldetails) {
    int c = 0;
    if (i['exicutiveid'] == exicutiveId) {
      print('count==$c');
      result.add(i);
    }
  }
  return result;
}
