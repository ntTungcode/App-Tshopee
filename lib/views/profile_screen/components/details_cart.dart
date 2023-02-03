import 'package:tmart_app/consts/consts.dart';

Widget detailsCard({width, String? count, String? title}){
   return Column(
     mainAxisAlignment: MainAxisAlignment.center,
     children: [
       count!.text.fontFamily(bold).color(darkFontGrey).make(),
       5.heightBox,
       title!.text.color(darkFontGrey).size(16).make(),
     ],
   ).box.white.rounded.width(width).height(80).padding(const EdgeInsets.all(4)).make();
}