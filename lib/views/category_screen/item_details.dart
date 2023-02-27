import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tmart_app/consts/consts.dart';
import 'package:tmart_app/controllers/product_controller.dart';
import 'package:tmart_app/services/firestore_services.dart';
import 'package:tmart_app/views/chat_screen/chat_screen.dart';
import 'package:tmart_app/views/widgets_common/our_button.dart';

import '../../consts/lists.dart';

class IteamDetails extends StatefulWidget {
  final String? title;
  final dynamic data;
   const IteamDetails({Key? key, required this.title, this.data})
      : super(key: key);

  @override
  State<IteamDetails> createState() => _IteamDetailsState();
}

class _IteamDetailsState extends State<IteamDetails> {
  var controller = Get.put(ProductController());

  // switchCategory(title){\

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getData(widget.data, '');
  }

  @override
  Widget build(BuildContext context) {

    // Future.delayed(Duration(seconds: 1), () {
    //   controller.getData(data, '');
    // });
    return WillPopScope(
      onWillPop: () async {
        controller.resetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              controller.resetValues();
              Get.back();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: widget.title!.text
              .size(16)
              .color(darkFontGrey)
              .fontFamily(bold)
              .make(),
          actions: [
            // IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
            Obx(
              () => IconButton(
                  onPressed: () {
                    if (controller.isFav.value) {
                      controller.removeFromWishlist(widget.data.id, context);
                      // controller.isFav(false);
                    } else {
                      controller.addToWishlist(widget.data.id, context);
                      // controller.isFav(true);
                    }
                  },
                  icon: Icon(
                    Icons.favorite_outlined,
                    color: controller.isFav.value ? redColor : darkFontGrey,
                  )),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VxSwiper.builder(
                autoPlay: true,
                height: 500,
                itemCount: widget.data['p_imgs'].length,
                aspectRatio: 16 / 9,
                viewportFraction: 1.0,
                itemBuilder: (context, index) {
                  return Image.network(
                    widget.data['p_imgs'][index],
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                },
              ),
              // 10.heightBox,

              widget.title!.text
                  .size(16)
                  .color(darkFontGrey)
                  .fontFamily(semibold)
                  .make(),
              // 10.heightBox,
              VxRating(
                  isSelectable: false,
                  value: double.parse(widget.data['p_rating']),
                  onRatingUpdate: (value) {},
                  normalColor: textfieldGrey,
                  selectionColor: Colors.yellow,
                  count: 5,
                  size: 25),
              // 10.heightBox,
              "${widget.data['p_price']}"
                  .text
                  .color(redColor)
                  .fontFamily(bold)
                  .size(18)
                  .make(),
              // 10.heightBox,
              Row(
                children: [
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "Seller".text.white.fontFamily(bold).size(18).make(),
                      10.heightBox,
                      "${widget.data['p_seller']}".text.make(),
                    ],
                  )),
                  const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.message_rounded, color: darkFontGrey),
                  ).onTap(() {
                    Get.to(() => const ChatScreen(), arguments: [
                      widget.data['p_seller'],
                      widget.data['vendor_id']
                    ]);
                  }),
                ],
              )
                  .box
                  .height(60)
                  .padding(const EdgeInsets.symmetric(horizontal: 16))
                  .color(textfieldGrey)
                  .make(),
              20.heightBox,
              Obx(
                () => Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: "Color:".text.color(textfieldGrey).make(),
                        ),
                        Row(
                          children: List.generate(
                            widget.data['p_colors'].length,
                            (index) => Stack(
                              alignment: Alignment.center,
                              children: [
                                VxBox()
                                    .size(40, 40)
                                    .roundedFull
                                    .color(Color(widget.data['p_colors'][index])
                                        .withOpacity(1.0))
                                    .margin(const EdgeInsets.symmetric(
                                        horizontal: 4))
                                    .make()
                                    .onTap(() {
                                  controller.changeColorIndex(index);
                                }),
                                Visibility(
                                  visible: index == controller.colorIndex.value,
                                  child: const Icon(Icons.done,
                                      color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ).box.padding(const EdgeInsets.all(8)).make(),

                    //quantity row
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: "Quantity:".text.color(textfieldGrey).make(),
                        ),
                        Obx(
                          () => Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    controller.decreaseQuantity();
                                    controller.calculateTotalPrice(
                                        int.parse(widget.data['p_price']));
                                  },
                                  icon: const Icon(Icons.remove)),
                              controller.quantity.value.text
                                  .size(16)
                                  .color(darkFontGrey)
                                  .fontFamily(bold)
                                  .make(),
                              IconButton(
                                  onPressed: () {
                                    controller.increaseQuantity(
                                        int.parse(widget.data['p_quantity']));
                                    controller.calculateTotalPrice(
                                        int.parse(widget.data['p_price']));
                                  },
                                  icon: const Icon(Icons.add)),
                              10.widthBox,
                              "(${widget.data['p_quantity']} available)"
                                  .text
                                  .color(textfieldGrey)
                                  .make(),
                            ],
                          ),
                        )
                      ],
                    ).box.padding(const EdgeInsets.all(8)).make(),
                    //total row
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: "Total:".text.color(textfieldGrey).make(),
                        ),
                        "${controller.totalPrice.value}"
                            .text
                            .color(redColor)
                            .size(16)
                            .fontFamily(bold)
                            .make(),
                      ],
                    ).box.padding(const EdgeInsets.all(8)).make(),
                  ],
                ).box.white.shadowSm.make(),
              ),
              10.heightBox,
              //description section
              "${widget.data['p_desc']}"
                  .text
                  .color(darkFontGrey)
                  .fontFamily(semibold)
                  .make(),
              10.heightBox,
              "This is a dummy item and dummy description here..."
                  .text
                  .color(darkFontGrey)
                  .make(),

              10.heightBox,
              //buttons section
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(
                  itemDetailButtonsList.length,
                  (index) => ListTile(
                    title: itemDetailButtonsList[index]
                        .text
                        .fontFamily(semibold)
                        .color(darkFontGrey)
                        .make(),
                    trailing: const Icon(Icons.arrow_forward),
                  ),
                ),
              ),
              // 10.heightBox,
              //products may like section
              productsyoumaylike.text
                  .fontFamily(bold)
                  .size(16)
                  .color(darkFontGrey)
                  .make(),
              // 10.heightBox,
              SizedBox(
                height: 450,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.productRelative.length,
                  itemBuilder: (context, index) {
                    final data = controller.productRelative[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            data['p_imgs'][0],
                            width: 200,
                            height: 350,
                            fit: BoxFit.cover,
                          ),
                          // 10.heightBox,
                          Text(data['p_name']),
                          // 10.heightBox,
                          Text(data['p_price'].toString())
                              .text
                              .color(redColor)
                              .fontFamily(bold)
                              .size(12)
                              .make(),
                        ],
                      ),
                    );
                  },
                ),
              ),
              //i copied this widget from home screen featured products
              // Obx(() => Text(controller.productRelative.length.toString()))
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          width: double.infinity,
          height: 60,
          child: ourButton(
              color: redColor,
              onPress: () {
                if (controller.quantity.value > 0) {
                  controller.addToCart(
                      color: widget.data['p_colors']
                          [controller.colorIndex.value],
                      context: context,
                      vendorID: widget.data['vendor_id'],
                      img: widget.data['p_imgs'][0],
                      qty: controller.quantity.value,
                      sellername: widget.data['p_seller'],
                      title: widget.data['p_name'],
                      tprice: controller.totalPrice.value);
                  VxToast.show(context, msg: "Added to cart");
                } else {
                  VxToast.show(context,
                      msg:
                          "Quantity can't be 0, Minumum 1 products is requried");
                }
              },
              textColor: whiteColor,
              title: "Add to cart"),
        ),
      ),
    );
  }
}
