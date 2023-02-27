import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tmart_app/consts/consts.dart';
import 'package:tmart_app/models/category_model.dart';

class ProductController extends GetxController {
  List<dynamic> itemP = [].obs;
  RxList<dynamic> productRelative = (List<dynamic>.of([])).obs;
  var quantity = 0.obs;
  var colorIndex = 0.obs;
  var totalPrice = 0.obs;
  var subcat = [];
  var isFav = false.obs;
  // var indexvar = 0.obs;
  // var itemProduct = [].obs;
  var recenctProductname = '';
  List<String> productitemname = [];

  getSubCategories(title) async {
    subcat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decoded = categoryModelFromJson(data);
    var s =
        decoded.categories.where((element) => element.name == title).toList();

    for (var e in s[0].subcategory) {
      subcat.add(e);
    }
  }

  changeColorIndex(index) {
    colorIndex.value = index;
  }

  increaseQuantity(totalQuantity) {
    if (quantity.value < totalQuantity) {
      quantity.value++;
    }
  }

  decreaseQuantity() {
    if (quantity.value > 0) {
      quantity.value--;
    }
  }

  calculateTotalPrice(price) {
    totalPrice.value = price * quantity.value;
  }

  addToCart(
      {title, img, sellername, color, qty, tprice, context, vendorID}) async {
    await firestore.collection(cartCollection).doc().set({
      'title': title,
      'img': img,
      'sellername': sellername,
      'color': color,
      'qty': qty,
      'vendor_id': vendorID,
      'tprice': tprice,
      'added_by': currentUser!.uid
    }).catchError((error) {
      VxToast.show(context, msg: error.toString());
    });
  }

  resetValues() {
    totalPrice.value = 0;
    quantity.value = 0;
    colorIndex.value = 0;
    // itemProduct.clear();
    // productRelative.clear();
  }

  addToWishlist(docId, context) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayUnion([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(true);
    VxToast.show(context, msg: "Added to wishlist");
  }

  removeFromWishlist(docId, context) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayRemove([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(false);
    VxToast.show(context, msg: "Remove from wishlist");
  }

  checkIfFav(data) async {
    if (data['p_wishlist'].contains(currentUser!.uid)) {
      isFav(true);
    } else {
      isFav(false);
    }
  }

  //Gợi ý List sản phẩm
  void getData(product, title) async {
    if(product['p_name'] != recenctProductname){
      productRelative.value.clear();
      productitemname.clear();
      recenctProductname = product['p_name'];
    }
    //Tên phân loại con sản phẩm
    var subcate = product['p_subcategory'];
    //Tên phân loại cha của sản phẩm
    var categoryBy = product['p_category'];
    //Lấy danh sách tất cả các phân loại
    var data = await rootBundle.loadString("lib/services/category_model.json");
    //Đưa data string về dạng Json
    var decoded = categoryModelFromJson(data);
    //
    // var s = decoded.categories.where((element) => element.name == title).toList();
    //Khai báo 1 List danh sách các phân loại con có dạng String : Ví dụ : Máy tính, bàn phím, chuột.
    List<String> stringSubcategoryList = [];
    //Lọc danh sách lấy danh sách các phân loại con của phân loại cha ( bao gồm cả phân loại con của sản phẩm)
    decoded.categories.forEach((element) {
      if (element.name.toLowerCase() == categoryBy.toLowerCase()) {
        stringSubcategoryList = element.subcategory;
      }
    });
    //Khai báo List để chứa các sản phẩm của các phân loại
    List<List<dynamic>> productItem = [];
    // Lấy số lượng các phân loại con bao gồm cả của phân loại con của sản phẩm đc click đó
    int lebsub = stringSubcategoryList.length;
    // Duyệt lấy danh sách các sản phẩm của các phân loại con( trừ sản phẩm được đc click)
    for (int i = 0; i < lebsub ; i++) {

      var itemlist =  []; // Khai báo list tạm thời
      await firestore
          .collection(productsCollection)
          .where('p_subcategory', isEqualTo: stringSubcategoryList[i])
          .get()
          .then((value) {
            //Check tên sản phẩm cùng loại
        for (var element in value.docs) {
          if (element.data()['p_name'] != product['p_name']){
            itemlist.add(element.data());
          }
        }
        productItem.add(itemlist);
      });
    }
    //  Ramdom sàn phẩm
    var itemProduct = [];
    for (var itemP in productItem) {
      var itemlist = itemP.length;
        if(itemlist > 0){
        var indexvar = Random().nextInt(itemlist);
        // print(indexvar.toString() + "-" + itemlist.toString());
          // if(productRelative.isNotEmpty){
          //   for(String element in productitemname){
          //     print(itemP[indexvar]['p_name'] + "-"+element);
          //     if(element != itemP[indexvar]['p_name']){
          //       itemProduct.add(itemP[indexvar]);
          //       productitemname.add(itemP[indexvar]['p_name']);
          //     }
          //   }
          // }else{
            itemProduct.add(itemP[indexvar]);
            productitemname.add(itemP[indexvar]['p_name']);
        //   }
        }
    }
    productRelative.value = itemProduct;
  }
}
