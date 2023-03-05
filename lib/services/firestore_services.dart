import 'package:tmart_app/consts/consts.dart';

class FirestoreServices {
  // lấy dữ liệu người dùng
  static getUser(uid){
    return firestore.collection(usersCollection).where('id', isEqualTo: uid).snapshots();
  }

  // lấy dữ liệu sản phẩm
  static getProducts(category) {
    return firestore.collection(productsCollection).where('p_category',isEqualTo: category).snapshots();
  }
  //Lấy dữ liệu sản phẩm con
  static getSubCategoryProducts(title) {
    return firestore.collection(productsCollection).where('p_subcategory',isEqualTo: title).snapshots();
  }
  //Lấy dữ liệu giỏ hàng
  static getCart(uid) {
    return firestore
        .collection(cartCollection)
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }
  //Xõa item sản phẩm trong phần giỏ hàng
  static deleteDocument(docId) {
    return firestore.collection(cartCollection).doc(docId).delete();
  }

  //Lấy tất cả tin nhắn trò chuyện
  static getChatMessages(docId) {
    return firestore
        .collection(chatsCollection)
        .doc(docId)
        .collection(messagesCollection)
        .orderBy('created_on', descending: false)
        .snapshots();
  }

  //Hiển thị danh sách Order
  static getAllOrders(){
    return firestore.collection(ordersCollection).where('order_by', isEqualTo: currentUser!.uid).snapshots();
  }

  //Hiển thị danh sách yêu thích
  static getWishlists(){
    return firestore.collection(productsCollection).where('p_wishlist', arrayContains: currentUser!.uid).snapshots();
  }

  static getAllMessages(){
    return firestore.collection(chatsCollection).where('fromId',isEqualTo: currentUser!.uid).snapshots();
  }

  //Hiện thị số lượng của cart vs yêu thích và order
  static getCounts() async{
    var res = await Future.wait([
      firestore.collection(cartCollection).where('added_by', isEqualTo: currentUser!.uid).get().then((value){
        return value.docs.length;
      }),
      firestore.collection(productsCollection).where('p_wishlist', arrayContains: currentUser!.uid).get().then((value){
        return value.docs.length;
      }),
      firestore.collection(ordersCollection).where('order_by', isEqualTo: currentUser!.uid).get().then((value){
        return value.docs.length;
      }),
    ]);
    return res;
  }

  //Lấy dữ liệu và cho hiển thị tất cả sản phẩm ra ngoài màn hình chính
  static allproducts(){
    return firestore.collection(productsCollection).snapshots();
  }


//Hiển thị danh sách sản phẩm nổi bật
  static getFeaturedProducts() {
    return firestore.collection(productsCollection).where('is_featured', isEqualTo: true).get();
  }

  //Sản phẩm tìm kiếm
  static searchProducts(title){
    return firestore.collection(productsCollection).get();
  }
}