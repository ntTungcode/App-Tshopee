import 'package:get/get.dart';
import 'package:tmart_app/consts/consts.dart';
import 'package:tmart_app/controllers/home_controller.dart';
import 'package:tmart_app/views/cart_screen/cart_screen.dart';
import 'package:tmart_app/views/category_screen/category_screen.dart';
import 'package:tmart_app/views/home_screen/home_screen.dart';
import 'package:tmart_app/views/profile_screen/profile_screen.dart';
import 'package:tmart_app/views/widgets_common/exit_dialog.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  static const String id = 'home';

  @override
  Widget build(BuildContext context) {

    //init home controller
    var controller = Get.put(HomeController());

    var navbarIteam =[
      BottomNavigationBarItem(icon: Image.asset(icHome,width: 26),label: home),
      BottomNavigationBarItem(icon: Image.asset(icCategories,width: 26),label: categories),
      BottomNavigationBarItem(icon: Image.asset(icCart,width: 26),label: cart),
      BottomNavigationBarItem(icon: Image.asset(icProfile,width: 26),label: account),
    ];

    var navBody =[
      const HomeScreen(),
      const CategoryScreen(),
      const CartScreen(),
      const ProfileScreen()
    ];

    return WillPopScope(
      onWillPop: () async{
        showDialog(barrierDismissible: false, context: context, builder: (context)=> exitDialog(context));
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Obx(() => Expanded(child: navBody.elementAt(controller.currenNavIndex.value))),
          ],
        ),
        bottomNavigationBar: Obx(()=>
          BottomNavigationBar(
            currentIndex: controller.currenNavIndex.value,
              selectedItemColor: redColor,
              selectedLabelStyle: const TextStyle(fontFamily: semibold),
              type: BottomNavigationBarType.fixed,
              backgroundColor: whiteColor,
              items: navbarIteam,
              onTap: (value) {
                controller.currenNavIndex.value = value;
              },
          ),
        ),
      ),
    );
  }
}
