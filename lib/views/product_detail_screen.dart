import 'package:admin_web_app/controllers/index_controller.dart';
import 'package:admin_web_app/models/product/product_detail_model.dart';
import 'package:admin_web_app/models/v_media_tab_model.dart';
import 'package:admin_web_app/utils/assets.dart';
import 'package:admin_web_app/utils/colors.dart';
import 'package:admin_web_app/utils/text_styles.dart';
import 'package:admin_web_app/views/widgets/NestedRowBuilder.dart';
import 'package:admin_web_app/views/widgets/empty_view.dart';
import 'package:admin_web_app/views/widgets/mini_video_view.dart';
import 'package:admin_web_app/views/widgets/s_txt.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    IndexController controller = Get.find<IndexController>();

    return Padding(
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
              STxt(
                txt: "Product Details",
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
                          STxt(
                            txt: "Visual Details",
                            style: CustomTextStyle.infoHeadingStyle,
                          ),
                          const SizedBox(height: 20),
                          (controller.productDetailModel.value?.data?.value?.visualDetails?.isNotEmpty == true)
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Wrap(
                                      spacing: 10,
                                      runSpacing: 10,
                                      children: List.generate(controller.vMediaTabListModel.length, (index) {
                                        VMediaTabModel element = controller.vMediaTabListModel[index];

                                        return Padding(
                                          padding: const EdgeInsets.only(right: 0),
                                          child: Obx(() => Chip(
                                                backgroundColor:
                                                    (element.isSelected.value == true) ? Clr.primaryColor : null,
                                                label: Text("VM NO: ${element.index + 1}"),
                                                deleteIcon: Icon((element.isSelected.value == true)
                                                    ? Icons.check_circle_rounded
                                                    : Icons.check_circle_outline_rounded),
                                                onDeleted: () {
                                                  controller.onVMediaChangedBtnTapped(ele: element);
                                                },
                                                deleteButtonTooltipMessage: "Select",
                                              )),
                                        );
                                      }),
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Obx(() => Column(
                                              children: [
                                                InkWell(
                                                  onTap: controller.onVideoTapped,
                                                  child: Container(
                                                    height: 70,
                                                    width: 70,
                                                    color: Clr.imageBGClr,
                                                    padding: const EdgeInsets.all(15),
                                                    child: Image.asset(LocalPNG.playIcon),
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                for (String imageURL in controller
                                                        .selectedVMediaTabModel.value?.visualDetails.productImages ??
                                                    []) ...[
                                                  InkWell(
                                                    onTap: () {
                                                      controller.onImageTapped(image: imageURL);
                                                    },
                                                    child: Container(
                                                      height: 70,
                                                      width: 70,
                                                      color: Clr.imageBGClr,
                                                      child: Image.network(
                                                        imageURL,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                ]
                                              ],
                                            )),
                                        const SizedBox(width: 20),
                                        Obx(() => (controller.selectedVMediaTabModel.value?.isVideoSelected?.value ==
                                                true)
                                            ? Container(
                                                height: 500,
                                                width: 500,
                                                color: Clr.imageBGClr,
                                                child: Obx(() => MiniVideoView(
                                                    isNotMute: true,
                                                    netImageURL: (controller
                                                                .selectedVMediaTabModel.value?.isVideoSelected?.value ==
                                                            true)
                                                        ? controller
                                                            .selectedVMediaTabModel.value?.selectedMediaPath.value
                                                        : null)),
                                              )
                                            : Container(
                                                height: 500,
                                                width: 500,
                                                color: Clr.imageBGClr,
                                                child: Image.network(
                                                  controller.selectedVMediaTabModel.value?.selectedMediaPath.value ??
                                                      "",
                                                  fit: BoxFit.cover,
                                                ),
                                              )),
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
                                                STxt(
                                                  txt: "Media Inner Details",
                                                  style: CustomTextStyle.infoHeadingStyle,
                                                ),
                                                const SizedBox(height: 10),
                                                if (controller.productDetailModel.value?.data?.value?.visualDetails
                                                        ?.isNotEmpty ??
                                                    false) ...[
                                                  for (VisualDetails ele in controller
                                                          .productDetailModel.value?.data?.value?.visualDetails ??
                                                      []) ...[
                                                    Column(
                                                      children: ele.toJson().entries.map((element) {
                                                        return Padding(
                                                          padding: const EdgeInsets.only(top: 5),
                                                          child: SizedBox(
                                                            width: double.infinity,
                                                            child: Row(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Expanded(
                                                                    flex: 3,
                                                                    child: STxt(
                                                                        txt: element.key
                                                                            .replaceAll("_", " ")
                                                                            .toString()
                                                                            .trimLeft()
                                                                            .capitalize
                                                                            .toString(),
                                                                        style: const TextStyle(color: Clr.greyColor))),
                                                                const SizedBox(width: 10),
                                                                Expanded(
                                                                  flex: 9,
                                                                  child: (element.value is List)
                                                                      ? (element.value.length != 0)
                                                                          ? Column(
                                                                              crossAxisAlignment:
                                                                                  CrossAxisAlignment.start,
                                                                              children: List.generate(
                                                                                  element.value.length,
                                                                                  (index) => (element.value[index]
                                                                                              .runtimeType ==
                                                                                          String)
                                                                                      ? STxt(
                                                                                          txt: element.value[index] ??
                                                                                              "-")
                                                                                      : STxt(
                                                                                          txt: element.value
                                                                                                  ?.toString() ??
                                                                                              "-")),
                                                                            )
                                                                          : const STxt(txt: "-")
                                                                      : STxt(txt: element.value?.toString() ?? "-"),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      }).toList(),
                                                    ),
                                                  ]
                                                ] else ...[
                                                  const EmptyView()
                                                ]
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : const EmptyView()
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
                            STxt(
                              txt: "All Details",
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
                                                      child: STxt(txt:
                                                          element.key
                                                              .replaceAll("_", " ")
                                                              .toString()
                                                              .trimLeft()
                                                              .capitalize
                                                              .toString(),
                                                          style: const TextStyle(color: Clr.greyColor))),
                                                  const SizedBox(width: 10),
                                                  Expanded(flex: 9, child: STxt(txt:element.value?.toString() ?? "-")),
                                                  // Expanded(flex: 3, child: STxt(txt:element.value?.runtimeType.toString() ?? "-")),
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 4,
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
                                  STxt(
                                    txt: "Basic Details",
                                    style: CustomTextStyle.infoHeadingStyle,
                                  ),
                                  const SizedBox(height: 10),
                                  Column(
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
                                                            child: STxt(
                                                                txt: element.key
                                                                    .replaceAll("_", " ")
                                                                    .toString()
                                                                    .trimLeft()
                                                                    .capitalize
                                                                    .toString(),
                                                                style: const TextStyle(color: Clr.greyColor))),
                                                        const SizedBox(width: 10),
                                                        Expanded(
                                                            flex: 9,
                                                            child: STxt(txt: element.value?.toString() ?? "-")),
                                                        // Expanded(flex: 3, child: STxt(txt:element.value?.runtimeType.toString() ?? "-")),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox();
                                        }).toList() ??
                                        <Widget>[const EmptyView()],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 30),
                          Expanded(
                            flex: 2,
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
                                  STxt(
                                    txt: "Additional Details",
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
                                                      child: STxt(
                                                          txt: element.key
                                                              .replaceAll("_", " ")
                                                              .toString()
                                                              .trimLeft()
                                                              .capitalize
                                                              .toString(),
                                                          style: const TextStyle(color: Clr.greyColor))),
                                                  const SizedBox(width: 10),
                                                  Expanded(flex: 9, child: STxt(txt: element.value?.toString() ?? "-")),
                                                ],
                                              ),
                                            ),
                                          );
                                        }).toList() ??
                                        <Widget>[const EmptyView()],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
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
                                  STxt(
                                    txt: "Diamond Details",
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
                                                      child: STxt(
                                                          txt: element.key
                                                              .replaceAll("_", " ")
                                                              .toString()
                                                              .trimLeft()
                                                              .capitalize
                                                              .toString(),
                                                          style: const TextStyle(color: Clr.greyColor))),
                                                  const SizedBox(width: 10),
                                                  Expanded(flex: 4, child: STxt(txt: element.value?.toString() ?? "-")),
                                                ],
                                              ),
                                            ),
                                          );
                                        }).toList() ??
                                        <Widget>[const EmptyView()],
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
                                  STxt(
                                    txt: "Side Diamond Details",
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
                                                      child: STxt(
                                                          txt: element.key
                                                              .replaceAll("_", " ")
                                                              .toString()
                                                              .trimLeft()
                                                              .capitalize
                                                              .toString(),
                                                          style: const TextStyle(color: Clr.greyColor))),
                                                  const SizedBox(width: 10),
                                                  Expanded(flex: 4, child: STxt(txt: element.value?.toString() ?? "-")),
                                                ],
                                              ),
                                            ),
                                          );
                                        }).toList() ??
                                        <Widget>[const EmptyView()],
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
    );
  }
}
