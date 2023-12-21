import 'package:admin_web_app/controllers/index_controller.dart';
import 'package:admin_web_app/utils/assets.dart';
import 'package:admin_web_app/utils/colors.dart';
import 'package:admin_web_app/utils/text_styles.dart';
import 'package:admin_web_app/views/add_product_screen.dart';
import 'package:admin_web_app/views/dashboard_screen.dart';
import 'package:admin_web_app/views/manage_order_screen.dart';
import 'package:admin_web_app/views/oversee_category_screen.dart';
import 'package:admin_web_app/views/product_detail_screen.dart';
import 'package:admin_web_app/views/search_product_screen.dart';
import 'package:admin_web_app/views/view_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  IndexController controller = Get.put(IndexController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///SideBar.................................................
          Container(
            height: double.infinity,
            width: 250,
            decoration: const BoxDecoration(
                color: Clr.whiteColor,
                border: Border(
                  right: BorderSide(color: Clr.greyColor, width: .8),
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 17,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage(LocalPNG.faviconIcon),
                        )),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Admin Name".capitalize.toString(),
                            style: CustomTextStyle.title600Style,
                          ),
                          Text(
                            "admin role".toLowerCase(),
                            style: CustomTextStyle.mediumGreyStyle,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 17,
                ),
                Container(
                  height: .8,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Clr.greyColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                for (var i = 0; i < controller.tabList.length; i++) ...[
                  ListTile(
                    leading: Obx(
                      () => Icon(
                        controller.tabList[i].tabIcon,
                        color: (controller.tabList[i].isSelectedTab.value == true)
                            ? /*controller
                                    .tabList[i].activeColor*/
                            Clr.blackColor
                            : null,
                      ),
                    ),
                    title: Text(controller.tabList[i].tabName),
                    onTap: () {
                      controller.onTabTapped(index: i);
                    },
                  )
                ],
                const Spacer(),
                ListTile(
                  leading: const Icon(
                    Icons.lock_open_rounded,
                    color: Clr.amberColor,
                  ),
                  title: const Text("Change Password"),
                  onTap: controller.onChangePassBtnTapped,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.logout_rounded,
                    color: Clr.redColor,
                  ),
                  title: const Text("Sign Out"),
                  onTap: controller.onLogoutBtnTapped,
                ),
                // Container(
                //   height: 40,
                //   width: double.infinity,
                //   margin: const EdgeInsets.symmetric(horizontal: 15),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(5),
                //     color: Clr.redColor.withOpacity(.3),
                //   ),
                //   alignment: Alignment.center,
                //   child: Text("Sign Out",
                //       style: CustomTextStyle.midRedStyle,
                //       textAlign: TextAlign.center),
                // ),
                const SizedBox(height: 10),
              ],
            ),
          ),

          ///Contains Body...............................................
          Obx(() {
            return Expanded(
              child: SingleChildScrollView(
                controller: controller.mainScrollController,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (controller.selectedTabIndex.value == 0) ...[
                      ///Dashboard section...........................................
                      const DashBoardScreen(),
                    ] else if (controller.selectedTabIndex.value == 1) ...[
                      ///View Product section...........................................
                      Obx(() {
                        return (controller.isProductDetail.value == true)
                            ? const ProductDetailScreen()
                            : const ViewProductScreen();
                      }),
                    ] else if (controller.selectedTabIndex.value == 2) ...[
                      ///Add Product section...........................................
                      const AddProductScreen(),
                    ] else if (controller.selectedTabIndex.value == 3) ...[
                      ///Search Product section...........................................
                      const SearchProductScreen(),
                    ] else if (controller.selectedTabIndex.value == 4) ...[
                      ///Manage Order section...........................................
                      const ManageOrderScreen(),
                    ] else if (controller.selectedTabIndex.value == 5) ...[
                      ///Oversee Category section...........................................
                      const OverseeCategoryScreen(),
                    ]
                  ],
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}
