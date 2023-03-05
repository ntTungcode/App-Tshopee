import 'package:tmart_app/consts/consts.dart';

Widget bgWidget({Widget? child}) {
  return Container(
    decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(imgBackground),//Nền của ứng dụng
            fit: BoxFit.fill
        )
    ),
    child: child,
  );
}
