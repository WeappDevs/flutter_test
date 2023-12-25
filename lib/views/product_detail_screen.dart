import 'package:admin_web_app/controllers/index_controller.dart';
import 'package:admin_web_app/utils/assets.dart';
import 'package:admin_web_app/utils/colors.dart';
import 'package:admin_web_app/utils/text_styles.dart';
import 'package:admin_web_app/views/widgets/NestedRowBuilder.dart';
import 'package:admin_web_app/views/widgets/empty_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    IndexController controller = Get.find<IndexController>();

    return SelectionArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: controller.onProductDetailBackBtnTapped,
                  icon: const Icon(Icons.chevron_left),
                  splashRadius: 20,
                ),
                const SizedBox(width: 10),
                Text(
                  "Product Details",
                  style: CustomTextStyle.screenHeadingStyle,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              height: .8,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Clr.greyColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 30),
            Obx(() {
              return (controller.productDetailModel.value != null &&
                      controller.productDetailModel.value?.data?.value != null)
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Visual Details",
                              style: CustomTextStyle.infoHeadingStyle,
                            ),
                            const SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: 70,
                                      width: 70,
                                      color: Clr.decentGreyColor,
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      height: 70,
                                      width: 70,
                                      color: Clr.decentGreyColor,
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      height: 70,
                                      width: 70,
                                      color: Clr.decentGreyColor,
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      height: 70,
                                      width: 70,
                                      color: Clr.decentGreyColor,
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 20),
                                Container(
                                  height: 500,
                                  width: 500,
                                  color: Clr.decentGreyColor,
                                ),
                                const SizedBox(width: 30),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Clr.whiteColor,
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Media Inner Details",
                                          style: CustomTextStyle.infoHeadingStyle,
                                        ),
                                        const SizedBox(height: 10),
                                        const EmptyView(emptyText: "No Media Inner Details Available.")
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 30),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Clr.whiteColor,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Basic Details",
                                style: CustomTextStyle.infoHeadingStyle,
                              ),
                              const SizedBox(height: 10),
                              NestedRowBuilder(
                                data: controller.productDetailModel.value?.data?.value?.toJson() ?? <String, dynamic>{},
                              ),
                              /*Column(
                                children: controller.productDetailModel.value?.data?.value
                                        ?.toJson()
                                        .entries
                                        .map((element) {
                                      return (element.value.runtimeType == String ||
                                              element.value.runtimeType == num ||
                                              element.value.runtimeType == int ||
                                              element.value.runtimeType == bool)
                                          ? Padding(
                                              padding: const EdgeInsets.only(top: 5),
                                              child: SizedBox(
                                                width: double.infinity,
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                            element.key
                                                                .replaceAll("_", " ")
                                                                .toString()
                                                                .trimLeft()
                                                                .capitalize
                                                                .toString(),
                                                            style: const TextStyle(color: Clr.greyColor))),
                                                    const SizedBox(width: 10),
                                                    Expanded(flex: 9, child: Text(element.value?.toString() ?? "-")),
                                                    // Expanded(flex: 3, child: Text(element.value?.runtimeType.toString() ?? "-")),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : const SizedBox();
                                    }).toList() ??
                                    <Widget>[],
                              ),*/
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Clr.whiteColor,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Additional Details",
                                style: CustomTextStyle.infoHeadingStyle,
                              ),
                              const SizedBox(height: 10),
                              Column(
                                children: controller.productDetailModel.value?.data?.value?.additionalDetails
                                        ?.toJson()
                                        .entries
                                        .map((element) {
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                  flex: 3,
                                                  child: Text(
                                                      element.key
                                                          .replaceAll("_", " ")
                                                          .toString()
                                                          .trimLeft()
                                                          .capitalize
                                                          .toString(),
                                                      style: const TextStyle(color: Clr.greyColor))),
                                              const SizedBox(width: 10),
                                              Expanded(flex: 9, child: Text(element.value?.toString() ?? "-")),
                                            ],
                                          ),
                                        ),
                                      );
                                    }).toList() ??
                                    <Widget>[],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Clr.whiteColor,
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Diamond Details",
                                      style: CustomTextStyle.infoHeadingStyle,
                                    ),
                                    const SizedBox(height: 10),
                                    Column(
                                      children: controller.productDetailModel.value?.data?.value?.diamondDetails
                                              ?.toJson()
                                              .entries
                                              .map((element) {
                                            return Padding(
                                              padding: const EdgeInsets.only(top: 5),
                                              child: SizedBox(
                                                width: double.infinity,
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                            element.key
                                                                .replaceAll("_", " ")
                                                                .toString()
                                                                .trimLeft()
                                                                .capitalize
                                                                .toString(),
                                                            style: const TextStyle(color: Clr.greyColor))),
                                                    const SizedBox(width: 10),
                                                    Expanded(flex: 4, child: Text(element.value?.toString() ?? "-")),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }).toList() ??
                                          <Widget>[],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 30),
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Clr.whiteColor,
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Side Diamond Details",
                                      style: CustomTextStyle.infoHeadingStyle,
                                    ),
                                    const SizedBox(height: 10),
                                    Column(
                                      children: controller.productDetailModel.value?.data?.value?.sideDiamondDetails
                                              ?.toJson()
                                              .entries
                                              .map((element) {
                                            return Padding(
                                              padding: const EdgeInsets.only(top: 5),
                                              child: SizedBox(
                                                width: double.infinity,
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                            element.key
                                                                .replaceAll("_", " ")
                                                                .toString()
                                                                .trimLeft()
                                                                .capitalize
                                                                .toString(),
                                                            style: const TextStyle(color: Clr.greyColor))),
                                                    const SizedBox(width: 10),
                                                    Expanded(flex: 4, child: Text(element.value?.toString() ?? "-")),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }).toList() ??
                                          <Widget>[],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                      ],
                    )
                  : Center(
                      child: LoadingAnimationWidget.fallingDot(color: Clr.whiteColor, size: 32),
                    );
            })
          ],
        ),
      ),
    );
  }
}
