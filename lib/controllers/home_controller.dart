import 'package:get/get.dart';
import 'package:tmart_app/consts/consts.dart';

class HomeController extends GetxController{

  @override
  void onInit() {
    getUsername();
    super.onInit();
  }

  var currenNavIndex =0.obs;

  var username = '';

  var featuredList =[];

  var searchController = TextEditingController();

  getUsername() async{
   var n = await firestore.collection(usersCollection).where('id',isEqualTo: currentUser!.uid).get().then((value) {
        if (value.docs.isNotEmpty) {
          return value.docs.single['name'];
      }
    });
   username = n;
   // print(username);
  }
  // fetchFeatured(data) {
  //   featuredList.clear();
  //   for( var i = 0; i < data.length; i++) {
  //     featuredList.add(data[i]);
  //     print(data[i]);
  //   }
  //   return featuredList.shuffle();
  // }
}