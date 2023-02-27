import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
   var n = await firestore.collection(usersCollection).where('id',isEqualTo: FirebaseAuth.instance.currentUser!.uid).get().then((value) {
        if (value.docs.isNotEmpty) {
          return value.docs.single['name'];
      }
    });
   username = n;
  }
}