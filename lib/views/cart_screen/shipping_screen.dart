import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tmart_app/consts/consts.dart';
import 'package:tmart_app/controllers/cart_controller.dart';
import 'package:tmart_app/views/cart_screen/playment_method.dart';
import 'package:tmart_app/views/widgets_common/custom_textfield.dart';

import '../widgets_common/our_button.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping Info".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
          onPress: (){
            if (controller.addressController.text.length >6) {
              Get.to(() => const PaymentMethods());
            }else {
              VxToast.show(context, msg: "Please fill the form");
            }
          },
          color: redColor,
          textColor: whiteColor,
          title: "Continue",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            customTextField(hint: "Address", isPass: false,title: "Address", controller: controller.addressController),
            customTextField(hint: "State", isPass: false,title: "State", controller: controller.stateController),
            customTextField(hint: "City", isPass: false,title: "City", controller: controller.cityController),
            customTextField(hint: "Postal Code", isPass: false,title: "Postal Code", controller: controller.postalcodeController),
            customTextField(hint: "Phone", isPass: false,title: "Phone", controller: controller.phoneController),
          ],
        ),
      ),
    );
  }
}
