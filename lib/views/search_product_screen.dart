import 'package:admin_web_app/controllers/index_controller.dart';
import 'package:admin_web_app/models/fitter_model.dart';
import 'package:admin_web_app/models/view_product/view_product_list_model.dart';
import 'package:admin_web_app/utils/colors.dart';
import 'package:admin_web_app/utils/common_componets/common_text_field.dart';
import 'package:admin_web_app/utils/text_field_styles.dart';
import 'package:admin_web_app/utils/text_styles.dart';
import 'package:admin_web_app/utils/validate.dart';
import 'package:admin_web_app/views/widgets/empty_view.dart';
import 'package:admin_web_app/views/widgets/hover_menu_btn.dart';
import 'package:admin_web_app/views/widgets/shimmer_table_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:admin_web_app/views/widgets/s_txt.dart';

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
          STxt(
            txt: "Search Product",
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
              hintText: "Search Product By Name Here.....",
              prefixIcon: const Icon(Icons.manage_search_rounded),
            ),
            controller: controller.searchController,
            onChanged: (value) {
              controller.onSearchFieldAndFilterChanged();
            },
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
                  onChanged: () {
                    controller.onSearchFieldAndFilterChanged();
                  },
                ),
                HoverMenuButton(
                  btnText: "Color Hue",
                  filterList: controller.colorHueFilterList,
                  selectedFilterList: controller.selectedFilterList,
                  onChanged: () {
                    controller.onSearchFieldAndFilterChanged();
                  },
                ),
                HoverMenuButton(
                  btnText: "metal",
                  filterList: controller.metalFilterList,
                  selectedFilterList: controller.selectedFilterList,
                  onChanged: () {
                    controller.onSearchFieldAndFilterChanged();
                  },
                ),
                HoverMenuButton(
                  btnText: "Price",
                  filterList: controller.priceFilterList,
                  selectedFilterList: controller.selectedFilterList,
                  onChanged: () {
                    controller.onSearchFieldAndFilterChanged();
                  },
                ),
                HoverMenuButton(
                  btnText: "Clarity",
                  filterList: controller.clarityFilterList,
                  selectedFilterList: controller.selectedFilterList,
                  onChanged: () {
                    controller.onSearchFieldAndFilterChanged();
                  },
                ),
                HoverMenuButton(
                  btnText: "Gender",
                  filterList: controller.genderFilterList,
                  selectedFilterList: controller.selectedFilterList,
                  onChanged: () {
                    controller.onSearchFieldAndFilterChanged();
                  },
                  isSingleSelection: true,
                ),
                HoverMenuButton(
                  btnText: "Availability By",
                  filterList: controller.inStockFilterList,
                  selectedFilterList: controller.selectedFilterList,
                  isSingleSelection: true,
                  onChanged: () {
                    controller.onSearchFieldAndFilterChanged();
                  },
                ),
                HoverMenuButton(
                  btnText: "Short By",
                  filterList: controller.shortByFilterList,
                  selectedFilterList: controller.selectedFilterList,
                  isSingleSelection: true,
                  onChanged: () {
                    controller.onSearchFieldAndFilterChanged();
                  },
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
                          children: List.generate(controller.selectedFilterList.length, (index) {
                            FilterModel element = controller.selectedFilterList[index];

                            return Padding(
                              padding: const EdgeInsets.only(right: 0),
                              child: Chip(
                                label: Text(element.filterText),
                                deleteIcon: const Icon(Icons.cancel_rounded),
                                onDeleted: () {
                                  controller.onDeleteFilterBtnTapped(element: element, index: index);
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
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        child: const Icon(Icons.cancel_presentation_rounded),
                      )
                    ],
                  )
                : const SizedBox();
          }),
          const SizedBox(height: 30),
          Obx(() => (controller.isTableLoaderShow.value == Loader.Show.name)
              ? const ShimmerProductTableView()
              : (controller.searchProductListModel.value?.data?.isNotEmpty ?? false)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: STxt(
                              txt:
                                  "Total Number Of Record: ${controller.searchProductListModel.value?.totalNumberOfData}",
                              style: CustomTextStyle.tableHeaderStyle),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          decoration: const BoxDecoration(color: Clr.whiteColor),
                          child: Table(
                            border: TableBorder.all(
                                width: .1, color: Clr.greyColor, borderRadius: BorderRadius.circular(5)),
                            defaultVerticalAlignment: TableCellVerticalAlignment.top,
                            columnWidths: const {
                              0: IntrinsicColumnWidth(flex: 1),
                              1: IntrinsicColumnWidth(flex: 2.5),
                              2: IntrinsicColumnWidth(flex: 2.5),
                              3: IntrinsicColumnWidth(flex: 5),
                              4: IntrinsicColumnWidth(flex: 2),
                              5: IntrinsicColumnWidth(flex: 3),
                              6: IntrinsicColumnWidth(flex: 2),
                              7: IntrinsicColumnWidth(flex: 3),
                            },
                            defaultColumnWidth: const FlexColumnWidth(),
                            children: [
                              TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                    child: STxt(txt: 'In', style: CustomTextStyle.tableHeaderStyle),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                    child: STxt(txt: 'Product ID', style: CustomTextStyle.tableHeaderStyle),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                    child: STxt(txt: 'SKU', style: CustomTextStyle.tableHeaderStyle),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                    child: STxt(txt: 'Product Name', style: CustomTextStyle.tableHeaderStyle),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                    child: STxt(txt: 'Product Type', style: CustomTextStyle.tableHeaderStyle),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                    child: STxt(txt: 'Product Style', style: CustomTextStyle.tableHeaderStyle),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                    child: STxt(txt: 'Price', style: CustomTextStyle.tableHeaderStyle),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                    child: STxt(txt: 'Action', style: CustomTextStyle.tableHeaderStyle),
                                  ),
                                ],
                                decoration: const BoxDecoration(color: Clr.tableHeaderGreyColor),
                              ),
                              for (VDatum element in (controller.searchProductListModel.value?.data ?? [])) ...[
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                      child: STxt(
                                          txt:
                                              '${(controller.searchProductListModel.value?.data?.indexOf(element) ?? 0) + 1}.',
                                          style: CustomTextStyle.tableContentStyle),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                      child: STxt(
                                          txt: element.id ?? "-",
                                          style:
                                              CustomTextStyle.tableContentStyle.copyWith(fontWeight: FontWeight.w600)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                      child: STxt(
                                          txt: element.additionalDetails?.productSku ?? "-",
                                          style: CustomTextStyle.tableContentStyle),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                      child: STxt(txt: element.name ?? "-", style: CustomTextStyle.tableContentStyle),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                      child: STxt(
                                          txt: element.additionalDetails?.style ?? "-",
                                          style: CustomTextStyle.tableContentStyle),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                      child: STxt(
                                          txt: element.categoryId?.categoryName ?? "-",
                                          style: CustomTextStyle.tableContentStyle),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                      child: STxt(
                                          txt: element.generalPrice?.toString() ?? "-",
                                          style: CustomTextStyle.tableContentStyle),
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Tooltip(
                                              message: "View Product",
                                              child: InkWell(
                                                onTap: () {
                                                  controller.onViewProductBtnTapped(jewelID: element.id ?? "");
                                                },
                                                child: Container(
                                                  height: 35,
                                                  width: 35,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(width: .8, color: Clr.blueColor),
                                                    borderRadius: BorderRadius.circular(5),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: const Icon(Icons.remove_red_eye_outlined,
                                                      color: Clr.blueColor, size: 20),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Tooltip(
                                              message: "Make InWaiting",
                                              child: InkWell(
                                                onTap: () {
                                                  controller.onInWaitingBtnTapped(ele: element);
                                                },
                                                child: Obx(() => Container(
                                                      height: 35,
                                                      width: 35,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(width: .8, color: Clr.greyColor),
                                                        borderRadius: BorderRadius.circular(5),
                                                        color:
                                                            (element.inWaiting?.value == true) ? Clr.greyColor : null,
                                                      ),
                                                      alignment: Alignment.center,
                                                      child: Icon(Icons.cached_rounded,
                                                          color: (element.inWaiting?.value == true)
                                                              ? Clr.whiteColor
                                                              : Clr.greyColor,
                                                          size: 20),
                                                    )),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Tooltip(
                                              message: "Edit Product",
                                              child: InkWell(
                                                onTap: () {
                                                  controller.onEditProductBtnTapped(jewelID: element.id ?? "");
                                                },
                                                child: Container(
                                                  height: 35,
                                                  width: 35,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(width: .8, color: Clr.amberColor),
                                                    borderRadius: BorderRadius.circular(5),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: const Icon(Icons.mode_edit_outline_outlined,
                                                      color: Clr.amberColor, size: 20),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Tooltip(
                                              message: "Delete Product",
                                              child: InkWell(
                                                onTap: () {
                                                  controller.onDeleteProductTapped(
                                                      jewelID: element.id ?? "",
                                                      dataList: controller.searchProductListModel.value?.data);
                                                },
                                                child: Container(
                                                  height: 35,
                                                  width: 35,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(width: .8, color: Clr.redColor),
                                                    borderRadius: BorderRadius.circular(5),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: const Icon(Icons.delete_outline_outlined,
                                                      color: Clr.redColor, size: 20),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ]
                            ],
                          ),
                        ),
                      ],
                    )
                  : const EmptyView(emptyText: "No Search Product Available.")),
          const SizedBox(height: 30),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    controller.goToFirstElement(
                      selectedTableIndex: controller.selectedSearchTableIndex,
                      itemScrollController: controller.searchItemScrollController,
                      onIndexChanged: (index) {
                        controller.getSearchList(pageIndex: index);
                      },
                    );
                  },
                  splashRadius: 20,
                  icon: const Icon(Icons.keyboard_double_arrow_left),
                ),
                const SizedBox(width: 5),
                IconButton(
                  onPressed: () {
                    controller.onBackButtonTapped(
                      selectedTableIndex: controller.selectedSearchTableIndex,
                      itemScrollController: controller.searchItemScrollController,
                      pageLength: controller.searchPageLength,
                      onIndexChanged: (index) {
                        controller.getSearchList(pageIndex: index);
                      },
                    );
                  },
                  splashRadius: 20,
                  icon: const Icon(Icons.chevron_left_rounded),
                ),
                const SizedBox(width: 5),
                Obx(() => SizedBox(
                      width: (controller.searchPageLength.value < 5) ? controller.searchPageLength.value * 60 : 290,
                      height: 45,
                      child: ScrollablePositionedList.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.searchPageLength.value,
                        itemScrollController: controller.searchItemScrollController,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 7),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: InkWell(
                                onTap: () {
                                  controller.onElementTapped(
                                    index: index,
                                    selectedTableIndex: controller.selectedSearchTableIndex,
                                    onIndexChanged: (index) {
                                      controller.getSearchList(pageIndex: index);
                                    },
                                  );
                                },
                                child: Obx(() => Container(
                                      height: 45,
                                      width: 45,
                                      decoration: BoxDecoration(
                                        color: (controller.selectedSearchTableIndex.value == index)
                                            ? Clr.primaryColor
                                            : Clr.transparentColor,
                                      ),
                                      alignment: Alignment.center,
                                      child: STxt(
                                        txt: (index + 1).toString(),
                                        style: CustomTextStyle.tableHeaderStyle.copyWith(
                                            color: (controller.selectedSearchTableIndex.value == index)
                                                ? Clr.whiteColor
                                                : Clr.blackColor),
                                      ),
                                    )),
                              ),
                            ),
                          );
                        },
                      ),
                    )),
                const SizedBox(width: 5),
                IconButton(
                  onPressed: () {
                    controller.onNextButtonTapped(
                      selectedTableIndex: controller.selectedSearchTableIndex,
                      itemScrollController: controller.searchItemScrollController,
                      pageLength: controller.searchPageLength,
                      onIndexChanged: (index) {
                        controller.getSearchList(pageIndex: index);
                      },
                    );
                  },
                  splashRadius: 20,
                  icon: const Icon(Icons.chevron_right_rounded),
                ),
                const SizedBox(width: 5),
                IconButton(
                  onPressed: () {
                    controller.goToLastElement(
                      selectedTableIndex: controller.selectedSearchTableIndex,
                      itemScrollController: controller.searchItemScrollController,
                      onIndexChanged: (index) {
                        controller.getSearchList(pageIndex: index);
                      },
                      pageLength: controller.searchPageLength,
                    );
                  },
                  splashRadius: 20,
                  icon: const Icon(Icons.keyboard_double_arrow_right),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
