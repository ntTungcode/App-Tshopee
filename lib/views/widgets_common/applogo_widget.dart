import 'package:tmart_app/consts/consts.dart';

Widget applogoWidget(){
  //Thêm logo vào màn hình chờ khi vào app
  return Image.asset(icAppLogo).box.white.size(77, 77).padding(const EdgeInsets.all(8)).rounded.make();
}