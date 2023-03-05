import 'dart:io';

import 'package:get/get.dart';
import 'package:tmart_app/consts/consts.dart';
import 'package:tmart_app/controllers/profile_controller.dart';
import 'package:tmart_app/views/widgets_common/bg_widget.dart';
import 'package:tmart_app/views/widgets_common/our_button.dart';

import '../widgets_common/custom_textfield.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    // controller.nameController.text =  data['name'];
    // controller.passwordController.text =  data['password'];

    return bgWidget(
        child: Scaffold(
      appBar: AppBar(),
      //Chỉnh ảnh profile
      body: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //url hình ảnh dữ liệu và đường dẫn bộ điều khiển
            data['imageUrl'] == '' && controller.profileImgPath.isEmpty
                ? Image.asset(imgProfile2, width: 100, fit: BoxFit.cover)
                    .box
                    .roundedFull
                    .clip(Clip.antiAlias)
                    .make()
                //truyền dữ liệu hình ảnh đã tồn tại nhưng đường dẫn bộ điều khiển trống
                : data['imageUrl'] != '' && controller.profileImgPath.isEmpty
                    ? Image.network(
                        data['imageUrl'],
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make()
                    : Image.file(
                        File(controller.profileImgPath.value),
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make(),
            // 10.heightBox,
            //Chọn ảnh mới
            ourButton(
                color: redColor,
                onPress: () {
                  controller.changeImage(context);
                  // Get.find<ProfileController>().changeImage(context);
                },
                textColor: whiteColor,
                title: "Change"),
            //Thông tin chỉnh sửa
            const Divider(),
            // 20.heightBox,
            customTextField(
                controller: controller.nameController,
                hint: nameHint,
                title: name,
                isPass: false),
            customTextField(
                controller: controller.oldpasswordController,
                hint: passwordHint,
                title: oldpass,
                isPass: true),
            customTextField(
                controller: controller.newpasswordController,
                hint: passwordHint,
                title: newpass,
                isPass: true),
            // 20.heightBox,
            controller.isloading.value
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  )
                : SizedBox(
                    width: context.screenWidth - 60,
                    child: ourButton(
                        color: redColor,
                        onPress: () async {
                          controller.isloading(true);
                          //nếu hình ảnh không được chọn
                          if (controller.profileImgPath.value.isNotEmpty) {
                            await controller.uploadProfileImage();
                          } else {
                            controller.profileImageLink = data['imageUrl'];
                          }
                          //nếu mật khẩu cũ khớp với cơ sở dữ liệu
                          if (data['password'] == controller.oldpasswordController.text) {
                              await controller.changeAuthPassword(
                                email: data['email'],
                                password: controller.oldpasswordController.text,
                                newpassword: controller.newpasswordController.text);

                              await controller.updateProfile(
                                  imgUrl: controller.profileImageLink,
                                  name: controller.nameController.text,
                                  password: controller.newpasswordController.text);
                            VxToast.show(context, msg: "Updated");//Thông báo thành công
                          }else{
                            VxToast.show(context, msg: "Wrong old password");//Thông báo mật khẩu cũ không đúng
                            controller.isloading(false);
                          }
                        },
                        textColor: whiteColor,
                        title: "Save"),
                  )
          ],
        )
            .box
            .white
            .shadowSm
            .padding(const EdgeInsets.all(16))
            .margin(const EdgeInsets.only(top: 20, left: 12, right: 12))
            .rounded
            .make(),
      ),
    ));
  }
}
