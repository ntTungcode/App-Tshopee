import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tmart_app/consts/consts.dart';

class AuthController extends GetxController {

  var isloading = false.obs;

  //Text Controllers
  var emailController = TextEditingController();
  var passwordController =  TextEditingController();

  //Login method
  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
      currentUser = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //signup method
  Future<UserCredential?> signupMethod({email, password, context}) async {
    UserCredential? userCredential;
    try {
      auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //storing data method
  storeUserData({name, password, email}) async{
    DocumentReference store = firestore.collection(usersCollection).doc(currentUser!.uid);
    store.set(
        {
          'name': name,
          'password': password,
          'email': email,
          'id': currentUser!.uid,
          'imageUrl': '',
          'cart_count': "00",
          'order_count': "00",
          'wishlist_count': "00",
        }
    );
  }

  //signout method
  signoutMethod(context) async{
    try {
      await auth.signOut();
      // currentUser = null;
    }catch (e) {
      VxToast.show(context,msg: e.toString());
    }
  }
}
