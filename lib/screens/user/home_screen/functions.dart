import 'package:detail_dex/screens/user/home_screen/home_screen.dart';
import 'package:detail_dex/screens/user/splash/splash.dart';

sortbymyclients() {
  List result = [];
  for (var i in alldetails) {

    if (i['exicutiveid'] == exicutiveId) {

      result.add(i);
    }
  }
  return result;
}
