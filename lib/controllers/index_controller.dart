import 'dart:typed_data';
import 'package:admin_web_app/models/add_product/add_jewellery_model.dart';
import 'package:admin_web_app/models/add_product/category_list_model.dart';
import 'package:admin_web_app/models/category/add_category_model.dart';
import 'package:admin_web_app/models/category/delete_category_model.dart';
import 'package:admin_web_app/models/color_model.dart';
import 'package:admin_web_app/models/fitter_model.dart';
import 'package:admin_web_app/models/memory_file_model.dart';
import 'package:admin_web_app/models/metal_model.dart';
import 'package:admin_web_app/models/product/product_detail_model.dart';
import 'package:admin_web_app/models/shape_model.dart';
import 'package:admin_web_app/models/tab_model.dart';
import 'package:admin_web_app/models/view_product/view_product_list_model.dart';
import 'package:admin_web_app/models/visual_detail_model.dart';
import 'package:admin_web_app/providers/common_api_provider.dart';
import 'package:admin_web_app/utils/colors.dart';
import 'package:admin_web_app/utils/common_componets/common_dropdown.dart';
import 'package:admin_web_app/utils/common_componets/common_text_field.dart';
import 'package:admin_web_app/utils/common_componets/common_toast.dart';
import 'package:admin_web_app/utils/common_componets/custom_dialog.dart';
import 'package:admin_web_app/utils/common_componets/hover_button.dart';
import 'package:admin_web_app/utils/consts.dart';
import 'package:admin_web_app/utils/map_extension.dart';
import 'package:admin_web_app/utils/text_styles.dart';
import 'package:admin_web_app/utils/validate.dart';
import 'package:admin_web_app/views/product_detail_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

enum ShippingDetailsRadio { Default, Custom }

enum ReturnDetailsRadio { Default, Custom }

class IndexController extends GetxController {
  ///OnInit Section...............................................................................
  @override
  void onInit() {
    addVisualDetailElement();
    super.onInit();
  }

  void addVisualDetailElement() {
    visualDetailsList.add(VisualDetailModel(
        metalTypeList: metalTypeList,
        selectedMetalType: Rx<String?>(null),
        rhodiumPlatedList: generalRhodiumPlatedList,
        selectedRhodiumPlated: Rx<String?>(null),
        imageList: <MemoryFileModel>[].obs,
        priceController: TextEditingController(),
        videoBytesData: Rx<MemoryFileModel?>(null)));
  }

  ///Main Controller Access.....................................................................
  ///Main Scroll Controller
  ScrollController mainScrollController = ScrollController();
  List<TabModel> tabList = [
    TabModel(
      tabName: "Dashboard",
      tabIcon: Icons.dashboard_rounded,
      isSelectedTab: true.obs,
      activeColor: Clr.blackColor,
    ),
    TabModel(
      tabName: "View Product",
      tabIcon: Icons.view_agenda_rounded,
      isSelectedTab: false.obs,
      activeColor: Clr.blueColor,
    ),
    TabModel(
      tabName: "Add Product",
      tabIcon: Icons.add_box_rounded,
      isSelectedTab: false.obs,
      activeColor: Clr.greenColor,
    ),
    TabModel(
      tabName: "Search Product",
      tabIcon: Icons.manage_search_rounded,
      isSelectedTab: false.obs,
      activeColor: Clr.orangeColor,
    ),
    TabModel(
      tabName: "Manage Orders",
      tabIcon: Icons.sell_rounded,
      isSelectedTab: false.obs,
      activeColor: Clr.indigoColor,
    ),
    TabModel(
      tabName: "Oversee Category",
      tabIcon: Icons.category_rounded,
      isSelectedTab: false.obs,
      activeColor: Clr.indigoColor,
    ),
  ];
  RxInt selectedTabIndex = 0.obs;
  RxBool isProductDetail = false.obs;

  void onTabTapped({required int index}) {
    for (int i = 0; i < tabList.length; i++) {
      if (i == index) {
        if (tabList[i].isSelectedTab.value != true) {
          tabList[i].isSelectedTab.value = true;

          ///TapHandling
          if (index == 1) {
            tabHandleOfViewProduct();
          } else if (index == 5) {
            tabHandleOfOverseeCategory();
          }
        }
      } else {
        if (tabList[i].isSelectedTab.value != false) {
          tabList[i].isSelectedTab.value = false;
        }
      }
    }
    if (isProductDetail.value != false) {
      isProductDetail.value = false;
    }
    selectedTabIndex.value = index;
    mainScrollController.jumpTo(0);
  }

  void onLogoutBtnTapped() {
    debugPrint("onLogoutBtnTapped -------------->");
    CustomDialog.failureDialog(
      title: "Logout!",
      subtitle:
          "Are you certain you wish to log out? Please be aware that doing so will require you to sign in again to access the details.",
      callback: () async {
        Get.back();
        // dynamic data = await ApiProvider.commonProvider(
        //   url: URLs.adminLogoutUri,
        // );
        //
        // if (data != null) {
        // } else {
        //   debugPrint("Data is null");
        // }
      },
    );
  }

  void onChangePassBtnTapped() {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController oldPassController = TextEditingController();
    TextEditingController newPassController = TextEditingController();
    TextEditingController confirmPassController = TextEditingController();

    debugPrint("onChangePassBtnTapped -------------->");
    CustomDialog.dialog(
        child: Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Change Password",
            style: CustomTextStyle.infoHeadingStyle,
          ),
          const SizedBox(height: 20),
          Text(
            "Old Password",
            style: CustomTextStyle.fieldTitleStyle,
          ),
          const SizedBox(height: 5),
          CommonTextField(
            controller: oldPassController,
            validateType: Validate.Password,
          ),
          const SizedBox(height: 15),
          Text(
            "New Password",
            style: CustomTextStyle.fieldTitleStyle,
          ),
          const SizedBox(height: 5),
          CommonTextField(
            controller: newPassController,
            validateType: Validate.Password,
          ),
          const SizedBox(height: 15),
          Text(
            "Confirm Password",
            style: CustomTextStyle.fieldTitleStyle,
          ),
          const SizedBox(height: 5),
          CommonTextField(
            controller: confirmPassController,
            validateType: Validate.Password,
          ),
          const SizedBox(height: 30),
          HoverButton(
            btnText: "Confirm",
            callback: () async {
              if (formKey.currentState?.validate() == true) {
                Get.back();
                // Map<String, dynamic> bodyData = {
                //   Consts.oldPasswordKey: oldPassController.text,
                //   Consts.newPasswordKey: newPassController.text,
                // };
                //
                // dynamic data = await ApiProvider.commonProvider(
                //   url: URLs.adminChangePasswordUri,
                //   bodyData: bodyData,
                // );
                //
                // if (data != null) {
                // } else {
                //   debugPrint("Data is null");
                // }
              }
            },
          ),
        ],
      ),
    ));
  }

  void hideLoader() {
    isTableLoaderShow.value = Loader.Hide.name;
  }

  void showLoader() {
    isTableLoaderShow.value = Loader.Show.name;
  }

  ///View Product Access............................................................................
