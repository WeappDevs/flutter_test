import 'package:admin_web_app/controllers/index_controller.dart';
import 'package:admin_web_app/utils/colors.dart';
import 'package:admin_web_app/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

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
          Text(
            "Dashboard",
            style: CustomTextStyle.screenHeadingStyle,
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
              Flexible(
                flex: 1,
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: .2, color: Clr.greyColor),
                    color: Clr.whiteColor,
                  ),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("0", style: CustomTextStyle.extraLargeStyle),
                      Text("Total Product",
                          style: CustomTextStyle.largeMidGreyStyle),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Flexible(
                flex: 1,
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: .2, color: Clr.greyColor),
                    color: Clr.whiteColor,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("0", style: CustomTextStyle.extraLargeStyle),
                      Text("Total Sell",
                          style: CustomTextStyle.largeMidGreyStyle),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Flexible(
                flex: 1,
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: .2, color: Clr.greyColor),
                    color: Clr.whiteColor,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("0", style: CustomTextStyle.extraLargeStyle),
                      Text("Total Returns",
                          style: CustomTextStyle.largeMidGreyStyle),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Flexible(
                flex: 1,
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: .2, color: Clr.greyColor),
                    color: Clr.whiteColor,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("0.00", style: CustomTextStyle.extraLargeStyle),
                      Text("Total Payment",
                          style: CustomTextStyle.largeMidGreyStyle),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }
}