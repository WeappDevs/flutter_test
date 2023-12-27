import 'dart:math';
import 'dart:typed_data';
import 'package:admin_web_app/controllers/index_controller.dart';
import 'package:admin_web_app/models/add_product/category_list_model.dart';
import 'package:admin_web_app/models/color_model.dart';
import 'package:admin_web_app/models/memory_file_model.dart';
import 'package:admin_web_app/models/metal_model.dart';
import 'package:admin_web_app/models/shape_model.dart';
import 'package:admin_web_app/models/visual_detail_model.dart';
import 'package:admin_web_app/utils/colors.dart';
import 'package:admin_web_app/utils/common_componets/add_btn.dart';
import 'package:admin_web_app/utils/common_componets/common_dropdown.dart';
import 'package:admin_web_app/utils/common_componets/common_text_field.dart';
import 'package:admin_web_app/utils/common_componets/hover_button.dart';
import 'package:admin_web_app/utils/consts.dart';
import 'package:admin_web_app/utils/text_field_styles.dart';
import 'package:admin_web_app/utils/text_styles.dart';
import 'package:admin_web_app/utils/validate.dart';
import 'package:admin_web_app/views/widgets/mini_video_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IndexController controller = Get.find<IndexController>();

    return Form(
      key: controller.formValidateKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Add Product",
                  style: CustomTextStyle.screenHeadingStyle,
                ),
                Tooltip(
                  message: "Reset Form",
                  child: InkWell(
                    onTap: controller.onResetFormBtnTapped,
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        border: Border.all(width: .8, color: Clr.redColor),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      alignment: Alignment.center,
                      child: const Icon(Icons.cancel_presentation_rounded,
                          color: Clr.redColor, size: 20),
                    ),
                  ),
                )
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [

                      ///Basic Details...................................................................................
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Clr.whiteColor,
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Basic Details",
                              style: CustomTextStyle.infoHeadingStyle,
                            ),
                            const SizedBox(height: 15),
                            Text(
                              "Product Name",
                              style: CustomTextStyle.fieldTitleStyle,
                            ),
                            const SizedBox(height: 5),
                            CommonTextField(
                              controller: controller.productNameController,
                              validateType: Validate.ProductName,
                            ),
                            const SizedBox(height: 15),
                            Text(
                              "Product SubTitle",
                              style: CustomTextStyle.fieldTitleStyle,
                            ),
                            const SizedBox(height: 5),
                            CommonTextField(
                              controller: controller.productSubTitleController,
                              validateType: Validate.ProductSubTitle,
                            ),
                            const SizedBox(height: 15),
                            Text(
                              "Product Details",
                              style: CustomTextStyle.fieldTitleStyle,
                            ),
                            const SizedBox(height: 5),
                            CommonTextField(
                              maxLines: 3,
                              controller: controller.productDetailsController,
                              validateType: Validate.Description,
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  flex: 3,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Product Type",
                                            style:
                                            CustomTextStyle.fieldTitleStyle,
                                          ),
                                          const SizedBox(width: 5),
                                          const Tooltip(
                                            message:
                                            "This defines the type of the product.",
                                            child: Icon(
                                              Icons.info_rounded,
                                              color: Clr.darkGreyColor,
                                              size: 17,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Obx(() =>
                                          CommonDropDownButton(
                                            selectedDropDownValue: controller
                                                .selectedProductCategoryID,
                                            items: controller
                                                .categoryListModel.value?.data
                                                ?.map((CtDatum value) {
                                              return DropdownMenuItem<String>(
                                                value: value.id,
                                                child: Text(value.categoryName
                                                    .toString()),
                                              );
                                            }).toList(),
                                            isNotEmpty: true,
                                            isNotEmptyMessage:
                                            "Please select the product type.",
                                            onChanged: (newVal) {
                                              controller
                                                  .onProductTypeDropDownChanged(
                                                  newVal: newVal);
                                            },
                                          )),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  flex: 2,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Gender",
                                        style: CustomTextStyle.fieldTitleStyle,
                                      ),
                                      const SizedBox(height: 5),
                                      CommonDropDownButton(
                                        selectedDropDownValue:
                                        controller.selectedGender,
                                        dropdownList: controller.genderList,
                                        isNotEmpty: true,
                                        isNotEmptyMessage:
                                        "Please select the gender.",
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  flex: 2,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "General Price",
                                        style: CustomTextStyle.fieldTitleStyle,
                                      ),
                                      const SizedBox(height: 5),
                                      CommonTextField(
                                        decoration: CustomTextFieldStyle
                                            .normalFieldDecoration
                                            .copyWith(
                                            prefixIcon: const Icon(Icons
                                                .currency_rupee_rounded)),
                                        controller: controller
                                            .productGeneralPriceController,
                                        validateType: Validate.FloatNumeric,
                                        isNotEmptyValidator: true,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),

                      ///Additional Details..........................................................................
                      Obx(() {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            ///Ring Style...............................................................................
                            if (controller.selectedProductType.value ==
                                Consts.ringKey) ...[
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Clr.whiteColor,
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Additional Details",
                                          style:
                                          CustomTextStyle.infoHeadingStyle,
                                        ),
                                        const SizedBox(width: 5),
                                        const Tooltip(
                                          message:
                                          "Please consider providing additional details to enhance\nthe customer's understanding of the product.",
                                          child: Icon(
                                            Icons.info_rounded,
                                            color: Clr.darkGreyColor,
                                            size: 17,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 15),
                                    Text(
                                      "Product SKU(Stock Keeping Unit)",
                                      style: CustomTextStyle.fieldTitleStyle,
                                    ),
                                    const SizedBox(height: 5),
                                    CommonTextField(
                                      controller: controller.skuController,
                                      validateType: Validate.SKU,
                                    ),
                                    const SizedBox(height: 15),
                                    Text(
                                      "Style",
                                      style: CustomTextStyle.fieldTitleStyle,
                                    ),
                                    const SizedBox(height: 5),
                                    CommonDropDownButton(
                                      selectedDropDownValue:
                                      controller.selectedRingStyle,
                                      dropdownList: controller.ringStyleList,
                                      isNotEmpty: true,
                                      isNotEmptyMessage:
                                      "Please select the style",
                                    ),
                                    const SizedBox(height: 15),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Flexible(
                                          flex: 2,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "General Rhodium Plated",
                                                style: CustomTextStyle
                                                    .fieldTitleStyle,
                                              ),
                                              const SizedBox(height: 5),
                                              CommonDropDownButton(
                                                selectedDropDownValue: controller
                                                    .selectedGeneralRhodiumPlated,
                                                dropdownList: controller
                                                    .generalRhodiumPlatedList,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Flexible(
                                          flex: 2,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Average Width (mm)",
                                                style: CustomTextStyle
                                                    .fieldTitleStyle,
                                              ),
                                              const SizedBox(height: 5),
                                              CommonTextField(
                                                decoration: CustomTextFieldStyle
                                                    .normalFieldDecoration
                                                    .copyWith(
                                                  prefixIcon: const Icon(
                                                      Icons.linear_scale),
                                                ),
                                                controller: controller
                                                    .averageWidthController,
                                                validateType:
                                                Validate.FloatNumeric,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Flexible(
                                          flex: 2,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Carat Total Weight",
                                                style: CustomTextStyle
                                                    .fieldTitleStyle,
                                              ),
                                              const SizedBox(height: 5),
                                              CommonTextField(
                                                controller: controller
                                                    .caratTotalWeightController,
                                                validateType:
                                                Validate.FloatNumeric,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 30),
                            ]

                            ///Earring Style...............................................................................
                            else
                              if (controller.selectedProductType.value ==
                                  Consts.earringKey) ...[
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Clr.whiteColor,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Additional Details",
                                            style:
                                            CustomTextStyle.infoHeadingStyle,
                                          ),
                                          const SizedBox(width: 5),
                                          const Tooltip(
                                            message:
                                            "Please consider providing additional details to enhance\nthe customer's understanding of the product.",
                                            child: Icon(
                                              Icons.info_rounded,
                                              color: Clr.darkGreyColor,
                                              size: 17,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 15),
                                      Text(
                                        "Product SKU(Stock Keeping Unit)",
                                        style: CustomTextStyle.fieldTitleStyle,
                                      ),
                                      const SizedBox(height: 5),
                                      CommonTextField(
                                        controller: controller.skuController,
                                        validateType: Validate.SKU,
                                      ),
                                      const SizedBox(height: 15),
                                      Text(
                                        "Style",
                                        style: CustomTextStyle.fieldTitleStyle,
                                      ),
                                      const SizedBox(height: 5),
                                      CommonDropDownButton(
                                        selectedDropDownValue:
                                        controller.selectedEarringStyle,
                                        dropdownList: controller
                                            .earringStyleList,
                                        isNotEmpty: true,
                                        isNotEmptyMessage:
                                        "Please select the style",
                                      ),
                                      const SizedBox(height: 15),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Flexible(
                                            flex: 2,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "General Rhodium Plated",
                                                  style: CustomTextStyle
                                                      .fieldTitleStyle,
                                                ),
                                                const SizedBox(height: 5),
                                                CommonDropDownButton(
                                                  selectedDropDownValue: controller
                                                      .selectedGeneralRhodiumPlated,
                                                  dropdownList: controller
                                                      .generalRhodiumPlatedList,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Flexible(
                                            flex: 2,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Carat Total Weight",
                                                  style: CustomTextStyle
                                                      .fieldTitleStyle,
                                                ),
                                                const SizedBox(height: 5),
                                                CommonTextField(
                                                  controller: controller
                                                      .caratTotalWeightController,
                                                  validateType:
                                                  Validate.FloatNumeric,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 15),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Flexible(
                                            flex: 2,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Back Type",
                                                  style: CustomTextStyle
                                                      .fieldTitleStyle,
                                                ),
                                                const SizedBox(height: 5),
                                                CommonDropDownButton(
                                                  selectedDropDownValue: controller
                                                      .selectedEarringBackType,
                                                  dropdownList: controller
                                                      .earringBackTypeList,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Flexible(
                                            flex: 2,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Earring Length (inches)",
                                                  style: CustomTextStyle
                                                      .fieldTitleStyle,
                                                ),
                                                const SizedBox(height: 5),
                                                CommonTextField(
                                                  decoration: CustomTextFieldStyle
                                                      .normalFieldDecoration
                                                      .copyWith(
                                                    prefixIcon: Transform
                                                        .rotate(
                                                      angle: 90 / 180 * pi,
                                                      child: const Icon(
                                                          Icons.linear_scale),
                                                    ),
                                                  ),
                                                  controller: controller
                                                      .earringLengthController,
                                                  validateType:
                                                  Validate.FloatNumeric,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Flexible(
                                            flex: 2,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Earring Width (inches)",
                                                  style: CustomTextStyle
                                                      .fieldTitleStyle,
                                                ),
                                                const SizedBox(height: 5),
                                                CommonTextField(
                                                  decoration: CustomTextFieldStyle
                                                      .normalFieldDecoration
                                                      .copyWith(
                                                    prefixIcon: const Icon(
                                                        Icons.linear_scale),
                                                  ),
                                                  controller: controller
                                                      .earringWidthController,
                                                  validateType:
                                                  Validate.FloatNumeric,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 30),
                              ]

                              ///Necklace Style...............................................................................
                              else
                                if (controller.selectedProductType.value ==
                                    Consts.necklaceKey) ...[
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Clr.whiteColor,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 15),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Additional Details",
                                              style:
                                              CustomTextStyle.infoHeadingStyle,
                                            ),
                                            const SizedBox(width: 5),
                                            const Tooltip(
                                              message:
                                              "Please consider providing additional details to enhance\nthe customer's understanding of the product.",
                                              child: Icon(
                                                Icons.info_rounded,
                                                color: Clr.darkGreyColor,
                                                size: 17,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 15),
                                        Text(
                                          "Product SKU(Stock Keeping Unit)",
                                          style: CustomTextStyle
                                              .fieldTitleStyle,
                                        ),
                                        const SizedBox(height: 5),
                                        CommonTextField(
                                          controller: controller.skuController,
                                          validateType: Validate.SKU,
                                        ),
                                        const SizedBox(height: 15),
                                        Text(
                                          "Style",
                                          style: CustomTextStyle
                                              .fieldTitleStyle,
                                        ),
                                        const SizedBox(height: 5),
                                        CommonDropDownButton(
                                          selectedDropDownValue:
                                          controller.selectedNecklaceStyle,
                                          dropdownList:
                                          controller.necklaceStyleList,
                                          isNotEmpty: true,
                                          isNotEmptyMessage:
                                          "Please select the style",
                                        ),
                                        const SizedBox(height: 15),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Flexible(
                                              flex: 2,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "General Rhodium Plated",
                                                    style: CustomTextStyle
                                                        .fieldTitleStyle,
                                                  ),
                                                  const SizedBox(height: 5),
                                                  CommonDropDownButton(
                                                    selectedDropDownValue: controller
                                                        .selectedGeneralRhodiumPlated,
                                                    dropdownList: controller
                                                        .generalRhodiumPlatedList,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Flexible(
                                              flex: 2,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Carat Total Weight",
                                                    style: CustomTextStyle
                                                        .fieldTitleStyle,
                                                  ),
                                                  const SizedBox(height: 5),
                                                  CommonTextField(
                                                    controller: controller
                                                        .caratTotalWeightController,
                                                    validateType:
                                                    Validate.FloatNumeric,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 15),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Flexible(
                                              flex: 2,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Pendant Length (inches)",
                                                    style: CustomTextStyle
                                                        .fieldTitleStyle,
                                                  ),
                                                  const SizedBox(height: 5),
                                                  CommonTextField(
                                                    decoration: CustomTextFieldStyle
                                                        .normalFieldDecoration
                                                        .copyWith(
                                                      prefixIcon: Transform
                                                          .rotate(
                                                        angle: 90 / 180 * pi,
                                                        child: const Icon(
                                                            Icons.linear_scale),
                                                      ),
                                                    ),
                                                    controller: controller
                                                        .pendantLengthController,
                                                    validateType:
                                                    Validate.FloatNumeric,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Flexible(
                                              flex: 2,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Pendant Width (inches)",
                                                    style: CustomTextStyle
                                                        .fieldTitleStyle,
                                                  ),
                                                  const SizedBox(height: 5),
                                                  CommonTextField(
                                                    decoration: CustomTextFieldStyle
                                                        .normalFieldDecoration
                                                        .copyWith(
                                                      prefixIcon: const Icon(
                                                          Icons.linear_scale),
                                                    ),
                                                    controller: controller
                                                        .pendantWidthController,
                                                    validateType:
                                                    Validate.FloatNumeric,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Flexible(
                                              flex: 2,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Chain Length (inches)",
                                                    style: CustomTextStyle
                                                        .fieldTitleStyle,
                                                  ),
                                                  const SizedBox(height: 5),
                                                  CommonTextField(
                                                    decoration: CustomTextFieldStyle
                                                        .normalFieldDecoration
                                                        .copyWith(
                                                      prefixIcon: Transform
                                                          .rotate(
                                                        angle: 90 / 180 * pi,
                                                        child: const Icon(
                                                            Icons.linear_scale),
                                                      ),
                                                    ),
                                                    controller: controller
                                                        .chainLengthController,
                                                    validateType:
                                                    Validate.FloatNumeric,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Flexible(
                                              flex: 2,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Chain Width (inches)",
                                                    style: CustomTextStyle
                                                        .fieldTitleStyle,
                                                  ),
                                                  const SizedBox(height: 5),
                                                  CommonTextField(
                                                    decoration: CustomTextFieldStyle
                                                        .normalFieldDecoration
                                                        .copyWith(
                                                      prefixIcon: const Icon(
                                                          Icons.linear_scale),
                                                    ),
                                                    controller: controller
                                                        .chainWidthController,
                                                    validateType:
                                                    Validate.FloatNumeric,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 15),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Flexible(
                                              flex: 2,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Chain Type",
                                                    style: CustomTextStyle
                                                        .fieldTitleStyle,
                                                  ),
                                                  const SizedBox(height: 5),
                                                  CommonDropDownButton(
                                                    selectedDropDownValue:
                                                    controller
                                                        .selectedChainType,
                                                    dropdownList:
                                                    controller.chainTypeList,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Flexible(
                                              flex: 2,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Clasp Type",
                                                    style: CustomTextStyle
                                                        .fieldTitleStyle,
                                                  ),
                                                  const SizedBox(height: 5),
                                                  CommonDropDownButton(
                                                    selectedDropDownValue:
                                                    controller
                                                        .selectedClaspType,
                                                    dropdownList:
                                                    controller.claspTypeList,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                ]

                                ///Bracelet Style...............................................................................
                                else
                                  if (controller.selectedProductType.value ==
                                      Consts.braceletKey) ...[
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Clr.whiteColor,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 15),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Additional Details",
                                                style:
                                                CustomTextStyle
                                                    .infoHeadingStyle,
                                              ),
                                              const SizedBox(width: 5),
                                              const Tooltip(
                                                message:
                                                "Please consider providing additional details to enhance\nthe customer's understanding of the product.",
                                                child: Icon(
                                                  Icons.info_rounded,
                                                  color: Clr.darkGreyColor,
                                                  size: 17,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 15),
                                          Text(
                                            "Product SKU(Stock Keeping Unit)",
                                            style: CustomTextStyle
                                                .fieldTitleStyle,
                                          ),
                                          const SizedBox(height: 5),
                                          CommonTextField(
                                            controller: controller
                                                .skuController,
                                            validateType: Validate.SKU,
                                          ),
                                          const SizedBox(height: 15),
                                          Text(
                                            "Style",
                                            style: CustomTextStyle
                                                .fieldTitleStyle,
                                          ),
                                          const SizedBox(height: 5),
                                          CommonDropDownButton(
                                            selectedDropDownValue:
                                            controller.selectedBraceletStyle,
                                            dropdownList:
                                            controller.braceletStyleList,
                                            isNotEmpty: true,
                                            isNotEmptyMessage:
                                            "Please select the style",
                                          ),
                                          const SizedBox(height: 15),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Flexible(
                                                flex: 2,
                                                child: Column(
                                                  mainAxisSize: MainAxisSize
                                                      .min,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "General Rhodium Plated",
                                                      style: CustomTextStyle
                                                          .fieldTitleStyle,
                                                    ),
                                                    const SizedBox(height: 5),
                                                    CommonDropDownButton(
                                                      selectedDropDownValue: controller
                                                          .selectedGeneralRhodiumPlated,
                                                      dropdownList: controller
                                                          .generalRhodiumPlatedList,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Flexible(
                                                flex: 2,
                                                child: Column(
                                                  mainAxisSize: MainAxisSize
                                                      .min,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Carat Total Weight",
                                                      style: CustomTextStyle
                                                          .fieldTitleStyle,
                                                    ),
                                                    const SizedBox(height: 5),
                                                    CommonTextField(
                                                      controller: controller
                                                          .caratTotalWeightController,
                                                      validateType:
                                                      Validate.FloatNumeric,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 15),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Flexible(
                                                flex: 2,
                                                child: Column(
                                                  mainAxisSize: MainAxisSize
                                                      .min,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Bracelet Length (inches)",
                                                      style: CustomTextStyle
                                                          .fieldTitleStyle,
                                                    ),
                                                    const SizedBox(height: 5),
                                                    CommonTextField(
                                                      decoration: CustomTextFieldStyle
                                                          .normalFieldDecoration
                                                          .copyWith(
                                                        prefixIcon: Transform
                                                            .rotate(
                                                          angle: 90 / 180 * pi,
                                                          child: const Icon(
                                                              Icons
                                                                  .linear_scale),
                                                        ),
                                                      ),
                                                      controller: controller
                                                          .braceletLengthController,
                                                      validateType:
                                                      Validate.FloatNumeric,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Flexible(
                                                flex: 2,
                                                child: Column(
                                                  mainAxisSize: MainAxisSize
                                                      .min,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Bracelet Width (inches)",
                                                      style: CustomTextStyle
                                                          .fieldTitleStyle,
                                                    ),
                                                    const SizedBox(height: 5),
                                                    CommonTextField(
                                                      decoration: CustomTextFieldStyle
                                                          .normalFieldDecoration
                                                          .copyWith(
                                                        prefixIcon: const Icon(
                                                            Icons.linear_scale),
                                                      ),
                                                      controller: controller
                                                          .braceletWidthController,
                                                      validateType:
                                                      Validate.FloatNumeric,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Flexible(
                                                flex: 2,
                                                child: Column(
                                                  mainAxisSize: MainAxisSize
                                                      .min,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Clasp Type",
                                                      style: CustomTextStyle
                                                          .fieldTitleStyle,
                                                    ),
                                                    const SizedBox(height: 5),
                                                    CommonDropDownButton(
                                                      selectedDropDownValue:
                                                      controller
                                                          .selectedClaspType,
                                                      dropdownList:
                                                      controller.claspTypeList,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                  ]
                          ],
                        );
                      }),

                      ///Diamond Details...............................................................................
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Clr.whiteColor,
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Diamond Details",
                              style: CustomTextStyle.infoHeadingStyle,
                            ),
                            const SizedBox(height: 15),
                            Text(
                              "Stone Type",
                              style: CustomTextStyle.fieldTitleStyle,
                            ),
                            const SizedBox(height: 5),
                            CommonDropDownButton(
                              selectedDropDownValue:
                              controller.selectedStoneType,
                              dropdownList: controller.stoneTypeList,
                            ),
                            const SizedBox(height: 15),
                            Text(
                              "Creation Method",
                              style: CustomTextStyle.fieldTitleStyle,
                            ),
                            const SizedBox(height: 5),
                            CommonDropDownButton(
                              selectedDropDownValue:
                              controller.selectedCreationMethod,
                              dropdownList: controller.creationMethodList,
                            ),
                            const SizedBox(height: 15),
                            Text(
                              "Shape",
                              style: CustomTextStyle.fieldTitleStyle,
                            ),
                            const SizedBox(height: 5),
                            Wrap(
                              children: List.generate(
                                  controller.shapeList.length, (index) {
                                ShapeModel element =
                                controller.shapeList[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: InkWell(
                                    onTap: () {
                                      controller.onShapeTapped(
                                          index: index,
                                          shapeList: controller.shapeList);
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Obx(() =>
                                            Image.asset(
                                              element.shapePath,
                                              height: 55,
                                              fit: BoxFit.fitHeight,
                                              color: (element.isSelectedTab
                                                  .value ==
                                                  true)
                                                  ? Clr.primaryColor
                                                  : null,
                                            )),
                                        const SizedBox(height: 3),
                                        Obx(() =>
                                            Text(
                                              element.shapeName,
                                              style: (element.isSelectedTab
                                                  .value ==
                                                  true)
                                                  ? CustomTextStyle
                                                  .smallPrimaryStyle
                                                  : CustomTextStyle
                                                  .smallBlackStyle,
                                            )),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  flex: 3,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Color",
                                        style: CustomTextStyle.fieldTitleStyle,
                                      ),
                                      const SizedBox(height: 5),
                                      CommonDropDownButton(
                                        selectedDropDownValue:
                                        controller.selectedColor,
                                        items: controller.colorList
                                            .map((ColorModel value) {
                                          return DropdownMenuItem<String>(
                                            value: value.colorName,
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 20,
                                                  width: 20,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: value.color,
                                                    border:
                                                    Border.all(width: .2),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Text(
                                                    value.colorName.toString()),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                        isNotEmpty: true,
                                        isNotEmptyMessage:
                                        "Please select the color",
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Flexible(
                                  flex: 3,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Color Hue",
                                        style: CustomTextStyle.fieldTitleStyle,
                                      ),
                                      const SizedBox(height: 5),
                                      CommonDropDownButton(
                                        selectedDropDownValue:
                                        controller.selectedColorHue,
                                        items: controller.colorHueList
                                            .map((ColorModel value) {
                                          return DropdownMenuItem<String>(
                                            value: value.colorName,
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 20,
                                                  width: 20,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: value.color,
                                                    border:
                                                    Border.all(width: .2),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Text(
                                                    value.colorName.toString()),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                        isNotEmpty: true,
                                        isNotEmptyMessage:
                                        "Please select the color hue",
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Flexible(
                                  flex: 3,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Clarity",
                                        style: CustomTextStyle.fieldTitleStyle,
                                      ),
                                      const SizedBox(height: 5),
                                      CommonDropDownButton(
                                        selectedDropDownValue:
                                        controller.selectedClarity,
                                        dropdownList: controller.clarityList,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Flexible(
                                  flex: 3,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Cut Grade",
                                        style: CustomTextStyle.fieldTitleStyle,
                                      ),
                                      const SizedBox(height: 5),
                                      CommonDropDownButton(
                                        selectedDropDownValue:
                                        controller.selectedCutGrade,
                                        items: controller.cutGradeList
                                            .map<DropdownMenuItem<String>>(
                                                (String? value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Row(
                                                  children: [
                                                    for (int i = 0;
                                                    i <
                                                        (controller.cutGradeList
                                                            .indexOf(
                                                            value ??
                                                                "") +
                                                            1);
                                                    i++) ...[
                                                      const Icon(Icons.star,
                                                          size: 17,
                                                          color: Clr
                                                              .primaryColor),
                                                    ],
                                                    const SizedBox(width: 10),
                                                    Text(value.toString()),
                                                  ],
                                                ),
                                              );
                                            }).toList(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  flex: 2,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Count",
                                        style: CustomTextStyle.fieldTitleStyle,
                                      ),
                                      const SizedBox(height: 5),
                                      CommonTextField(
                                        controller: controller.countController,
                                        validateType: Validate.RoundNumeric,
                                        isNotEmptyValidator: true,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Flexible(
                                  flex: 2,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Carat Weight",
                                        style: CustomTextStyle.fieldTitleStyle,
                                      ),
                                      const SizedBox(height: 5),
                                      CommonTextField(
                                        controller:
                                        controller.caratWeightController,
                                        validateType: Validate.FloatNumeric,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Flexible(
                                  flex: 2,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Total  Carat Weight",
                                        style: CustomTextStyle.fieldTitleStyle,
                                      ),
                                      const SizedBox(height: 5),
                                      CommonTextField(
                                        controller: controller
                                            .totalCaratWeightController,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Text(
                              "Setting",
                              style: CustomTextStyle.fieldTitleStyle,
                            ),
                            const SizedBox(height: 5),
                            CommonDropDownButton(
                              selectedDropDownValue: controller.selectedSetting,
                              dropdownList: controller.settingList,
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Flexible(
                                  flex: 3,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Polish",
                                        style: CustomTextStyle.fieldTitleStyle,
                                      ),
                                      const SizedBox(height: 5),
                                      CommonDropDownButton(
                                        selectedDropDownValue:
                                        controller.selectedPolish,
                                        items: controller.polishList
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Row(
                                                  children: [
                                                    for (int i = 0;
                                                    i <
                                                        (controller.cutGradeList
                                                            .indexOf(
                                                            value) +
                                                            1);
                                                    i++) ...[
                                                      const Icon(Icons.star,
                                                          size: 17,
                                                          color: Clr
                                                              .primaryColor),
                                                    ],
                                                    const SizedBox(width: 10),
                                                    Text(value.toString()),
                                                  ],
                                                ),
                                              );
                                            }).toList(),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Flexible(
                                  flex: 3,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Symmetry",
                                        style: CustomTextStyle.fieldTitleStyle,
                                      ),
                                      const SizedBox(height: 5),
                                      CommonDropDownButton(
                                        selectedDropDownValue:
                                        controller.selectedSymmetry,
                                        items: controller.symmetryList
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Row(
                                                  children: [
                                                    for (int i = 0;
                                                    i <
                                                        (controller.cutGradeList
                                                            .indexOf(
                                                            value) +
                                                            1);
                                                    i++) ...[
                                                      const Icon(Icons.star,
                                                          size: 17,
                                                          color: Clr
                                                              .primaryColor),
                                                    ],
                                                    const SizedBox(width: 10),
                                                    Text(value.toString()),
                                                  ],
                                                ),
                                              );
                                            }).toList(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Flexible(
                                  flex: 2,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Depth",
                                        style: CustomTextStyle.fieldTitleStyle,
                                      ),
                                      const SizedBox(height: 5),
                                      CommonTextField(
                                        decoration: CustomTextFieldStyle
                                            .normalFieldDecoration
                                            .copyWith(
                                            suffixIcon:
                                            const Icon(Icons.percent)),
                                        controller: controller.depthController,
                                        validateType: Validate.FloatNumeric,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Flexible(
                                  flex: 2,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Table",
                                        style: CustomTextStyle.fieldTitleStyle,
                                      ),
                                      const SizedBox(height: 5),
                                      CommonTextField(
                                        decoration: CustomTextFieldStyle
                                            .normalFieldDecoration
                                            .copyWith(
                                            suffixIcon:
                                            const Icon(Icons.percent)),
                                        controller: controller.tableController,
                                        validateType: Validate.FloatNumeric,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Flexible(
                                  flex: 2,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Measurements",
                                        style: CustomTextStyle.fieldTitleStyle,
                                      ),
                                      const SizedBox(height: 5),
                                      CommonTextField(
                                        decoration: CustomTextFieldStyle
                                            .normalFieldDecoration
                                            .copyWith(
                                            suffixIcon: const Icon(
                                                Icons.content_cut_rounded)),
                                        controller:
                                        controller.measurementsController,
                                        validateType: Validate.Measurement,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),

                      ///Side Diamond Details...............................................................................
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Clr.whiteColor,
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Side Diamond Details(Optional)",
                                  style: CustomTextStyle.infoHeadingStyle,
                                ),
                                const SizedBox(width: 5),
                                const Tooltip(
                                  message:
                                  "Add the 'Side Diamond Detail' when product has the multiple diamonds.",
                                  child: Icon(
                                    Icons.info_rounded,
                                    color: Clr.darkGreyColor,
                                    size: 17,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "(Add the 'Side Diamond Detail' when product has the multiple diamonds.)",
                              style: CustomTextStyle.fieldDescStyle,
                            ),
                            Obx(
                                  () =>
                              (controller
                                  .isShowSideDiamondDetails.value ==
                                  true)
                                  ? Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 15),
                                  Text(
                                    "Stone Type",
                                    style:
                                    CustomTextStyle.fieldTitleStyle,
                                  ),
                                  const SizedBox(height: 5),
                                  CommonDropDownButton(
                                    selectedDropDownValue: controller
                                        .selectedSideDiaStoneType,
                                    dropdownList:
                                    controller.stoneTypeList,
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    "Creation Method",
                                    style:
                                    CustomTextStyle.fieldTitleStyle,
                                  ),
                                  const SizedBox(height: 5),
                                  CommonDropDownButton(
                                    selectedDropDownValue: controller
                                        .selectedSideDiaCreationMethod,
                                    dropdownList:
                                    controller.creationMethodList,
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    "Shape",
                                    style:
                                    CustomTextStyle.fieldTitleStyle,
                                  ),
                                  const SizedBox(height: 5),
                                  Wrap(
                                    children: List.generate(
                                        controller.sideDiaShapeList
                                            .length, (index) {
                                      ShapeModel element = controller
                                          .sideDiaShapeList[index];
                                      return Padding(
                                        padding:
                                        const EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 10),
                                        child: InkWell(
                                          onTap: () {
                                            controller.onShapeTapped(
                                                index: index,
                                                shapeList: controller
                                                    .sideDiaShapeList);
                                          },
                                          child: Column(
                                            mainAxisSize:
                                            MainAxisSize.min,
                                            children: [
                                              Obx(() =>
                                                  Image.asset(
                                                    element.shapePath,
                                                    height: 55,
                                                    fit: BoxFit.fitHeight,
                                                    color: (element
                                                        .isSelectedTab
                                                        .value ==
                                                        true)
                                                        ? Clr.primaryColor
                                                        : null,
                                                  )),
                                              const SizedBox(height: 3),
                                              Obx(() =>
                                                  Text(
                                                    element.shapeName,
                                                    style: (element
                                                        .isSelectedTab
                                                        .value ==
                                                        true)
                                                        ? CustomTextStyle
                                                        .smallPrimaryStyle
                                                        : CustomTextStyle
                                                        .smallBlackStyle,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        flex: 3,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Color",
                                              style: CustomTextStyle
                                                  .fieldTitleStyle,
                                            ),
                                            const SizedBox(height: 5),
                                            CommonDropDownButton(
                                              selectedDropDownValue:
                                              controller
                                                  .selectedSideDiaColor,
                                              items: controller.colorList
                                                  .map(
                                                      (ColorModel value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value.colorName,
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            height: 20,
                                                            width: 20,
                                                            decoration:
                                                            BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color:
                                                              value.color,
                                                              border:
                                                              Border.all(
                                                                  width:
                                                                  .2),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 10),
                                                          Text(value.colorName
                                                              .toString()),
                                                        ],
                                                      ),
                                                    );
                                                  }).toList(),
                                              isNotEmpty: true,
                                              isNotEmptyMessage:
                                              "Please select the color",
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Flexible(
                                        flex: 3,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Color Hue",
                                              style: CustomTextStyle
                                                  .fieldTitleStyle,
                                            ),
                                            const SizedBox(height: 5),
                                            CommonDropDownButton(
                                              selectedDropDownValue:
                                              controller
                                                  .selectedSideDiaColorHue,
                                              items: controller
                                                  .colorHueList
                                                  .map(
                                                      (ColorModel value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value.colorName,
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            height: 20,
                                                            width: 20,
                                                            decoration:
                                                            BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color:
                                                              value.color,
                                                              border:
                                                              Border.all(
                                                                  width:
                                                                  .2),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 10),
                                                          Text(value.colorName
                                                              .toString()),
                                                        ],
                                                      ),
                                                    );
                                                  }).toList(),
                                              isNotEmpty: true,
                                              isNotEmptyMessage:
                                              "Please select the color hue",
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Flexible(
                                        flex: 3,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Clarity",
                                              style: CustomTextStyle
                                                  .fieldTitleStyle,
                                            ),
                                            const SizedBox(height: 5),
                                            CommonDropDownButton(
                                              selectedDropDownValue:
                                              controller
                                                  .selectedSideDiaClarity,
                                              dropdownList:
                                              controller.clarityList,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Flexible(
                                        flex: 3,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Cut Grade",
                                              style: CustomTextStyle
                                                  .fieldTitleStyle,
                                            ),
                                            const SizedBox(height: 5),
                                            CommonDropDownButton(
                                              selectedDropDownValue:
                                              controller
                                                  .selectedSideDiaCutGrade,
                                              items: controller
                                                  .cutGradeList
                                                  .map<
                                                  DropdownMenuItem<
                                                      String>>(
                                                      (String? value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Row(
                                                        children: [
                                                          for (int i = 0;
                                                          i <
                                                              (controller
                                                                  .cutGradeList
                                                                  .indexOf(
                                                                  value ??
                                                                      "") +
                                                                  1);
                                                          i++) ...[
                                                            const Icon(
                                                                Icons.star,
                                                                size: 17,
                                                                color: Clr
                                                                    .primaryColor),
                                                          ],
                                                          const SizedBox(
                                                              width: 10),
                                                          Text(value
                                                              .toString()),
                                                        ],
                                                      ),
                                                    );
                                                  }).toList(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Flexible(
                                        flex: 2,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Count",
                                              style: CustomTextStyle
                                                  .fieldTitleStyle,
                                            ),
                                            const SizedBox(height: 5),
                                            CommonTextField(
                                              controller: controller
                                                  .sideDiaCountController,
                                              validateType:
                                              Validate.RoundNumeric,
                                              isNotEmptyValidator: true,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Flexible(
                                        flex: 2,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Carat Weight",
                                              style: CustomTextStyle
                                                  .fieldTitleStyle,
                                            ),
                                            const SizedBox(height: 5),
                                            CommonTextField(
                                              controller: controller
                                                  .sideDiaCaratWeightController,
                                              validateType:
                                              Validate.FloatNumeric,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Flexible(
                                        flex: 2,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Total  Carat Weight",
                                              style: CustomTextStyle
                                                  .fieldTitleStyle,
                                            ),
                                            const SizedBox(height: 5),
                                            CommonTextField(
                                              controller: controller
                                                  .sideDiaTotalCaratWeightController,
                                              validateType:
                                              Validate.FloatNumeric,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    "Setting",
                                    style:
                                    CustomTextStyle.fieldTitleStyle,
                                  ),
                                  const SizedBox(height: 5),
                                  CommonDropDownButton(
                                    selectedDropDownValue:
                                    controller.selectedSideDiaSetting,
                                    dropdownList: controller.settingList,
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Flexible(
                                        flex: 3,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Polish",
                                              style: CustomTextStyle
                                                  .fieldTitleStyle,
                                            ),
                                            const SizedBox(height: 5),
                                            CommonDropDownButton(
                                              selectedDropDownValue:
                                              controller
                                                  .selectedSideDiaPolish,
                                              items: controller.polishList
                                                  .map<
                                                  DropdownMenuItem<
                                                      String>>((String
                                              value) {
                                                return DropdownMenuItem<
                                                    String>(
                                                  value: value,
                                                  child: Row(
                                                    children: [
                                                      for (int i = 0;
                                                      i <
                                                          (controller
                                                              .cutGradeList
                                                              .indexOf(value) +
                                                              1);
                                                      i++) ...[
                                                        const Icon(
                                                            Icons.star,
                                                            size: 17,
                                                            color: Clr
                                                                .primaryColor),
                                                      ],
                                                      const SizedBox(
                                                          width: 10),
                                                      Text(value
                                                          .toString()),
                                                    ],
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Flexible(
                                        flex: 3,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Symmetry",
                                              style: CustomTextStyle
                                                  .fieldTitleStyle,
                                            ),
                                            const SizedBox(height: 5),
                                            CommonDropDownButton(
                                              selectedDropDownValue:
                                              controller
                                                  .selectedSideDiaSymmetry,
                                              items: controller
                                                  .symmetryList
                                                  .map<
                                                  DropdownMenuItem<
                                                      String>>((String
                                              value) {
                                                return DropdownMenuItem<
                                                    String>(
                                                  value: value,
                                                  child: Row(
                                                    children: [
                                                      for (int i = 0;
                                                      i <
                                                          (controller
                                                              .cutGradeList
                                                              .indexOf(value) +
                                                              1);
                                                      i++) ...[
                                                        const Icon(
                                                            Icons.star,
                                                            size: 17,
                                                            color: Clr
                                                                .primaryColor),
                                                      ],
                                                      const SizedBox(
                                                          width: 10),
                                                      Text(value
                                                          .toString()),
                                                    ],
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Flexible(
                                        flex: 2,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Depth",
                                              style: CustomTextStyle
                                                  .fieldTitleStyle,
                                            ),
                                            const SizedBox(height: 5),
                                            CommonTextField(
                                              decoration: CustomTextFieldStyle
                                                  .normalFieldDecoration
                                                  .copyWith(
                                                  suffixIcon:
                                                  const Icon(Icons
                                                      .percent)),
                                              controller: controller
                                                  .sideDiaDepthController,
                                              validateType:
                                              Validate.FloatNumeric,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Flexible(
                                        flex: 2,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Table",
                                              style: CustomTextStyle
                                                  .fieldTitleStyle,
                                            ),
                                            const SizedBox(height: 5),
                                            CommonTextField(
                                              decoration: CustomTextFieldStyle
                                                  .normalFieldDecoration
                                                  .copyWith(
                                                  suffixIcon:
                                                  const Icon(Icons
                                                      .percent)),
                                              controller: controller
                                                  .sideDiaTableController,
                                              validateType:
                                              Validate.FloatNumeric,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Flexible(
                                        flex: 2,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Measurements",
                                              style: CustomTextStyle
                                                  .fieldTitleStyle,
                                            ),
                                            const SizedBox(height: 5),
                                            CommonTextField(
                                              decoration: CustomTextFieldStyle
                                                  .normalFieldDecoration
                                                  .copyWith(
                                                  suffixIcon:
                                                  const Icon(Icons
                                                      .content_cut_rounded)),
                                              controller: controller
                                                  .sideDiaMeasurementsController,
                                              validateType:
                                              Validate.FloatNumeric,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                                  : const SizedBox(),
                            ),
                            const SizedBox(height: 30),
                            Center(
                              child: Obx(() =>
                                  HoverButton(
                                    width: double.infinity,
                                    btnText: (controller
                                        .isShowSideDiamondDetails
                                        .value ==
                                        true)
                                        ? "Remove the Details"
                                        : "Add the Details",
                                    callback:
                                    controller.onSideDiamondDetailsTapped,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),

                      ///Shipping Details...............................................................................
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Clr.whiteColor,
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Shipping Details",
                              style: CustomTextStyle.infoHeadingStyle,
                            ),
                            const SizedBox(height: 5, width: double.infinity),
                            Text(
                              "(Kindly include comprehensive shipping details to enhance the product's reliability.)",
                              style: CustomTextStyle.fieldDescStyle,
                            ),
                            const SizedBox(height: 15),
                            Obx(() =>
                                RadioListTile<String>(
                                  value: ShippingDetailsRadio.Default.name,
                                  groupValue:
                                  controller.selectedShippingDetails.value,
                                  onChanged: (String? value) {
                                    controller.onShippingDetailsRadioChanged(
                                        newVal: value);
                                  },
                                  title: const Text("Default"),
                                )),
                            Obx(() =>
                                Column(
                                  children: [
                                    RadioListTile<String>(
                                      value: ShippingDetailsRadio.Custom.name,
                                      groupValue: controller
                                          .selectedShippingDetails.value,
                                      onChanged: (String? value) {
                                        controller
                                            .onShippingDetailsRadioChanged(
                                            newVal: value);
                                      },
                                      title: const Text("Custom"),
                                    ),
                                    (controller.selectedShippingDetails.value ==
                                        ShippingDetailsRadio.Custom.name)
                                        ? Padding(
                                      padding:
                                      const EdgeInsets.only(left: 30),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Product Custom Shipping Details",
                                            style: CustomTextStyle
                                                .fieldTitleStyle,
                                          ),
                                          const SizedBox(height: 5),
                                          CommonTextField(
                                            maxLines: 3,
                                            controller: controller
                                                .customShippingDetailsController,
                                            validateType:
                                            Validate.Description,
                                          ),
                                        ],
                                      ),
                                    )
                                        : const SizedBox(),
                                  ],
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),

                      ///Return Details...............................................................................
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Clr.whiteColor,
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Return Details",
                              style: CustomTextStyle.infoHeadingStyle,
                            ),
                            const SizedBox(height: 5, width: double.infinity),
                            Text(
                              "(Please incorporate thorough return information to bolster the product's trustworthiness.)",
                              style: CustomTextStyle.fieldDescStyle,
                            ),
                            const SizedBox(height: 15),
                            Obx(() =>
                                RadioListTile<String>(
                                  value: ReturnDetailsRadio.Default.name,
                                  groupValue:
                                  controller.selectedReturnDetails.value,
                                  onChanged: (String? value) {
                                    controller.onReturnDetailsRadioChanged(
                                        newVal: value);
                                  },
                                  title: const Text("Default"),
                                )),
                            Obx(() =>
                                Column(
                                  children: [
                                    RadioListTile<String>(
                                      value: ReturnDetailsRadio.Custom.name,
                                      groupValue: controller
                                          .selectedReturnDetails.value,
                                      onChanged: (String? value) {
                                        controller.onReturnDetailsRadioChanged(
                                            newVal: value);
                                      },
                                      title: const Text("Custom"),
                                    ),
                                    (controller.selectedReturnDetails.value ==
                                        ReturnDetailsRadio.Custom.name)
                                        ? Padding(
                                      padding:
                                      const EdgeInsets.only(left: 30),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Product Custom Returns Details",
                                            style: CustomTextStyle
                                                .fieldTitleStyle,
                                          ),
                                          const SizedBox(height: 5),
                                          CommonTextField(
                                            maxLines: 3,
                                            controller: controller
                                                .customReturnsDetailsController,
                                            validateType:
                                            Validate.Description,
                                          ),
                                        ],
                                      ),
                                    )
                                        : const SizedBox(),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 15),

                ///Visual Details...................................................
                Container(
                  width: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Clr.whiteColor,
                  ),
                  padding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Visual Details",
                        style: CustomTextStyle.infoHeadingStyle,
                      ),
                      Obx(() {
                        return ListView.builder(
                          itemCount: controller.visualDetailsList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            VisualDetailModel element =
                            controller.visualDetailsList[index];

                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${(index + 1)}.",
                                      style: CustomTextStyle.midBlackStyle,
                                    ),
                                    (index != 0)
                                        ? IconButton(
                                      onPressed: () {
                                        controller
                                            .onRemoveVisualDetailsTapped(
                                            index: index);
                                      },
                                      icon: const Icon(
                                          Icons
                                              .cancel_presentation_rounded,
                                          color: Clr.redColor),
                                    )
                                        : const SizedBox(),
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
                                const SizedBox(height: 10),
                                Text(
                                  "Metal Type & Color",
                                  style: CustomTextStyle.fieldTitleStyle,
                                ),
                                const SizedBox(height: 5),
                                CommonDropDownButton(
                                  selectedDropDownValue:
                                  element.selectedMetalType,
                                  items: element.metalTypeList
                                      .map((MetalModel value) {
                                    return DropdownMenuItem<String>(
                                      value: value.metalName,
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 22,
                                            width: 22,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: value.color,
                                              border: Border.all(width: .2),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              value.metalKarat.toString(),
                                              style: CustomTextStyle
                                                  .verySmallMidBlackStyle,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Text(value.metalName.toString()),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                  isNotEmpty: true,
                                  isNotEmptyMessage: "Please select metal type",
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  "Rhodium Plated",
                                  style: CustomTextStyle.fieldTitleStyle,
                                ),
                                const SizedBox(height: 5),
                                CommonDropDownButton(
                                  selectedDropDownValue:
                                  element.selectedRhodiumPlated,
                                  dropdownList: element.rhodiumPlatedList,
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  "Metal Vise Price",
                                  style: CustomTextStyle.fieldTitleStyle,
                                ),
                                const SizedBox(height: 5),
                                CommonTextField(
                                  controller: element.priceController,
                                  decoration: CustomTextFieldStyle
                                      .normalFieldDecoration
                                      .copyWith(
                                    prefixIcon: const Icon(
                                        Icons.currency_rupee_rounded),
                                  ),
                                  validateType: Validate.FloatNumeric,
                                  isNotEmptyValidator: true,
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Product Images",
                                      style: CustomTextStyle.fieldTitleStyle,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        controller.onImagePickerTapped(
                                            index: index, element: element);
                                      },
                                      icon: const Icon(
                                          Icons.add_photo_alternate_rounded),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "(Kindly ensure the careful addition of the picture and video, as they will be prominently displayed at the forefront of the products.)",
                                  style: CustomTextStyle.fieldDescStyle,
                                ),
                                const SizedBox(height: 15),
                                SizedBox(
                                  width: 300,
                                  child: Obx(() =>
                                      Wrap(
                                        children: List.generate(
                                          element.imageList.length,
                                              (i) {
                                            MemoryFileModel? ele =
                                            element.imageList[i];

                                            return Padding(
                                              padding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 7,
                                                  vertical: 7),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                    height: 80,
                                                    width: 80,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          20),
                                                      color: Clr
                                                          .veryLightGreyColor,
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: MemoryImage(ele
                                                            .byteList
                                                            .value ??
                                                            Uint8List(0)),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                    MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        "${i + 1}.",
                                                        style: CustomTextStyle
                                                            .fieldTitleStyle,
                                                      ),
                                                      IconButton(
                                                        onPressed: () {
                                                          controller
                                                              .onImageCancelBtnTapped(
                                                              outerIndex:
                                                              index,
                                                              innerIndex:
                                                              i);
                                                        },
                                                        icon: const Icon(Icons
                                                            .cancel_presentation_rounded),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      )),
                                ),
                                Obx(() =>
                                (element.isImageError.value == true)
                                    ? Column(
                                  children: [
                                    const SizedBox(height: 5),
                                    Text(
                                      "    Please select at least 1 image",
                                      style:
                                      CustomTextStyle.errorRedStyle,
                                    ),
                                  ],
                                )
                                    : const SizedBox()),
                                const SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Product Video",
                                      style: CustomTextStyle.fieldTitleStyle,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        controller.onVideoPickerTapped(
                                            index: index, element: element);
                                      },
                                      icon:
                                      const Icon(Icons.video_call_rounded),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "(Add the one Forfront video.)",
                                  style: CustomTextStyle.fieldDescStyle,
                                ),
                                const SizedBox(height: 15),
                                Obx(() {
                                  return (element
                                      .videoBytesData?.byteList.value !=
                                      null)
                                      ? Column(
                                    children: [
                                      Center(
                                          child: MiniVideoView(
                                              bytes: element
                                                  .videoBytesData
                                                  ?.byteList
                                                  .value)),
                                      const SizedBox(height: 10),
                                    ],
                                  )
                                      : const SizedBox();
                                }),
                                Obx(() =>
                                (element.isVideoError.value == true)
                                    ? Column(
                                  children: [
                                    const SizedBox(height: 5),
                                    Text(
                                      "    Please select video",
                                      style:
                                      CustomTextStyle.errorRedStyle,
                                    ),
                                  ],
                                )
                                    : const SizedBox()),
                                const SizedBox(height: 10),
                                Obx(() =>
                                (element.version.value != 1)
                                    ? HoverButton(
                                  btnText: "Save",
                                  callback: () {
                                    controller.onUploadMediaBtnTapped(
                                        element: element);
                                  },
                                  isLoading: element.isSaveLoading,
                                )
                                    : const SizedBox()),
                                const SizedBox(height: 10),
                                Container(
                                  height: .8,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Clr.greyColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            );
                          },
                        );
                      }),
                      const SizedBox(height: 30),
                      HoverButton(
                        width: double.infinity,
                        btnText: "Add Visual Details",
                        callback: controller.onAddVisualDetailsTapped,
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 70),

            ///Add Product Button...............................................................................
            Center(
              child: AddBtn(
                btnText: "ADD PRODUCT",
                onTap: controller.onAddProductBtnTapped,
                isLoading: controller.isAddBtnLoading,
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