//handlers of the table pagination
  RxInt selectedTableIndex = 0.obs;
  RxInt pageLength = 10.obs;
  final ItemScrollController itemScrollController = ItemScrollController();

  //Table Loader Handler
  Rx<String> isTableLoaderShow = Loader.Hide.name.obs;

  Rx<ViewProductListModel?> viewProductListModel = Rx<ViewProductListModel?>(null);
  Rx<ProductDetailModel?> productDetailModel = Rx<ProductDetailModel?>(null);

  void tabHandleOfViewProduct() {
    getProductList();
  }

  Future<void> getProductList({int? pageIndex}) async {
    debugPrint("getProductList --------------------------->");
    showLoader();

    Map<String, dynamic> passData = {
      Consts.pageKey: (pageIndex != null) ? pageIndex.toString() : 1.toString(),
      Consts.limitKey: Consts.limitValKey.toString(),
    };

    ///API Calling
    dynamic data = await ApiProvider.commonProvider(
      url: URLs.jewelleryListUri,
      bodyData: passData,
    );

    if (data != null) {
      viewProductListModel.value = ViewProductListModel.fromJson(data);

      if (viewProductListModel.value?.success == true) {
        debugPrint("API Success is true");
        getPageLength(totalNumberOfData: viewProductListModel.value?.totalNumberOfData ?? 0);
      } else {
        debugPrint("API Success is false: ${viewProductListModel.value?.message}");
        MyToasts.errorToast(toast: viewProductListModel.value?.message.toString() ?? "");
      }
    } else {
      debugPrint("Data is null");
    }

    hideLoader();
  }

  void getPageLength({
    required int totalNumberOfData,
  }) {
    debugPrint("getPageLength ------------------------>");
    int checkHasHalfPage = totalNumberOfData % Consts.limitValKey;

    if (checkHasHalfPage > 0) {
      int totalPage = (totalNumberOfData ~/ Consts.limitValKey) + 1;
      pageLength.value = totalPage;
    } else {
      int totalPage = totalNumberOfData ~/ Consts.limitValKey;
      pageLength.value = totalPage;
    }
    debugPrint("totalPage: $pageLength");
  }

  void onNextButtonTapped() {
    debugPrint("onNextButtonTapped -------------->");
    if (selectedTableIndex.value < (pageLength.value - 1)) {
      selectedTableIndex++;
      itemScrollController.jumpTo(index: selectedTableIndex.value);
      getProductList(pageIndex: (selectedTableIndex.value + 1));
    } else {
      debugPrint("Given next index is out of bound.");
    }
  }

  void onBackButtonTapped() {
    debugPrint("onBackButtonTapped -------------->");
    if (selectedTableIndex.value > 0) {
      selectedTableIndex--;
      itemScrollController.jumpTo(index: selectedTableIndex.value);
      getProductList(pageIndex: (selectedTableIndex.value + 1));
    } else {
      debugPrint("Given back index is out of bound.");
    }
  }

  void goToFirstElement() {
    debugPrint("goToFirstElement -------------->");
    if (selectedTableIndex.value != 0) {
      selectedTableIndex.value = 0;
      itemScrollController.jumpTo(index: 0);
      getProductList(pageIndex: (selectedTableIndex.value + 1));
    }
  }

  void goToLastElement() {
    debugPrint("goToLastElement -------------->");
    if (selectedTableIndex.value != (pageLength.value - 1)) {
      selectedTableIndex.value = (pageLength.value - 1);
      itemScrollController.jumpTo(index: (pageLength.value - 1));
      getProductList(pageIndex: (selectedTableIndex.value + 1));
    }
  }

  void onElementTapped({required int index}) {
    debugPrint("onElementTapped -------------->");
    debugPrint("actual index: $index");
    if (selectedTableIndex.value != index) {
      selectedTableIndex.value = index;
      getProductList(pageIndex: (selectedTableIndex.value + 1));
    }
  }

  void onDeleteProductTapped({required String jewelID}) {
    debugPrint("onDeleteProductTapped -------------->");
    CustomDialog.failureDialog(
      title: "Delete Product?",
      subtitle:
          "Are you certain you want to delete the product? This action will permanently remove the product from existence.",
      callback: () async {
        Map<String, dynamic> passingData = {
          Consts.jewelleryIdKey: jewelID,
        };

        ///API Calling
        dynamic data = await ApiProvider.commonProvider(
          url: URLs.deleteJewelleryUri,
          bodyData: passingData,
          header: {
            "Authorization":
                'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1Nzg5ZmE4MGIxZTYyODMxODgyMjI3MiIsImlhdCI6MTcwMjQwNDAwOH0.8aHdi6qHLMVQMh9Ew4IrT2UCOqJ0RwX-uUBj45XFV3Y'
          },
        );

        if (data != null) {
          DeleteModel deleteModel = DeleteModel.fromJson(data);

          if (deleteModel.success == true) {
            viewProductListModel.value?.data?.removeWhere((element) => (element.id == jewelID) ? true : false);
            Get.back();
            MyToasts.errorToast(toast: deleteModel.message ?? "No Message");
          } else {
            debugPrint("API Success is false: ${deleteModel.message}");
            Get.back();
            MyToasts.errorToast(toast: deleteModel.message ?? "No Message");
          }
        } else {
          debugPrint("Data is null");
        }
      },
    );
  }

  Future<void> onViewProductBtnTapped({required String jewelID}) async {
    debugPrint("onViewProductBtnTapped--------------------------->");
    if (isProductDetail.value != true) {
      isProductDetail.value = true;
      Map<String, dynamic> passingData = {
        Consts.jewelleryIdKey: jewelID,
      };

      ///API Calling
      dynamic data = await ApiProvider.commonProvider(
        url: URLs.jewelleryDetailsUri,
        bodyData: passingData,
        header: {
          "Authorization":
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1Nzg5ZmE4MGIxZTYyODMxODgyMjI3MiIsImlhdCI6MTcwMjQwNDAwOH0.8aHdi6qHLMVQMh9Ew4IrT2UCOqJ0RwX-uUBj45XFV3Y'
        },
      );

      if (data != null) {
        productDetailModel.value = ProductDetailModel.fromJson(data);

        if (productDetailModel.value?.success == true) {
        } else {
          debugPrint("API Success is false: ${productDetailModel.value?.message}");
          MyToasts.errorToast(toast: productDetailModel.value?.message ?? "No Message");
        }
      } else {
        debugPrint("Data is null");
      }
    }
  }

  ///Product Detail Access............................................................................

  void onProductDetailBackBtnTapped() {
    debugPrint("onProductDetailBackBtnTapped--------------------------->");
    if (isProductDetail.value != false) {
      isProductDetail.value = false;
    }
  }

  ///Add Product Access............................................................................
  //Gender Selection Control
  List<String> genderList = ["Male", "Female", "Unisex"];
  RxString selectedGender = "Female".obs;

  //Product Type Control
  List<String> productTypeList = ["Ring", "Earring", "Necklace", "Bracelet", "Diamond"];
  Rx<String?> selectedProductType = Rx<String?>(null);

  //Diamond Detail Control
  List<String> stoneTypeList = ["Diamond", "Ruby", "Emerald", "Sapphire"];
  Rx<String?> selectedStoneType = "Diamond".obs;
  Rx<String?> selectedSideDiaStoneType = "Diamond".obs;
  List<String> creationMethodList = ["Lab Grown", "Other"];
  Rx<String?> selectedCreationMethod = "Lab Grown".obs;
  Rx<String?> selectedSideDiaCreationMethod = "Lab Grown".obs;
  List<ShapeModel> shapeList = [
    ShapeModel(shapeName: "Asscher", shapePath: "assets/pngs/asscher.png", isSelectedTab: true.obs),
    ShapeModel(shapeName: "Cushion", shapePath: "assets/pngs/cushion.png", isSelectedTab: false.obs),
    ShapeModel(
        shapeName: "Elongated Cushion", shapePath: "assets/pngs/elongated_cushion.png", isSelectedTab: false.obs),
    ShapeModel(shapeName: "Emerald", shapePath: "assets/pngs/emerald.png", isSelectedTab: false.obs),
    ShapeModel(shapeName: "Heart", shapePath: "assets/pngs/heart.png", isSelectedTab: false.obs),
    ShapeModel(shapeName: "Marquise", shapePath: "assets/pngs/marquise.png", isSelectedTab: false.obs),
    ShapeModel(shapeName: "Oval", shapePath: "assets/pngs/oval.png", isSelectedTab: false.obs),
    ShapeModel(shapeName: "Pear", shapePath: "assets/pngs/pear.png", isSelectedTab: false.obs),
    ShapeModel(shapeName: "Princess", shapePath: "assets/pngs/princess.png", isSelectedTab: false.obs),
    ShapeModel(shapeName: "Radiant", shapePath: "assets/pngs/radiant.png", isSelectedTab: false.obs),
    ShapeModel(shapeName: "Round", shapePath: "assets/pngs/round.png", isSelectedTab: false.obs),
  ];
  List<ShapeModel> sideDiaShapeList = [
    ShapeModel(shapeName: "Asscher", shapePath: "assets/pngs/asscher.png", isSelectedTab: true.obs),
    ShapeModel(shapeName: "Cushion", shapePath: "assets/pngs/cushion.png", isSelectedTab: false.obs),
    ShapeModel(
        shapeName: "Elongated Cushion", shapePath: "assets/pngs/elongated_cushion.png", isSelectedTab: false.obs),
    ShapeModel(shapeName: "Emerald", shapePath: "assets/pngs/emerald.png", isSelectedTab: false.obs),
    ShapeModel(shapeName: "Heart", shapePath: "assets/pngs/heart.png", isSelectedTab: false.obs),
    ShapeModel(shapeName: "Marquise", shapePath: "assets/pngs/marquise.png", isSelectedTab: false.obs),
    ShapeModel(shapeName: "Oval", shapePath: "assets/pngs/oval.png", isSelectedTab: false.obs),
    ShapeModel(shapeName: "Pear", shapePath: "assets/pngs/pear.png", isSelectedTab: false.obs),
    ShapeModel(shapeName: "Princess", shapePath: "assets/pngs/princess.png", isSelectedTab: false.obs),
    ShapeModel(shapeName: "Radiant", shapePath: "assets/pngs/radiant.png", isSelectedTab: false.obs),
    ShapeModel(shapeName: "Round", shapePath: "assets/pngs/round.png", isSelectedTab: false.obs),
  ];
  RxInt selectedShapeIndex = 0.obs;
  RxInt selectedSideDiaShapeIndex = 0.obs;
  List<ColorModel> colorList = [
    ColorModel(colorName: "Colorless-D", color: const Color(0xffffffff)),
    ColorModel(colorName: "Colorless-E", color: const Color(0xfffffafa)),
    ColorModel(colorName: "Colorless-F", color: const Color(0xfffffdf8)),
    ColorModel(colorName: "Near Colorless-G", color: const Color(0xfffffcf3)),
    ColorModel(colorName: "Near Colorless-H", color: const Color(0xfffffbf0)),
    ColorModel(colorName: "Near Colorless-I", color: const Color(0xfffffaec)),
    ColorModel(colorName: "Near Colorless-J", color: const Color(0xfffff9e7)),
    ColorModel(colorName: "Faint Yellow-K", color: const Color(0xfffdf6e0)),
    ColorModel(colorName: "Faint Yellow-L", color: const Color(0xfffdf6e0)),
    ColorModel(colorName: "Faint Yellow-M", color: const Color(0xfffff5db)),
    ColorModel(colorName: "Very Light Yellow-N", color: const Color(0xfffff6dd)),
    ColorModel(colorName: "Very Light Yellow-O", color: const Color(0xfffff4d5)),
    ColorModel(colorName: "Very Light Yellow-P", color: const Color(0xfffff3cf)),
    ColorModel(colorName: "Very Light Yellow-Q", color: const Color(0xfffff1c9)),
    ColorModel(colorName: "Very Light Yellow-R", color: const Color(0xffffefc3)),
    ColorModel(colorName: "Very Light Yellow-S", color: const Color(0xfffdebbb)),
    ColorModel(colorName: "Very Light Yellow-T", color: const Color(0xfffce8b3)),
    ColorModel(colorName: "Very Light Yellow-U", color: const Color(0xffffe9ad)),
    ColorModel(colorName: "Very Light Yellow-V", color: const Color(0xffffe7a6)),
    ColorModel(colorName: "Very Light Yellow-W", color: const Color(0xffffe59f)),
    ColorModel(colorName: "Very Light Yellow-X", color: const Color(0xfffde196)),
    ColorModel(colorName: "Very Light Yellow-Z", color: const Color(0xfff8db8d)),
  ];
  Rx<String?> selectedColor = Rx<String?>(null);
  Rx<String?> selectedSideDiaColor = Rx<String?>(null);
  List<ColorModel> colorHueList = [
    ColorModel(colorName: "White", color: const Color(0xffffffff)),
    ColorModel(colorName: "Very Light Yellow", color: const Color(0xfffff6dd)),
    ColorModel(colorName: "Light Yellow", color: const Color(0xfff8db8d)),
    ColorModel(colorName: "Yellow", color: const Color(0xffd5ae45)),
  ];
  Rx<String?> selectedColorHue = Rx<String?>(null);
  Rx<String?> selectedSideDiaColorHue = Rx<String?>(null);
  List<String> clarityList = ["FL", "IF", "VVS1", "VVS2", "VS1", "VS2", "SI1", "SI2", "SI3", "L1", "L2", "L3"];
  Rx<String?> selectedClarity = "VS1".obs;
  Rx<String?> selectedSideDiaClarity = "VS1".obs;
  List<String> cutGradeList = ["Fair", "Good", "Very Good", "Excellent", "Ideal"];
  Rx<String?> selectedCutGrade = "Excellent".obs;
  Rx<String?> selectedSideDiaCutGrade = "Excellent".obs;
  List<String> settingList = ["Prong", "Shared Prong", "Channel", "Bar Channel", "Pave", "Bezel"];
  Rx<String?> selectedSetting = Rx<String?>(null);
  Rx<String?> selectedSideDiaSetting = Rx<String?>(null);
  List<String> polishList = ["Fair", "Good", "Very Good", "Excellent", "Ideal"];
  Rx<String?> selectedPolish = Rx<String?>(null);
  Rx<String?> selectedSideDiaPolish = Rx<String?>(null);
  List<String> symmetryList = ["Fair", "Good", "Very Good", "Excellent", "Ideal"];
  Rx<String?> selectedSymmetry = Rx<String?>(null);
  Rx<String?> selectedSideDiaSymmetry = Rx<String?>(null);

  //Side Diamond Details
  RxBool isShowSideDiamondDetails = false.obs;

  //RingStyle
  List<String> ringStyleList = ["Eternity Band", "Fashion Band", "Stackable Ring", "Fashion Ring"];
  Rx<String?> selectedRingStyle = Rx<String?>(null);
  List<String> generalRhodiumPlatedList = ["Yes", "No"];
  Rx<String?> selectedGeneralRhodiumPlated = "Yes".obs;

  //EarringStyle
  List<String> earringStyleList = [
    "Three-Prong Stud",
    "Four-Prong Stud",
    "Six-Prong Stud",
    "Halo Stud",
    "Bezel Set Stud",
    "Hoop Earring",
    "Fashion Stud",
    "Drop Earring",
    "Dangle Earring",
    "Suspender Earring",
    "Earring Enhancer",
    "Fashion Earring",
    "Stud Earring",
    "Earring Jacket",
    "Two-Stone Stud",
  ];
  Rx<String?> selectedEarringStyle = Rx<String?>(null);
  List<String> earringBackTypeList = [
    "Fish Hook",
    "Push Back Post",
    "Hoop Wire",
    "Screw Back",
    "Latch Back",
    "Hinged Back",
    "Long Hook",
    "Lever Back",
    "Guardian Back",
    "Jumbo Back",
  ];
  Rx<String?> selectedEarringBackType = Rx<String?>(null);

  //NecklaceStyle
  List<String> necklaceStyleList = [
    "Solitaire Pendant",
    "Halo Pendant",
    "Fashion Pendant",
    "Heart Pendant",
    "Cross Pendant",
    "Tennis Necklace",
    "Fashion Necklace",
    "Riviera Necklace",
    "Harmony Bell",
    "Two-Stone Pendant",
    "Six-Prong Solitaire Pendant",
  ];
  Rx<String?> selectedNecklaceStyle = Rx<String?>(null);
  List<String> chainTypeList = [
    "Cable",
    "Box",
    "Bead",
    "Snake",
    "Popcorn",
    "Wheat",
    "Curb",
    "Anchor",
    "Infinity(Figure of Eight)",
    "Foxtail",
    "Herringbone",
    "Boston link",
    "C link",
    "Panther",
    "Mesh",
    "Omega",
    "Rope",
    "Nugget",
    "Bar",
  ];
  Rx<String?> selectedChainType = Rx<String?>(null);
  List<String> claspTypeList = [
    "Spring Ring",
    "Lobster Claw",
    "Bayonet",
    "Barrel",
    "Open Box",
    "Figure 8 Safety",
    "Toggle",
    "S Hook",
    "Mystery",
    "Magnetic",
    "Pearl",
    "Bracelet Catch",
  ];
  Rx<String?> selectedClaspType = Rx<String?>(null);

  //BraceletStyle
  List<String> braceletStyleList = [
    "Tennis Bracelet",
    "Fashion Bracelet",
    "Bangle Bracelet",
    "Chain Bracelet",
    "Cuff Bracelet",
    "Link Bracelet",
    "Anklet",
  ];
  Rx<String?> selectedBraceletStyle = Rx<String?>(null);

  //Shipping Details
  Rx<String?> selectedShippingDetails = ShippingDetailsRadio.Default.name.obs;

  //Returns Details
  Rx<String?> selectedReturnDetails = ReturnDetailsRadio.Default.name.obs;

  //Metal Type Details
  List<MetalModel> metalTypeList = [
    MetalModel(metalName: "10K Yellow Gold", color: const Color(0xffe5ce83), metalKarat: "10K"),
    MetalModel(metalName: "10K White Gold", color: const Color(0xffe9e9e9), metalKarat: "10K"),
    MetalModel(metalName: "10K Rose Gold", color: const Color(0xffe7ba9a), metalKarat: "10K"),
    MetalModel(metalName: "14K Yellow Gold", color: const Color(0xffe5ce83), metalKarat: "14K"),
    MetalModel(metalName: "14K White Gold", color: const Color(0xffe9e9e9), metalKarat: "14K"),
    MetalModel(metalName: "14K Rose Gold", color: const Color(0xffe7ba9a), metalKarat: "14K"),
    MetalModel(metalName: "18K Yellow Gold", color: const Color(0xffe5ce83), metalKarat: "18K"),
    MetalModel(metalName: "18K White Gold", color: const Color(0xffe9e9e9), metalKarat: "18K"),
    MetalModel(metalName: "18K Rose Gold", color: const Color(0xffe7ba9a), metalKarat: "18K"),
    MetalModel(metalName: "22K Yellow Gold", color: const Color(0xffe5ce83), metalKarat: "22K"),
    MetalModel(metalName: "22K White Gold", color: const Color(0xffe9e9e9), metalKarat: "22K"),
    MetalModel(metalName: "22K Rose Gold", color: const Color(0xffe7ba9a), metalKarat: "22K"),
    MetalModel(metalName: "24K Yellow Gold", color: const Color(0xffe5ce83), metalKarat: "24K"),
    MetalModel(metalName: "24K White Gold", color: const Color(0xffe9e9e9), metalKarat: "24K"),
    MetalModel(metalName: "24K Rose Gold", color: const Color(0xffe7ba9a), metalKarat: "24K"),
    MetalModel(metalName: "Platinum", color: const Color(0xffe5e4e2), metalKarat: "PL"),
  ];

  //Visual Detail Handling
  RxList<VisualDetailModel> visualDetailsList = <VisualDetailModel>[
    //First Object added into the OnInit
  ].obs;

  //API Section Variables
  Rx<CategoryListModel?> categoryListModel = Rx<CategoryListModel?>(null);
  Rx<AddJewelleryModel?> addJewelleryModel = Rx<AddJewelleryModel?>(null);

  //Controllers
  //Basic Details Controllers.
  TextEditingController productNameController = TextEditingController();
  TextEditingController productSubTitleController = TextEditingController();
  TextEditingController productDetailsController = TextEditingController();
  TextEditingController productGeneralPriceController = TextEditingController();

  //AdditionalDetails Controllers.
  TextEditingController skuController = TextEditingController();
  TextEditingController averageWidthController = TextEditingController();
  TextEditingController caratTotalWeightController = TextEditingController();
  TextEditingController earringLengthController = TextEditingController();
  TextEditingController earringWidthController = TextEditingController();
  TextEditingController pendantLengthController = TextEditingController();
  TextEditingController pendantWidthController = TextEditingController();
  TextEditingController chainLengthController = TextEditingController();
  TextEditingController chainWidthController = TextEditingController();
  TextEditingController braceletLengthController = TextEditingController();
  TextEditingController braceletWidthController = TextEditingController();

  //DiamondDetails Controllers
  TextEditingController countController = TextEditingController();
  TextEditingController caratWeightController = TextEditingController();
  TextEditingController totalCaratWeightController = TextEditingController();
  TextEditingController depthController = TextEditingController();
  TextEditingController tableController = TextEditingController();
  TextEditingController measurementsController = TextEditingController();

  //SideDiamondDetails Controllers.
  TextEditingController sideDiaCountController = TextEditingController();
  TextEditingController sideDiaCaratWeightController = TextEditingController();
  TextEditingController sideDiaTotalCaratWeightController = TextEditingController();
  TextEditingController sideDiaDepthController = TextEditingController();
  TextEditingController sideDiaTableController = TextEditingController();
  TextEditingController sideDiaMeasurementsController = TextEditingController();

  //Other Controller
  TextEditingController customShippingDetailsController = TextEditingController();
  TextEditingController customReturnsDetailsController = TextEditingController();

  //TextEditing Controller
  final GlobalKey<FormState> formValidateKey = GlobalKey<FormState>();

  void onShapeTapped({required int index, required List<ShapeModel> shapeList}) {
    for (int i = 0; i < shapeList.length; i++) {
      if (i == index) {
        shapeList[i].isSelectedTab.value = true;
      } else {
        shapeList[i].isSelectedTab.value = false;
      }
    }
    selectedShapeIndex.value = index;
  }

  void onSideDiamondDetailsTapped() {
    if (isShowSideDiamondDetails.value == false) {
      isShowSideDiamondDetails.value = !isShowSideDiamondDetails.value;
    } else {
      CustomDialog.failureDialog(
        title: "Remove Details!",
        subtitle: "Warning: Deleting this may erase all entered details within the side diamond details section.",
        callback: () {
          isShowSideDiamondDetails.value = !isShowSideDiamondDetails.value;
          Get.back();
        },
      );
    }
  }

  void onShippingDetailsRadioChanged({String? newVal}) {
    debugPrint("onBraceletStyleDropDownChanged -------------->");
    if (newVal != null) {
      debugPrint("newVal: $newVal");
      selectedShippingDetails.value = newVal;
    } else {
      debugPrint("Shipping Details Radio Value is Null");
    }
  }

  void onReturnDetailsRadioChanged({String? newVal}) {
    debugPrint("onReturnsDetailsRadioChanged -------------->");
    if (newVal != null) {
      debugPrint("newVal: $newVal");
      selectedReturnDetails.value = newVal;
    } else {
      debugPrint("Return Details Radio Value is Null");
    }
  }

  void onAddVisualDetailsTapped() {
    debugPrint("onAddVisualDetailsTapped -------------->");
    addVisualDetailElement();
  }

  void onRemoveVisualDetailsTapped({required int index}) {
    debugPrint("onRemoveVisualDetailsTapped -------------->");
    visualDetailsList.removeAt(index);
  }

  Future<void> onImagePickerTapped({required int index}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
    );
    // debugPrint("files: $result");

    if (result != null) {
      for (var element in result.files) {
        Uint8List? fileBytes = element.bytes;
        String fileName = element.name;

        visualDetailsList[index].imageList.add(
              MemoryFileModel(
                byteList: fileBytes.obs,
                fileName: fileName,
              ),
            );
      }
    } else {
      debugPrint("Image Picker Value is Null");
    }
  }

  void onImageCancelBtnTapped({required int outerIndex, required int innerIndex}) {
    visualDetailsList[outerIndex].imageList.removeAt(innerIndex);
  }

  Future<void> onVideoPickerTapped({required int index}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      // allowMultiple: true,
      type: FileType.video,
    );
    // debugPrint("files: $result");

    if (result != null) {
      Uint8List? fileBytes = result.files.first.bytes;
      String fileName = result.files.first.name;

      if (visualDetailsList[index].videoBytesData.value == null) {
        visualDetailsList[index].videoBytesData.value = MemoryFileModel(byteList: fileBytes.obs, fileName: fileName);
      } else {
        visualDetailsList[index].videoBytesData.value?.byteList.value = fileBytes;
        visualDetailsList[index].videoBytesData.value?.fileName = fileName;
      }
    } else {
      debugPrint("Video Picker Value is Null");
    }
  }

  Future<void> getCategoryListModel() async {
    debugPrint("getCategoryListModel----------------------->");

    dynamic data = await ApiProvider.commonProvider(
      url: URLs.categoryListUri,
    );

    if (data != null) {
      categoryListModel.value = CategoryListModel.fromJson(data);

      if (categoryListModel.value?.success == true) {
      } else {
        debugPrint("API Success is false");
      }
    } else {
      debugPrint("Data is null");
    }
  }

  Future<void> onAddProductBtnTapped() async {
    debugPrint("onAddProductBtnTapped----------------------->");
    if (formValidateKey.currentState?.validate() == true) {
      Map<String, dynamic> passingData = {};

      ///BasicDetails
      passingData.addAll({
        Consts.categoryIdKey: "",
        Consts.nameKey: productNameController.text,
        Consts.subTitleKey: productSubTitleController.text,
        Consts.descriptionKey: productDetailsController.text,
        Consts.genderKey: selectedGender.value,
        Consts.generalPriceKey: productGeneralPriceController.text,
      });

      ///DiamondDetails
      Map<String, dynamic> diamondData = {};
      diamondData.addInnerParamsIfNotNull(key: Consts.stoneTypeKey, value: selectedStoneType.value);
      diamondData.addInnerParamsIfNotNull(key: Consts.creationMethodKey, value: selectedCreationMethod.value);
      diamondData.addInnerParamsIfNotNull(key: Consts.shapeKey, value: shapeList[selectedShapeIndex.value].shapeName);
      diamondData.addInnerParamsIfNotNull(key: Consts.colorKey, value: selectedColor.value);
      diamondData.addInnerParamsIfNotNull(key: Consts.colorHueKey, value: selectedColorHue.value);
      diamondData.addInnerParamsIfNotNull(key: Consts.clarityKey, value: selectedClarity.value);
      diamondData.addInnerParamsIfNotNull(key: Consts.cutGradeKey, value: selectedCutGrade.value);
      diamondData.addInnerParamsIfNotNull(key: Consts.countKey, value: countController.text);
      diamondData.addInnerParamsIfNotNull(key: Consts.carateWeightKey, value: caratWeightController.text);
      diamondData.addInnerParamsIfNotNull(key: Consts.caratTotalWeightKey, value: totalCaratWeightController.text);
      diamondData.addInnerParamsIfNotNull(key: Consts.settingKey, value: selectedSetting.value);
      diamondData.addInnerParamsIfNotNull(key: Consts.polishKey, value: selectedPolish.value);
      diamondData.addInnerParamsIfNotNull(key: Consts.symmetryKey, value: selectedSymmetry.value);
      diamondData.addInnerParamsIfNotNull(key: Consts.depthKey, value: depthController.text);
      diamondData.addInnerParamsIfNotNull(key: Consts.tableKey, value: tableController.text);
      diamondData.addInnerParamsIfNotNull(key: Consts.measurementsKey, value: measurementsController.text);

      passingData.addAll({
        Consts.diamondDetailsKey: diamondData,
      });

      ///SideDiamondDetails
      if (isShowSideDiamondDetails.value == true) {
        Map<String, dynamic> sideDiamondData = {};
        diamondData.addInnerParamsIfNotNull(key: Consts.stoneTypeKey, value: selectedSideDiaStoneType.value);
        diamondData.addInnerParamsIfNotNull(key: Consts.creationMethodKey, value: selectedSideDiaCreationMethod.value);
        diamondData.addInnerParamsIfNotNull(
            key: Consts.shapeKey, value: shapeList[selectedSideDiaShapeIndex.value].shapeName);
        diamondData.addInnerParamsIfNotNull(key: Consts.colorKey, value: selectedSideDiaColor.value);
        diamondData.addInnerParamsIfNotNull(key: Consts.colorHueKey, value: selectedSideDiaColorHue.value);
        diamondData.addInnerParamsIfNotNull(key: Consts.clarityKey, value: selectedSideDiaClarity.value);
        diamondData.addInnerParamsIfNotNull(key: Consts.cutGradeKey, value: selectedSideDiaCutGrade.value);
        diamondData.addInnerParamsIfNotNull(key: Consts.countKey, value: sideDiaCountController.text);
        diamondData.addInnerParamsIfNotNull(key: Consts.carateWeightKey, value: sideDiaCaratWeightController.text);
        diamondData.addInnerParamsIfNotNull(
            key: Consts.caratTotalWeightKey, value: sideDiaTotalCaratWeightController.text);
        diamondData.addInnerParamsIfNotNull(key: Consts.settingKey, value: selectedSideDiaSetting.value);
        diamondData.addInnerParamsIfNotNull(key: Consts.polishKey, value: selectedSideDiaPolish.value);
        diamondData.addInnerParamsIfNotNull(key: Consts.symmetryKey, value: selectedSideDiaSymmetry.value);
        diamondData.addInnerParamsIfNotNull(key: Consts.depthKey, value: sideDiaDepthController.text);
        diamondData.addInnerParamsIfNotNull(key: Consts.tableKey, value: sideDiaTableController.text);
        diamondData.addInnerParamsIfNotNull(key: Consts.measurementsKey, value: sideDiaMeasurementsController.text);

        passingData.addAll({
          Consts.sideDiamondDetailsKey: sideDiamondData,
        });
      }

      ///AdditionalDetails
      Map<String, dynamic> additionalData = {};
      if (selectedProductType.value == Consts.ringKey) {
        additionalData.addInnerParamsIfNotNull(key: Consts.productSkuKey, value: skuController.text);
        additionalData.addInnerParamsIfNotNull(key: Consts.styleKey, value: selectedRingStyle.value);
        additionalData.addInnerParamsIfNotNull(
            key: Consts.generalRhodiumPlatedKey, value: selectedGeneralRhodiumPlated.value);
        additionalData.addInnerParamsIfNotNull(key: Consts.averageWidthKey, value: averageWidthController.text);
        additionalData.addInnerParamsIfNotNull(key: Consts.caratTotalWeightKey, value: caratTotalWeightController.text);
      } else if (selectedProductType.value == Consts.earringKey) {
        additionalData.addInnerParamsIfNotNull(key: Consts.productSkuKey, value: skuController.text);
        additionalData.addInnerParamsIfNotNull(key: Consts.styleKey, value: selectedEarringStyle.value);
        additionalData.addInnerParamsIfNotNull(
            key: Consts.generalRhodiumPlatedKey, value: selectedGeneralRhodiumPlated.value);
        additionalData.addInnerParamsIfNotNull(key: Consts.caratTotalWeightKey, value: caratTotalWeightController.text);
        additionalData.addInnerParamsIfNotNull(key: Consts.backTypeKey, value: selectedEarringBackType.value);
        additionalData.addInnerParamsIfNotNull(key: Consts.earringLengthKey, value: earringLengthController.text);
        additionalData.addInnerParamsIfNotNull(key: Consts.earringWidthKey, value: earringWidthController.text);
      } else if (selectedProductType.value == Consts.necklaceKey) {
        additionalData.addInnerParamsIfNotNull(key: Consts.productSkuKey, value: skuController.text);
        additionalData.addInnerParamsIfNotNull(key: Consts.styleKey, value: selectedNecklaceStyle.value);
        additionalData.addInnerParamsIfNotNull(
            key: Consts.generalRhodiumPlatedKey, value: selectedGeneralRhodiumPlated.value);
        additionalData.addInnerParamsIfNotNull(key: Consts.caratTotalWeightKey, value: caratTotalWeightController.text);
        additionalData.addInnerParamsIfNotNull(key: Consts.pendantLengthKey, value: pendantLengthController.text);
        additionalData.addInnerParamsIfNotNull(key: Consts.pendantWidthKey, value: pendantWidthController.text);
        additionalData.addInnerParamsIfNotNull(key: Consts.chainLengthKey, value: chainLengthController.text);
        additionalData.addInnerParamsIfNotNull(key: Consts.chainWidthKey, value: chainWidthController.text);
        additionalData.addInnerParamsIfNotNull(key: Consts.chainTypeKey, value: selectedChainType.value);
        additionalData.addInnerParamsIfNotNull(key: Consts.claspTypeKey, value: selectedClaspType.value);
      } else if (selectedProductType.value == Consts.braceletKey) {
        additionalData.addInnerParamsIfNotNull(key: Consts.productSkuKey, value: skuController.text);
        additionalData.addInnerParamsIfNotNull(key: Consts.styleKey, value: selectedNecklaceStyle.value);
        additionalData.addInnerParamsIfNotNull(
            key: Consts.generalRhodiumPlatedKey, value: selectedGeneralRhodiumPlated.value);
        additionalData.addInnerParamsIfNotNull(key: Consts.caratTotalWeightKey, value: caratTotalWeightController.text);
        additionalData.addInnerParamsIfNotNull(key: Consts.braceletLengthKey, value: braceletLengthController.text);
        additionalData.addInnerParamsIfNotNull(key: Consts.braceletWidthKey, value: braceletWidthController.text);
        additionalData.addInnerParamsIfNotNull(key: Consts.claspTypeKey, value: selectedClaspType.value);
      }

      passingData.addAll({
        Consts.additionalDetailsKey: additionalData,
      });

      ///VisualDetails

      ///ShippingDetails
      passingData.addAll({
        Consts.shippingDetailsKey: selectedShippingDetails.value?.toLowerCase(),
      });

      if (selectedShippingDetails.value == Consts.customKey) {
        passingData.addAll({
          Consts.customShippingDetailsKey: customShippingDetailsController.text,
        });
      }

      ///ReturnDetails
      passingData.addAll({
        Consts.returnDetailsKey: selectedReturnDetails.value?.toLowerCase(),
      });

      if (selectedReturnDetails.value == Consts.customKey) {
        passingData.addAll({
          Consts.customReturnDetailsKey: customReturnsDetailsController.text,
        });
      }

      debugPrint("passingData: $passingData");

      ///API Calling
      // dynamic data = await ApiProvider.commonProvider(
      //   url: URLs.addJewelleryUri,
      //   bodyData: passingData,
      // );
      //
      // if (data != null) {
      //   addJewelleryModel.value = AddJewelleryModel.fromJson(data);
      //
      //   if (addJewelleryModel.value?.success == true) {
      //   } else {
      //     debugPrint("API Success is false");
      //   }
      // } else {
      //   debugPrint("Data is null");
      // }
    }
  }

  ///Search Product Access............................................................................
  List<FilterModel> shapeFilterList = [
    FilterModel(filterText: "Asscher", isSelected: false.obs),
    FilterModel(filterText: "Cushion", isSelected: false.obs),
    FilterModel(filterText: "Elongated Cushion", isSelected: false.obs),
    FilterModel(filterText: "Emerald", isSelected: false.obs),
    FilterModel(filterText: "Heart", isSelected: false.obs),
    FilterModel(filterText: "Marquise", isSelected: false.obs),
    FilterModel(filterText: "Oval", isSelected: false.obs),
    FilterModel(filterText: "Pear", isSelected: false.obs),
    FilterModel(filterText: "Princess", isSelected: false.obs),
    FilterModel(filterText: "Radiant", isSelected: false.obs),
    FilterModel(filterText: "Round", isSelected: false.obs),
  ];
  List<FilterModel> colorHueFilterList = [
    FilterModel(filterText: "White", isSelected: false.obs),
    FilterModel(filterText: "Very Light Yellow", isSelected: false.obs),
    FilterModel(filterText: "Light Yellow", isSelected: false.obs),
    FilterModel(filterText: "Yellow", isSelected: false.obs),
  ];
  List<FilterModel> priceFilterList = [
    FilterModel(filterText: "\$0-\$50", isSelected: false.obs),
    FilterModel(filterText: "\$50-\$100", isSelected: false.obs),
    FilterModel(filterText: "\$100-\$200", isSelected: false.obs),
    FilterModel(filterText: "\$200-\$400", isSelected: false.obs),
    FilterModel(filterText: "\$400-\$1000", isSelected: false.obs),
    FilterModel(filterText: "\$1000-\$1500", isSelected: false.obs),
    FilterModel(filterText: "\$1500-\$2000", isSelected: false.obs),
    FilterModel(filterText: "\$2000-\$3000", isSelected: false.obs),
    FilterModel(filterText: "Highest", isSelected: false.obs),
    FilterModel(filterText: "Lowest", isSelected: false.obs),
  ];
  List<FilterModel> metalFilterList = [
    FilterModel(filterText: "10K White Gold", isSelected: false.obs),
    FilterModel(filterText: "10K Yellow GOld", isSelected: false.obs),
    FilterModel(filterText: "10K Rose GOld", isSelected: false.obs),
    FilterModel(filterText: "14K White Gold", isSelected: false.obs),
    FilterModel(filterText: "14K Yellow GOld", isSelected: false.obs),
    FilterModel(filterText: "14K Rose GOld", isSelected: false.obs),
    FilterModel(filterText: "18K White Gold", isSelected: false.obs),
    FilterModel(filterText: "18K Yellow GOld", isSelected: false.obs),
    FilterModel(filterText: "18K Rose GOld", isSelected: false.obs),
    FilterModel(filterText: "22K White Gold", isSelected: false.obs),
    FilterModel(filterText: "22K Yellow GOld", isSelected: false.obs),
    FilterModel(filterText: "22K Rose GOld", isSelected: false.obs),
    FilterModel(filterText: "24K White Gold", isSelected: false.obs),
    FilterModel(filterText: "24K Yellow GOld", isSelected: false.obs),
    FilterModel(filterText: "24K Rose GOld", isSelected: false.obs),
    FilterModel(filterText: "Platinum", isSelected: false.obs),
  ];
  List<FilterModel> clarityFilterList = [
    FilterModel(filterText: "FL", isSelected: false.obs),
    FilterModel(filterText: "IF", isSelected: false.obs),
    FilterModel(filterText: "VVS1", isSelected: false.obs),
    FilterModel(filterText: "VVS2", isSelected: false.obs),
    FilterModel(filterText: "VS1", isSelected: false.obs),
    FilterModel(filterText: "VS2", isSelected: false.obs),
    FilterModel(filterText: "SI1", isSelected: false.obs),
    FilterModel(filterText: "SI2", isSelected: false.obs),
    FilterModel(filterText: "SI3", isSelected: false.obs),
    FilterModel(filterText: "L1", isSelected: false.obs),
    FilterModel(filterText: "L2", isSelected: false.obs),
    FilterModel(filterText: "L3", isSelected: false.obs),
  ];
  List<FilterModel> genderFilterList = [
    FilterModel(filterText: "Woman", isSelected: false.obs),
    FilterModel(filterText: "Unisex", isSelected: false.obs),
    FilterModel(filterText: "Men", isSelected: false.obs),
  ];
  List<FilterModel> inStockFilterList = [
    FilterModel(filterText: "In Stock", isSelected: false.obs),
    FilterModel(filterText: "In Waiting", isSelected: false.obs),
  ];
  List<FilterModel> shortByFilterList = [
    FilterModel(filterText: "Best Sellers", isSelected: false.obs),
    FilterModel(filterText: "Top Rated", isSelected: false.obs),
    FilterModel(filterText: "Newest", isSelected: false.obs),
    FilterModel(filterText: "Price: Low to High", isSelected: false.obs),
    FilterModel(filterText: "Price: High to Low", isSelected: false.obs),
    FilterModel(filterText: "Name(A-Z)", isSelected: false.obs),
  ];
  RxList<FilterModel> selectedFilterList = <FilterModel>[].obs;

  void onDeleteFilterBtnTapped({required FilterModel element, required int index}) {
    debugPrint("onDeleteFilterBtnTapped-------------------->");
    element.isSelected.value = false;
    selectedFilterList.removeAt(index);
  }

  void onResetAllBtnTapped() {
    debugPrint("onResetAllBtnTapped-------------------->");
    for (var element in selectedFilterList) {
      element.isSelected.value = false;
    }
    selectedFilterList.clear();
  }

  ///Manage Order Access............................................................................
  //Table Loader Handler
  Rx<String> isOrderTableLoaderShow = Loader.Hide.name.obs;

  void showOrderTBLoader() {
    isOrderTableLoaderShow.value = Loader.Show.name;
  }

  void hideOrderTBLoader() {
    isOrderTableLoaderShow.value = Loader.Hide.name;
  }

  void onCancelOrderTapped() {
    debugPrint("onCancelOrderTapped -------------->");
    CustomDialog.failureDialog(
      title: "Cancel Order?",
      subtitle: "Are you certain you want to cancel the order? This action will permanently cancel the order.",
      callback: () async {
        Get.back();
        // dynamic data = await ApiProvider.commonProvider(
        //   url: URLs.adminLogoutUri,
        // );
        //
        // if (data != null) {
        // } else {
        //   debugPrint("Data is null");
        // }
      },
    );
  }

  ///Oversee Category Access............................................................................
  void tabHandleOfOverseeCategory() {
    getCategoryList();
  }

  Future<void> getCategoryList() async {
    debugPrint("getCategoryList --------------------------->");
    showLoader();

    ///API Calling
    dynamic data = await ApiProvider.commonProvider(
      url: URLs.categoryListUri,
    );

    if (data != null) {
      categoryListModel.value = CategoryListModel.fromJson(data);

      if (categoryListModel.value?.success == true) {
        debugPrint("API Success is true");
      } else {
        debugPrint("API Success is false: ${categoryListModel.value?.message}");
        MyToasts.errorToast(toast: categoryListModel.value?.message.toString() ?? "");
      }
    } else {
      debugPrint("Data is null");
    }

    hideLoader();
  }

  void onDeleteCategoryTapped({required String categoryID}) {
    debugPrint("onDeleteCategoryTapped -------------->");
    CustomDialog.failureDialog(
      title: "Delete Category?",
      subtitle:
          "Are you certain you want to delete the category? This action will permanently remove the category from existence.",
      callback: () async {
        Map<String, dynamic> passData = {
          Consts.categoryIdKey: categoryID,
        };

        ///API Calling
        dynamic data = await ApiProvider.commonProvider(
          url: URLs.deleteCategoryUri,
          bodyData: passData,
          header: {
            "Authorization":
                'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1Nzg5ZmE4MGIxZTYyODMxODgyMjI3MiIsImlhdCI6MTcwMjQwNDAwOH0.8aHdi6qHLMVQMh9Ew4IrT2UCOqJ0RwX-uUBj45XFV3Y'
          },
        );

        if (data != null) {
          DeleteModel deleteModel = DeleteModel.fromJson(data);

          if (deleteModel.success == true) {
            debugPrint("API Success is true");
            categoryListModel.value?.data?.removeWhere((element) => (element.id == categoryID) ? true : false);
            ;
            Get.back();
            MyToasts.successToast(toast: deleteModel.message ?? "No message");
          } else {
            Get.back();
            debugPrint("API Success is false: ${deleteModel.message}");
            MyToasts.errorToast(toast: deleteModel.message ?? "No message");
          }
        } else {
          debugPrint("Data is null");
        }
      },
    );
  }

  void onAddEditCategoryBtnTapped({CtDatum? element}) {
    TextEditingController cateNameController = TextEditingController();
    Rx<MemoryFileModel?> memoryFileModel = Rx<MemoryFileModel?>(null);
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    if (element != null) {
      cateNameController.text = element.categoryName ?? "";
      memoryFileModel.value = MemoryFileModel(byteList: null.obs, netImagePath: element.categoryImage ?? "");
    }

    debugPrint("onAddEditCategoryBtnTapped -------------->");
    CustomDialog.dialog(
        child: Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              (element != null) ? "Edit Category" : "Add Category",
              style: CustomTextStyle.dialogTitleStyle,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            "Category Image",
            style: CustomTextStyle.fieldTitleStyle,
          ),
          const SizedBox(height: 5),
          Center(
            child: InkWell(
              onTap: () async {
                MemoryFileModel? returnData = await onSingleImagePickerTapped();
                if (returnData != null) {
                  memoryFileModel.value = returnData;
                }
              },
              borderRadius: BorderRadius.circular(5),
              child: Obx(() => Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Clr.decentGreyColor,
                      borderRadius: BorderRadius.circular(5),
                      image: (memoryFileModel.value != null && memoryFileModel.value?.byteList.value != null)
                          ? DecorationImage(
                              fit: BoxFit.cover,
                              image: MemoryImage(memoryFileModel.value?.byteList.value ?? Uint8List(0)))
                          : (memoryFileModel.value != null && memoryFileModel.value?.netImagePath != null)
                              ? DecorationImage(
                                  fit: BoxFit.cover, image: NetworkImage(memoryFileModel.value?.netImagePath ?? ""))
                              : null,
                    ),
                    alignment: Alignment.center,
                    child: (memoryFileModel.value != null && memoryFileModel.value?.byteList.value != null ||
                            memoryFileModel.value != null && memoryFileModel.value?.netImagePath != null)
                        ? null
                        : const Icon(Icons.add_photo_alternate_rounded),
                  )),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            "Product Type",
            style: CustomTextStyle.fieldTitleStyle,
          ),
          const SizedBox(height: 5),
          CommonDropDownButton(
            selectedDropDownValue: selectedProductType,
            dropdownList: productTypeList,
            onChanged: (value) {
              if (value != null) {
                cateNameController.text = value;
              }
            },
          ),
          const SizedBox(height: 15),
          Text(
            "Product Category Name",
            style: CustomTextStyle.fieldTitleStyle,
          ),
          const SizedBox(height: 5),
          CommonTextField(
            controller: cateNameController,
            validateType: Validate.Name,
            isEmptyText: "Please enter category name",
          ),
          const SizedBox(height: 30),
          HoverButton(
            width: double.infinity,
            btnText: (element != null) ? "Edit" : "Add",
            isLoading: false.obs,
            callback: () async {
              debugPrint("onAddCategory ------------------->");
              if (formKey.currentState?.validate() == true) {
                if ((element != null)
                    ? true
                    : memoryFileModel.value != null && memoryFileModel.value?.byteList.value != null) {
                  Map<String, dynamic> passData = {
                    Consts.categoryNameKey: cateNameController.text.capitalize,
                  };

                  if (element != null) {
                    passData.addParamsIfNotNull(key: Consts.categoryIdKey, value: element.id);
                  }

                  ///API Calling
                  dynamic data = await ApiProvider.commonMultipartProvider(
                    url: (element != null) ? URLs.editCategoryUri : URLs.addCategoryUri,
                    body: passData,
                    files: (memoryFileModel.value?.byteList.value != null)
                        ? [
                            memoryFileModel.value?.byteList.value ?? Uint8List(0),
                          ]
                        : const [],
                    fieldName: Consts.categoryImageKey,
                    header: {
                      "Authorization":
                          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1Nzg5ZmE4MGIxZTYyODMxODgyMjI3MiIsImlhdCI6MTcwMjQwNDAwOH0.8aHdi6qHLMVQMh9Ew4IrT2UCOqJ0RwX-uUBj45XFV3Y'
                    },
                  );

                  if (data != null) {
                    AddCategoryModel addCategoryModel = AddCategoryModel.fromJson(data);

                    if (addCategoryModel.success == true) {
                      MyToasts.successToast(toast: addCategoryModel.message ?? "No Message");

                      if (addCategoryModel.data != null) {
                        //Edit Category
                        if (element != null) {
                          int? eleIndex = categoryListModel.value?.data?.indexOf(element);

                          if (eleIndex != null) {
                            categoryListModel.value?.data?.removeAt(eleIndex);
                            categoryListModel.value?.data?.insert(eleIndex, addCategoryModel.data!);
                          }
                        }
                        //Add Category
                        else {
                          categoryListModel.value?.data?.add(addCategoryModel.data!);
                        }
                        Get.back();
                      }
                    } else {
                      debugPrint("API Success is false");
                      MyToasts.errorToast(toast: addCategoryModel.message ?? "No Message");
                    }
                  } else {
                    debugPrint("Data is null");
                  }
                } else {
                  MyToasts.errorToast(toast: "Please first add the category image");
                }
              }
            },
          ),
        ],
      ),
    ));
  }

  Future<MemoryFileModel?> onSingleImagePickerTapped() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    // debugPrint("files: $result");

    if (result != null) {
      Uint8List? fileBytes = result.files.first.bytes;
      String fileName = result.files.first.name;

      MemoryFileModel memoryFileModel = MemoryFileModel(
        byteList: fileBytes.obs,
        fileName: fileName,
      );
      return memoryFileModel;
    } else {
      debugPrint("Image Picker Value is Null");
      return null;
    }
  }
}