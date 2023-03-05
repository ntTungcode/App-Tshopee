// ignore_for_file: deprecated_member_use

import 'package:tmart_app/consts/consts.dart';
//Chỉnh button
Widget ourButton({ onPress, color, textColor,String? title }) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: color,
      padding: const EdgeInsets.all(12),
    ),
      onPressed: onPress,
      child:
        title!.text.color(textColor).fontFamily(bold).make(),
  );
}
