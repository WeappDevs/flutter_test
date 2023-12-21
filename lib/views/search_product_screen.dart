import 'package:admin_web_app/controllers/index_controller.dart';
import 'package:admin_web_app/models/fitter_model.dart';
import 'package:admin_web_app/utils/colors.dart';
import 'package:admin_web_app/utils/common_componets/common_text_field.dart';
import 'package:admin_web_app/utils/strings.dart';
import 'package:admin_web_app/utils/text_field_styles.dart';
import 'package:admin_web_app/utils/text_styles.dart';
import 'package:admin_web_app/views/widgets/hover_menu_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchProductScreen extends StatelessWidget {
  const SearchProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IndexController controller = Get.find<IndexController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
          ),
          Text(
            "Search Product",
            style: CustomTextStyle.screenHeadingStyle,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: .8,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Clr.greyColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 30),
          CommonTextField(
            decoration: CustomTextFieldStyle.normalFieldDecoration.copyWith(
              hintText: "Search Product Here.....",
              prefixIcon: const Icon(Icons.manage_search_rounded),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(right: 70),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Spacer(),
                HoverMenuButton(
                  btnText: "Shape",
                  filterList: controller.shapeFilterList,
                  selectedFilterList: controller.selectedFilterList,
                  isSingleSelection: true,
                ),
                HoverMenuButton(
                  btnText: "Color Hue",
                  filterList: controller.colorHueFilterList,
                  selectedFilterList: controller.selectedFilterList,
                ),
                HoverMenuButton(
                  btnText: "metal",
                  filterList: controller.metalFilterList,
                  selectedFilterList: controller.selectedFilterList,
                ),
                HoverMenuButton(
                  btnText: "Price",
                  filterList: controller.priceFilterList,
                  selectedFilterList: controller.selectedFilterList,
                ),
                HoverMenuButton(
                  btnText: "Clarity",
                  filterList: controller.clarityFilterList,
                  selectedFilterList: controller.selectedFilterList,
                ),
                HoverMenuButton(
                  btnText: "Gender",
                  filterList: controller.genderFilterList,
                  selectedFilterList: controller.selectedFilterList,
                  isSingleSelection: true,
                ),
                HoverMenuButton(
                  btnText: "Availability By",
                  filterList: controller.inStockFilterList,
                  selectedFilterList: controller.selectedFilterList,
                  isSingleSelection: true,
                ),
                HoverMenuButton(
                  btnText: "Short By",
                  filterList: controller.shortByFilterList,
                  selectedFilterList: controller.selectedFilterList,
                  isSingleSelection: true,
                ),
              ],
            ),
          ),
          const Divider(),
          const SizedBox(height: 20),
          Obx(() {
            return (controller.selectedFilterList.isEmpty != true)
                ? Row(
                    children: [
                      Expanded(
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: List.generate(
                              controller.selectedFilterList.length, (index) {
                            FilterModel element =
                                controller.selectedFilterList[index];

                            return Padding(
                              padding: const EdgeInsets.only(right: 0),
                              child: Chip(
                                label: Text(element.filterText),
                                deleteIcon: const Icon(Icons.cancel_rounded),
                                onDeleted: () {
                                  controller.onDeleteFilterBtnTapped(
                                      element: element, index: index);
                                },
                              ),
                            );
                          }),
                        ),
                      ),
                      FloatingActionButton(
                        mini: true,
                        tooltip: "Reset all filter",
                        onPressed: controller.onResetAllBtnTapped,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        child: const Icon(Icons.cancel_presentation_rounded),
                      )
                    ],
                  )
                : const SizedBox();
          }),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
