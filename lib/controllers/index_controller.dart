import 'dart:async';
import 'package:admin_web_app/models/add_product/category_list_model.dart';
import 'package:admin_web_app/models/add_product/upload_media_model.dart';
import 'package:admin_web_app/models/auth/user_model.dart';
import 'package:admin_web_app/models/category/add_category_model.dart';
import 'package:admin_web_app/models/category/delete_category_model.dart';
import 'package:admin_web_app/models/color_model.dart';
import 'package:admin_web_app/models/fitter_model.dart';
import 'package:admin_web_app/models/home/dashboard_model.dart';
import 'package:admin_web_app/models/memory_file_model.dart';
import 'package:admin_web_app/models/metal_model.dart';
import 'package:admin_web_app/models/product/product_detail_model.dart';
import 'package:admin_web_app/models/res/response_model.dart';
import 'package:admin_web_app/models/shape_model.dart';
import 'package:admin_web_app/models/tab_model.dart';
import 'package:admin_web_app/models/v_media_tab_model.dart';
import 'package:admin_web_app/models/view_product/view_product_list_model.dart';
import 'package:admin_web_app/models/visual_detail_model.dart';
import 'package:admin_web_app/providers/common_api_provider.dart';
import 'package:admin_web_app/providers/storage_provider.dart';
import 'package:admin_web_app/utils/colors.dart';
import 'package:admin_web_app/utils/common_componets/common_dropdown.dart';
import 'package:admin_web_app/utils/common_componets/common_text_field.dart';
import 'package:admin_web_app/utils/common_componets/common_toast.dart';
import 'package:admin_web_app/utils/common_componets/custom_dialog.dart';
import 'package:admin_web_app/utils/common_componets/hover_button.dart';
import 'package:admin_web_app/utils/consts.dart';
import 'package:admin_web_app/utils/list_extenstion.dart';
import 'package:admin_web_app/utils/map_extension.dart';
import 'package:admin_web_app/utils/route_management/route_names.dart';
import 'package:admin_web_app/utils/text_styles.dart';
import 'package:admin_web_app/utils/validate.dart';
import 'package:admin_web_app/views/widgets/s_txt.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:url_launcher/url_launcher.dart';

enum ShippingDetailsRadio { Default, Custom }

enum ReturnDetailsRadio { Default, Custom }

class IndexController extends GetxController {
  ///OnInit Section...............................................................................
  @override
  void onInit() {
    getUserDataFromStorage();
    addVisualDetailElement();
    getDashBoardData();
    super.onInit();
  }

  void getUserDataFromStorage() {
    debugPrint("getUserDataFromStorage------------------------->");
    dynamic readData = StorageProvider.instance.readStorage(key: Consts.userDataKey);
    if (readData != null) {
      Consts.userModel = UserModel.fromJson(readData);
    } else {
      Get.rootDelegate.offNamed(RouteNames.kSignInScreenRoute);
    }
  }

  void addVisualDetailElement() {
    visualDetailsList.add(
      VisualDetailModel(
        metalTypeList: metalTypeList,
        selectedMetalType: Rx<String?>(null),
        rhodiumPlatedList: generalRhodiumPlatedList,
        selectedRhodiumPlated: Rx<String?>(null),
        imageList: <MemoryFileModel>[].obs,
        priceController: TextEditingController(),
        videoBytesData: MemoryFileModel(byteList: Rx<Uint8List?>(null), isRefreshVideo: false.obs),
        version: 1.obs,
        isImageError: false.obs,
        isVideoError: false.obs,
        isSaveLoading: false.obs,
      ),
    );
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
          if (index == Consts.dashBoardIndex) {
            tabHandleOfDashBoard();
          } else if (index == Consts.viewProductIndex) {
            tabHandleOfViewProduct();
          } else if (index == Consts.addProductIndex) {
            tabHandleOfAddProduct();
          } else if (index == Consts.searchProductIndex) {
            tabHandleOfSearchProduct();
          } else if (index == Consts.overseeCategoryIndex) {
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
    RxBool isLoading = false.obs;

    debugPrint("onLogoutBtnTapped -------------->");
    CustomDialog.failureDialog(
      title: "Logout!",
      subtitle:
          "Are you certain you wish to log out? Please be aware that doing so will require you to sign in again to access the details.",
      callback: () async {
        isLoading.value = true;

        dynamic data = await ApiProvider.commonProvider(
          url: URLs.adminLogoutUri,
          header: ApiProvider.commonHeader(),
        );

        if (data != null) {
          ResponseModel rModel = ResponseModel.fromJson(data);

          if (rModel.success == true) {
            await StorageProvider.instance.removeStorage(key: Consts.userDataKey);

            isLoading.value = false;
            Get.back();
            Get.rootDelegate.toNamed(RouteNames.kSignInScreenRoute);
          } else {
            MyToasts.errorToast(toast: rModel.message ?? "No Message");
          }
        } else {
          debugPrint("Data is null");
        }

        isLoading.value = false;
        Get.back();
      },
      isLoading: isLoading,
    );
  }

  void onChangePassBtnTapped() {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController oldPassController = TextEditingController();
    TextEditingController newPassController = TextEditingController();
    TextEditingController confirmPassController = TextEditingController();
    RxBool isLoading = false.obs;

    debugPrint("onChangePassBtnTapped -------------->");
    CustomDialog.dialog(
        child: Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          STxt(
            txt: "Change Password",
            style: CustomTextStyle.infoHeadingStyle,
          ),
          const SizedBox(height: 20),
          STxt(
            txt: "Old Password",
            style: CustomTextStyle.fieldTitleStyle,
          ),
          const SizedBox(height: 5),
          CommonTextField(
            controller: oldPassController,
            validateType: Validate.Password,
            isObscure: true,
          ),
          const SizedBox(height: 15),
          STxt(
            txt: "New Password",
            style: CustomTextStyle.fieldTitleStyle,
          ),
          const SizedBox(height: 5),
          CommonTextField(
            controller: newPassController,
            validateType: Validate.Password,
            isObscure: true,
          ),
          const SizedBox(height: 15),
          STxt(
            txt: "Confirm Password",
            style: CustomTextStyle.fieldTitleStyle,
          ),
          const SizedBox(height: 5),
          CommonTextField(
            controller: confirmPassController,
            validateType: Validate.Password,
            isObscure: true,
            validator: (value) {
              if (value!.isEmpty) {
                return ValidateStr.passwordEmptyValidator;
              } else if (value != newPassController.text) {
                return ValidateStr.confirmPasswordValidValidator;
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          HoverButton(
            btnText: "Confirm",
            isLoading: isLoading,
            callback: () async {
              if (formKey.currentState?.validate() == true) {
                Map<String, dynamic> bodyData = {
                  Consts.oldPasswordKey: oldPassController.text,
                  Consts.newPasswordKey: newPassController.text,
                };

                dynamic data = await ApiProvider.commonProvider(
                  url: URLs.adminChangePasswordUri,
                  body: bodyData,
                  header: ApiProvider.commonHeader(),
                );

                if (data != null) {
                  ResponseModel rModel = ResponseModel.fromJson(data);

                  if (rModel.success == true) {
                    await StorageProvider.instance.removeStorage(key: Consts.userDataKey);

                    isLoading.value = false;
                    Get.back();
                    Get.rootDelegate.toNamed(RouteNames.kSignInScreenRoute);
                  } else {
                    MyToasts.errorToast(toast: rModel.message ?? "No Message");
                  }
                } else {
                  debugPrint("Data is null");
                }
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

  ///DashBoard Access............................................................................
  Rx<DashboardModel?> dashboardModel = Rx<DashboardModel?>(null);

  void tabHandleOfDashBoard() {
    getDashBoardData();
  }

  Future<void> getDashBoardData() async {
    debugPrint("getDashBoardData ---------------------->");
    dynamic data = await ApiProvider.commonProvider(
      url: URLs.adminDashboardUri,
      header: ApiProvider.commonHeader(),
    );

    if (data != null) {
      dashboardModel.value = DashboardModel.fromJson(data);

      if (dashboardModel.value?.success == true) {
        debugPrint("API Success is true");
      } else {
        debugPrint("API Success is false: ${viewProductListModel.value?.message}");
        MyToasts.errorToast(toast: viewProductListModel.value?.message ?? "No Message");
      }
    } else {
      debugPrint("Data is null");
    }
  }

  ///View Product Access............................................................................
  //handlers of the table pagination
  RxInt selectedProductTableIndex = 0.obs;
  RxInt productPageLength = 0.obs;
  final ItemScrollController productItemScrollController = ItemScrollController();

  //Table Loader Handler
  Rx<String> isTableLoaderShow = Loader.Hide.name.obs;

  Rx<ViewProductListModel?> viewProductListModel = Rx<ViewProductListModel?>(null);
  Rx<ProductDetailModel?> productDetailModel = Rx<ProductDetailModel?>(null);
  TextEditingController searchIDController = TextEditingController();

  void tabHandleOfViewProduct() {
    selectedProductTableIndex.value = 0;
    getProductList();
  }

  Future<void> getProductList({int? pageIndex}) async {
    debugPrint("getProductList --------------------------->");
    showLoader();

    Map<String, dynamic> passData = {
      Consts.pageKey: (pageIndex != null) ? pageIndex.toString() : 1.toString(),
      Consts.limitKey: Consts.limitValKey.toString(),
    };

    passData.addParamsIfNotNull(key: Consts.jewelleryIdKey, value: searchIDController.text);

    ///API Calling
    dynamic data = await ApiProvider.commonProvider(
      url: URLs.jewelleryListUri,
      body: passData,
    );

    if (data != null) {
      viewProductListModel.value = ViewProductListModel.fromJson(data);

      if (viewProductListModel.value?.success == true) {
        debugPrint("API Success is true");
        getPageLength(
            totalNumberOfData: viewProductListModel.value?.totalNumberOfData ?? 0, pageLength: productPageLength);
      } else {
        debugPrint("API Success is false: ${viewProductListModel.value?.message}");
        getPageLength(
            totalNumberOfData: viewProductListModel.value?.totalNumberOfData ?? 0, pageLength: productPageLength);
        // MyToasts.errorToast(toast: viewProductListModel.value?.message.toString() ?? "");
      }
    } else {
      debugPrint("Data is null");
    }

    hideLoader();
  }

  void getPageLength({
    required int totalNumberOfData,
    required RxInt pageLength,
  }) {
    debugPrint("getPageLength ------------------------>");
    if (totalNumberOfData != 0) {
      int checkHasHalfPage = totalNumberOfData % Consts.limitValKey;

      if (checkHasHalfPage > 0) {
        int totalPage = (totalNumberOfData ~/ Consts.limitValKey) + 1;
        pageLength.value = totalPage;
      } else {
        int totalPage = totalNumberOfData ~/ Consts.limitValKey;
        pageLength.value = totalPage;
      }
      debugPrint("pageLength: $pageLength");
    } else {
      pageLength.value = 0;
    }
  }

  void onNextButtonTapped(
      {required RxInt selectedTableIndex,
      required ItemScrollController itemScrollController,
      required RxInt pageLength,
      required void Function(int) onIndexChanged}) {
    debugPrint("onNextButtonTapped -------------->");
    if (selectedTableIndex.value < (pageLength.value - 1)) {
      selectedTableIndex++;
      itemScrollController.jumpTo(index: selectedTableIndex.value);

      // getProductList(pageIndex: (selectedTableIndex.value + 1));
      onIndexChanged(selectedTableIndex.value + 1);
    } else {
      debugPrint("Given next index is out of bound.");
    }
  }

  void onBackButtonTapped(
      {required RxInt selectedTableIndex,
      required ItemScrollController itemScrollController,
      required RxInt pageLength,
      required void Function(int) onIndexChanged}) {
    debugPrint("onBackButtonTapped -------------->");
    if (selectedTableIndex.value > 0) {
      selectedTableIndex--;
      itemScrollController.jumpTo(index: selectedTableIndex.value);
      // getProductList(pageIndex: (selectedTableIndex.value + 1));
      onIndexChanged(selectedTableIndex.value + 1);
    } else {
      debugPrint("Given back index is out of bound.");
    }
  }

  void goToFirstElement(
      {required RxInt selectedTableIndex,
      required ItemScrollController itemScrollController,
      required void Function(int) onIndexChanged}) {
    debugPrint("goToFirstElement -------------->");
    if (selectedTableIndex.value != 0) {
      selectedTableIndex.value = 0;
      itemScrollController.jumpTo(index: 0);
      // getProductList(pageIndex: (selectedTableIndex.value + 1));
      onIndexChanged(selectedTableIndex.value + 1);
    }
  }

  void goToLastElement(
      {required RxInt selectedTableIndex,
      required ItemScrollController itemScrollController,
      required void Function(int) onIndexChanged,
      required RxInt pageLength}) {
    debugPrint("goToLastElement -------------->");
    if (selectedTableIndex.value != (pageLength.value - 1)) {
      selectedTableIndex.value = (pageLength.value - 1);
      itemScrollController.jumpTo(index: (pageLength.value - 1));
      // getProductList(pageIndex: (selectedTableIndex.value + 1));
      onIndexChanged(selectedTableIndex.value + 1);
    }
  }

  void onElementTapped(
      {required int index, required RxInt selectedTableIndex, required void Function(int) onIndexChanged}) {
    debugPrint("onElementTapped -------------->");
    debugPrint("actual index: $index");
    if (selectedTableIndex.value != index) {
      selectedTableIndex.value = index;
      // getProductList(pageIndex: (selectedTableIndex.value + 1));
      onIndexChanged(selectedTableIndex.value + 1);
    }
  }

  void onDeleteProductTapped({required String jewelID, required RxList<VDatum>? dataList}) {
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
          header: ApiProvider.commonHeader(),
          body: passingData,
        );

        if (data != null) {
          DeleteModel deleteModel = DeleteModel.fromJson(data);

          if (deleteModel.success == true) {
            dataList?.removeWhere((element) => (element.id == jewelID) ? true : false);

            if (editProductDetailModel.value?.data?.value?.id == jewelID) {
              onResetFormBtnTapped();
            }

            Get.back();
            MyToasts.successToast(toast: deleteModel.message ?? "No Message");
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

  Future<void> onInWaitingBtnTapped({required VDatum ele}) async {
    Map<String, dynamic> passingData = {
      Consts.jewelleryIdKey: ele.id.toString(),
      Consts.inWaitingKey: ((ele.inWaiting?.value == true) ? false : true).toString(),
    };

    ///API Calling
    dynamic data = await ApiProvider.commonProvider(
      url: URLs.inWaitingJewelleryUri,
      body: passingData,
      header: ApiProvider.commonHeader(),
    );

    if (data != null) {
      ResponseModel responseModel = ResponseModel.fromJson(data);
      if (responseModel.success == true) {
        ele.inWaiting?.value = (ele.inWaiting?.value == true) ? false : true;
        MyToasts.successToast(toast: responseModel.message ?? "No Message");
      } else {
        MyToasts.errorToast(toast: responseModel.message ?? "No Message");
      }
    } else {
      debugPrint("Data is null");
    }
  }

  RxBool isViewProductLoading = false.obs;

  Future<void> onViewProductBtnTapped({required String jewelID}) async {
    debugPrint("onViewProductBtnTapped--------------------------->");
    if (jewelID.isNotEmpty) {
      //Work when selected tab is other than the view product
      if (selectedTabIndex.value != Consts.viewProductIndex) {
        onTabTapped(index: Consts.viewProductIndex);
      } else {
        mainScrollController.jumpTo(0);
      }
      isViewProductLoading.value = true;

      if (isProductDetail.value != true) {
        isProductDetail.value = true;
        Map<String, dynamic> passingData = {
          Consts.jewelleryIdKey: jewelID,
        };

        ///API Calling
        dynamic data = await ApiProvider.commonProvider(
          url: URLs.jewelleryDetailsUri,
          body: passingData,
          header: ApiProvider.commonHeader(),
        );

        if (data != null) {
          productDetailModel.value = ProductDetailModel.fromJson(data);

          if (productDetailModel.value?.success == true) {
            onAddVMediaCalled();
          } else {
            debugPrint("API Success is false: ${productDetailModel.value?.message}");
            MyToasts.errorToast(toast: productDetailModel.value?.message ?? "No Message");
          }
        } else {
          debugPrint("Data is null");
        }
      }
    }

    isViewProductLoading.value = false;
  }

  RxBool isEditLoading = false.obs;

  Future<void> onEditProductBtnTapped({required String jewelID}) async {
    debugPrint("onEditProductBtnTapped--------------------------->");
    isEditLoading.value = true;

    //Work when selected tab is other than the edit product
    if (selectedTabIndex.value != Consts.addProductIndex) {
      onTabTapped(index: Consts.addProductIndex);
    }

    isEditProductView.value = true;
    editProductDetailModel.value = null;

    Map<String, dynamic> passingData = {
      Consts.jewelleryIdKey: jewelID,
    };

    ///API Calling
    dynamic data = await ApiProvider.commonProvider(
      url: URLs.jewelleryDetailsUri,
      body: passingData,
      header: ApiProvider.commonHeader(),
    );

    if (data != null) {
      editProductDetailModel.value = ProductDetailModel.fromJson(data);

      if (editProductDetailModel.value?.success == true) {
        getAllEditData();
      } else {
        debugPrint("API Success is false: ${editProductDetailModel.value?.message}");
        MyToasts.errorToast(toast: editProductDetailModel.value?.message ?? "No Message");
      }
    } else {
      debugPrint("Data is null");
    }
    isEditLoading.value = false;
  }

  void getAllEditData() {
    debugPrint("getAllEditData--------------------------->");
    PData? editData = editProductDetailModel.value?.data?.value;

    if (editData != null) {
      //General Selection Control
      dropdownEditor(
          dropdownList: genderList,
          selectedDropdownValue: selectedGender,
          defValue: "Female",
          newValue: editData.gender?.capitalize);
      dropdownEditor(
          dropdownList: productTypeList,
          selectedDropdownValue: selectedProductType,
          defValue: null,
          newValue: editData.categoryId?.categoryName);
      if (categoryListModel.value?.data?.any((element) => element.id == editData.categoryId?.id) == true) {
        selectedProductCategoryID.value = editData.categoryId?.id;
      } else {
        selectedProductCategoryID.value = null;
      }

      //Diamond Detail Control
      dropdownEditor(
          dropdownList: stoneTypeList,
          selectedDropdownValue: selectedStoneType,
          defValue: "Diamond",
          newValue: editData.diamondDetails?.stoneType);
      dropdownEditor(
          dropdownList: stoneTypeList,
          selectedDropdownValue: selectedSideDiaStoneType,
          defValue: "Diamond",
          newValue: editData.sideDiamondDetails?.stoneType);
      dropdownEditor(
          dropdownList: creationMethodList,
          selectedDropdownValue: selectedCreationMethod,
          defValue: "Lab Grown",
          newValue: editData.diamondDetails?.creationMethod);
      dropdownEditor(
          dropdownList: creationMethodList,
          selectedDropdownValue: selectedSideDiaCreationMethod,
          defValue: "Lab Grown",
          newValue: editData.sideDiamondDetails?.creationMethod);

      for (var element in shapeList) {
        if (element.shapeName == editData.diamondDetails?.shape) {
          element.isSelectedTab.value = true;
          selectedShapeIndex.value = shapeList.indexOf(element);
        } else {
          element.isSelectedTab.value = false;
        }
      }
      for (var element in sideDiaShapeList) {
        if (element.shapeName == editData.sideDiamondDetails?.shape) {
          element.isSelectedTab.value = true;
          selectedSideDiaShapeIndex.value = sideDiaShapeList.indexOf(element);
        } else {
          element.isSelectedTab.value = false;
        }
      }

      selectedColor.value = null;
      otherDropdownEditor(
          isColorListing: true,
          selectedDropdownValue: selectedColor,
          defValue: null,
          newValue: editData.diamondDetails?.color);
      otherDropdownEditor(
          isColorListing: true,
          selectedDropdownValue: selectedSideDiaColor,
          defValue: null,
          newValue: editData.sideDiamondDetails?.color);
      otherDropdownEditor(
          isColorHueListing: true,
          selectedDropdownValue: selectedColorHue,
          defValue: null,
          newValue: editData.diamondDetails?.colorHue);
      otherDropdownEditor(
          isColorHueListing: true,
          selectedDropdownValue: selectedSideDiaColorHue,
          defValue: null,
          newValue: editData.sideDiamondDetails?.colorHue);
      dropdownEditor(
          dropdownList: clarityList,
          selectedDropdownValue: selectedClarity,
          defValue: "VS1",
          newValue: editData.diamondDetails?.clarity);
      dropdownEditor(
          dropdownList: clarityList,
          selectedDropdownValue: selectedSideDiaClarity,
          defValue: "VS1",
          newValue: editData.sideDiamondDetails?.clarity);
      dropdownEditor(
          dropdownList: cutGradeList,
          selectedDropdownValue: selectedCutGrade,
          defValue: "Excellent",
          newValue: editData.diamondDetails?.cutGrade);
      dropdownEditor(
          dropdownList: cutGradeList,
          selectedDropdownValue: selectedSideDiaCutGrade,
          defValue: "Excellent",
          newValue: editData.sideDiamondDetails?.cutGrade);
      dropdownEditor(
          dropdownList: settingList,
          selectedDropdownValue: selectedSetting,
          defValue: null,
          newValue: editData.diamondDetails?.setting);
      dropdownEditor(
          dropdownList: settingList,
          selectedDropdownValue: selectedSideDiaSetting,
          defValue: null,
          newValue: editData.sideDiamondDetails?.setting);
      dropdownEditor(
          dropdownList: polishList,
          selectedDropdownValue: selectedPolish,
          defValue: null,
          newValue: editData.diamondDetails?.polish);
      dropdownEditor(
          dropdownList: polishList,
          selectedDropdownValue: selectedSideDiaPolish,
          defValue: null,
          newValue: editData.sideDiamondDetails?.polish);
      dropdownEditor(
          dropdownList: symmetryList,
          selectedDropdownValue: selectedSymmetry,
          defValue: null,
          newValue: editData.diamondDetails?.symmetry);
      dropdownEditor(
          dropdownList: symmetryList,
          selectedDropdownValue: selectedSideDiaSymmetry,
          defValue: null,
          newValue: editData.sideDiamondDetails?.symmetry);

      //Side Diamond Details
      if (editData.sideDiamondDetails != null) {
        if (isShowSideDiamondDetails.value != true) {
          isShowSideDiamondDetails.value = true;
        }
      } else {
        if (isShowSideDiamondDetails.value != false) {
          isShowSideDiamondDetails.value = false;
        }
      }

      //RingStyle
      dropdownEditor(
          dropdownList: ringStyleList,
          selectedDropdownValue: selectedRingStyle,
          defValue: null,
          newValue: editData.additionalDetails?.style);
      dropdownEditor(
          dropdownList: generalRhodiumPlatedList,
          selectedDropdownValue: selectedGeneralRhodiumPlated,
          defValue: "Yes",
          newValue: editData.additionalDetails?.generalRhodiumPlated?.capitalize);

      //EarringStyle
      dropdownEditor(
          dropdownList: earringStyleList,
          selectedDropdownValue: selectedEarringStyle,
          defValue: null,
          newValue: editData.additionalDetails?.style);
      dropdownEditor(
          dropdownList: earringBackTypeList,
          selectedDropdownValue: selectedEarringBackType,
          defValue: null,
          newValue: editData.additionalDetails?.backType);

      //NecklaceStyle
      dropdownEditor(
          dropdownList: necklaceStyleList,
          selectedDropdownValue: selectedNecklaceStyle,
          defValue: null,
          newValue: editData.additionalDetails?.style);
      dropdownEditor(
          dropdownList: chainTypeList,
          selectedDropdownValue: selectedChainType,
          defValue: null,
          newValue: editData.additionalDetails?.chainType);
      dropdownEditor(
          dropdownList: claspTypeList,
          selectedDropdownValue: selectedClaspType,
          defValue: null,
          newValue: editData.additionalDetails?.claspType);

      //BraceletStyle
      dropdownEditor(
          dropdownList: braceletStyleList,
          selectedDropdownValue: selectedBraceletStyle,
          defValue: null,
          newValue: editData.additionalDetails?.style);

      //Shipping Details
      if (editData.shippingDetails == ShippingDetailsRadio.Custom.name.toLowerCase()) {
        if (selectedShippingDetails.value != ShippingDetailsRadio.Custom.name) {
          selectedShippingDetails.value = ShippingDetailsRadio.Custom.name;
        }
      } else {
        if (selectedShippingDetails.value != ShippingDetailsRadio.Default.name) {
          selectedShippingDetails.value = ShippingDetailsRadio.Default.name;
        }
      }

      //Returns Details
      if (editData.returnDetails == ReturnDetailsRadio.Custom.name.toLowerCase()) {
        if (selectedReturnDetails.value != ReturnDetailsRadio.Custom.name) {
          selectedReturnDetails.value = ReturnDetailsRadio.Custom.name;
        }
      } else {
        if (selectedReturnDetails.value != ReturnDetailsRadio.Default.name) {
          selectedReturnDetails.value = ReturnDetailsRadio.Default.name;
        }
      }

      //Visual Detail Handling
      if (editData.visualDetails != null && editData.visualDetails?.isEmpty != true) {
        visualDetailsList.clear();

        editData.visualDetails?.forEach((vData) {
          Rx<String?> selectedMetalType = Rx<String?>(null);
          if (metalTypeList.any((element) => element.metalName == vData.metalTypeColor) == true) {
            selectedMetalType.value = vData.metalTypeColor;
          }

          Rx<String?> selectedRhodiumPlated = Rx<String?>(null);
          if (generalRhodiumPlatedList.contains(vData.rhodiumPlated?.capitalize) == true) {
            selectedRhodiumPlated.value = vData.rhodiumPlated?.capitalize;
          }

          TextEditingController priceController = TextEditingController();
          if (vData.metalVisePrice != null) {
            priceController.text = vData.metalVisePrice?.toString() ?? '';
          }

          //get edit image data
          RxList<MemoryFileModel> imageList = <MemoryFileModel>[].obs;
          if (vData.productImages != null && vData.productImages?.isEmpty != true) {
            vData.productImages?.forEach((element) {
              MemoryFileModel? imageBytesData = MemoryFileModel(
                  byteList: Rx<Uint8List?>(null),
                  netImagePath: extractPathFromUrl(element),
                  netImageUrl: element,
                  isRefreshVideo: false.obs);

              imageList.add(imageBytesData);
            });
          }

          //get edit video data
          MemoryFileModel? videoBytesData = MemoryFileModel(byteList: Rx<Uint8List?>(null), isRefreshVideo: false.obs);
          if (vData.productVideo != null && vData.productVideo?.isEmpty != true) {
            videoBytesData = MemoryFileModel(
                byteList: Rx<Uint8List?>(null),
                netImagePath: extractPathFromUrl(vData.productVideo),
                netImageUrl: vData.productVideo,
                isRefreshVideo: false.obs);
          }

          visualDetailsList.add(
            VisualDetailModel(
              metalTypeList: metalTypeList,
              selectedMetalType: selectedMetalType,
              rhodiumPlatedList: generalRhodiumPlatedList,
              selectedRhodiumPlated: selectedRhodiumPlated,
              imageList: imageList,
              priceController: priceController,
              videoBytesData: videoBytesData,
              version: 1.obs,
              isImageError: false.obs,
              isVideoError: false.obs,
              isSaveLoading: false.obs,
            ),
          );
        });
      } else {
        visualDetailsList.clear();
        addVisualDetailElement();
      }

      //Controllers
      //Basic Details Controllers.
      textControllerEditor(textController: productNameController, newValue: editData.name);
      textControllerEditor(textController: productSubTitleController, newValue: editData.subTitle);
      textControllerEditor(textController: productDetailsController, newValue: editData.description);
      textControllerEditor(textController: productGeneralPriceController, newValue: editData.generalPrice?.toString());

      //AdditionalDetails Controllers.
      textControllerEditor(textController: skuController, newValue: editData.additionalDetails?.productSku);
      textControllerEditor(textController: averageWidthController, newValue: editData.additionalDetails?.averageWidth);
      textControllerEditor(
          textController: caratTotalWeightController, newValue: editData.additionalDetails?.caratTotalWeight);
      textControllerEditor(
          textController: earringLengthController, newValue: editData.additionalDetails?.earringLength?.toString());
      textControllerEditor(
          textController: earringWidthController, newValue: editData.additionalDetails?.earringWidth?.toString());
      textControllerEditor(
          textController: pendantLengthController, newValue: editData.additionalDetails?.pendantLength?.toString());
      textControllerEditor(
          textController: pendantWidthController, newValue: editData.additionalDetails?.pendantWidth?.toString());
      textControllerEditor(
          textController: chainLengthController, newValue: editData.additionalDetails?.chainLength?.toString());
      textControllerEditor(
          textController: chainWidthController, newValue: editData.additionalDetails?.chainWidth?.toString());
      textControllerEditor(
          textController: braceletLengthController, newValue: editData.additionalDetails?.braceletLength?.toString());
      textControllerEditor(
          textController: braceletWidthController, newValue: editData.additionalDetails?.braceletWidth?.toString());

      //DiamondDetails Controllers
      textControllerEditor(textController: countController, newValue: editData.diamondDetails?.count?.toString());
      textControllerEditor(
          textController: caratWeightController, newValue: editData.diamondDetails?.carateWeight?.toString());
      textControllerEditor(
          textController: totalCaratWeightController, newValue: editData.diamondDetails?.totalCarateWeight?.toString());
      textControllerEditor(textController: depthController, newValue: editData.diamondDetails?.depth?.toString());
      textControllerEditor(textController: tableController, newValue: editData.diamondDetails?.table?.toString());
      textControllerEditor(
          textController: measurementsController, newValue: editData.diamondDetails?.measurements?.toString());

      //SideDiamondDetails Controllers
      textControllerEditor(
          textController: sideDiaCountController, newValue: editData.sideDiamondDetails?.count?.toString());
      textControllerEditor(
          textController: sideDiaCaratWeightController,
          newValue: editData.sideDiamondDetails?.carateWeight?.toString());
      textControllerEditor(
          textController: sideDiaTotalCaratWeightController,
          newValue: editData.sideDiamondDetails?.totalCarateWeight?.toString());
      textControllerEditor(
          textController: sideDiaDepthController, newValue: editData.sideDiamondDetails?.depth?.toString());
      textControllerEditor(
          textController: sideDiaTableController, newValue: editData.sideDiamondDetails?.table?.toString());
      textControllerEditor(
          textController: sideDiaMeasurementsController,
          newValue: editData.sideDiamondDetails?.measurements?.toString());

      //Other Controller
      textControllerEditor(textController: customShippingDetailsController, newValue: editData.customShippingDetails);
      textControllerEditor(textController: customReturnsDetailsController, newValue: editData.customReturnDetails);

      //delete image list handling
      deletedImageIDList.clear();
    }
  }

  //This function is check that given value has available in dropdown and
  //if yes then change value according and if not then set by default value of dropdown
  void dropdownEditor({
    required List<String> dropdownList,
    required Rx<String?> selectedDropdownValue,
    required String? defValue,
    required String? newValue,
  }) {
    if (newValue != null && newValue.isEmpty != true) {
      if (dropdownList.contains(newValue) == true) {
        selectedDropdownValue.value = newValue;
      } else {
        if (selectedDropdownValue.value != defValue) {
          selectedDropdownValue.value = defValue;
        }
      }
    } else {
      if (selectedDropdownValue.value != defValue) {
        selectedDropdownValue.value = defValue;
      }
    }
    colorList.where((element) => element.colorName == newValue);
  }

  void otherDropdownEditor({
    bool? isColorListing,
    bool? isColorHueListing,
    required Rx<String?> selectedDropdownValue,
    required String? defValue,
    required String? newValue,
  }) {
    if (isColorListing == true) {
      if (newValue != null && newValue.isEmpty != true) {
        if (colorList.any((element) => element.colorName == newValue) == true) {
          selectedDropdownValue.value = newValue;
        } else {
          if (selectedDropdownValue.value != defValue) {
            selectedDropdownValue.value = defValue;
          }
        }
      } else {
        if (selectedDropdownValue.value != defValue) {
          selectedDropdownValue.value = defValue;
        }
      }
    } else if (isColorHueListing == true) {
      if (newValue != null && newValue.isEmpty != true) {
        if (colorHueList.any((element) => element.colorName == newValue) == true) {
          selectedDropdownValue.value = newValue;
        } else {
          if (selectedDropdownValue.value != defValue) {
            selectedDropdownValue.value = defValue;
          }
        }
      } else {
        if (selectedDropdownValue.value != defValue) {
          selectedDropdownValue.value = defValue;
        }
      }
    }
  }

  void textControllerEditor({required TextEditingController textController, required String? newValue}) {
    if (newValue != null && newValue.isEmpty != true) {
      textController.text = newValue;
    } else {
      textController.clear();
    }
  }

  String? extractPathFromUrl(String? url) {
    if (url != null && url.isEmpty != true) {
      List<String> segments = Uri.parse(url).pathSegments;
      if (segments.length >= 2) {
        return segments.sublist(segments.length - 2).join('/');
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  void onSearchIdFieldChanged() {
    timer?.cancel();
    timer = Timer(const Duration(milliseconds: 300), () {
      debugPrint("onSearchIdFieldChanged----------------------------------------->");
      selectedProductTableIndex.value = 0;
      getProductList();
    });
  }

  ///Product Detail Access............................................................................
  RxList<VMediaTabModel> vMediaTabListModel = RxList<VMediaTabModel>([]);
  Rx<VMediaTabModel?> selectedVMediaTabModel = Rx<VMediaTabModel?>(null);

  void onProductDetailBackBtnTapped() {
    debugPrint("onProductDetailBackBtnTapped--------------------------->");
    if (isProductDetail.value != false) {
      isProductDetail.value = false;
    }
  }

  void onVMediaChangedBtnTapped({required VMediaTabModel ele}) {
    debugPrint("onVMediaChangedBtnTapped ------------------------>");
    for (var element in vMediaTabListModel) {
      if (element.index == ele.index) {
        if (ele.isSelected.value != true) {
          ele.isSelected.value = true;
        }
      } else {
        if (element.isSelected.value != false) {
          element.isSelected.value = false;
        }
      }
    }

    selectedVMediaTabModel.value = ele;
  }

  void onAddVMediaCalled() {
    debugPrint("onAddVMediaCalled ---------------->");
    if (productDetailModel.value?.data?.value?.visualDetails?.isNotEmpty == true) {
      int i = 0;
      vMediaTabListModel.clear();
      productDetailModel.value?.data?.value?.visualDetails?.forEach((element) {
        vMediaTabListModel.add(VMediaTabModel(
          visualDetails: element,
          selectedMediaPath: Rx<String?>(element.productVideo),
          isSelected: (i == 0) ? true.obs : false.obs,
          index: i,
          isVideoSelected: true.obs,
        ));
        i++;
      });

      if (vMediaTabListModel.isNotEmpty) {
        selectedVMediaTabModel.value = vMediaTabListModel.first;
      }
    }
  }

  void onVideoTapped() {
    debugPrint("onVideoTapped ---------------->");
    selectedVMediaTabModel.value?.isVideoSelected?.value = true;
    selectedVMediaTabModel.value?.selectedMediaPath.value = selectedVMediaTabModel.value?.visualDetails.productVideo;
  }

  void onImageTapped({required String image}) {
    debugPrint("onImageTapped ---------------->");
    selectedVMediaTabModel.value?.isVideoSelected?.value = false;
    selectedVMediaTabModel.value?.selectedMediaPath.value = image;
  }

  void onUrlOpenCalled({required String? url}) {
    try {
      Uri uri = Uri.parse(url ?? "");
      launchUrl(uri);
    } catch (e) {
      MyToasts.errorToast(toast: "Oops, encountered an issue while attempting to open the URL.");
    }
  }

  ///Add Product Access............................................................................
  //Gender Selection Control
  List<String> genderList = ["Male", "Female", "Other"];
  RxString selectedGender = "Female".obs;

  //Product Type Control
  List<String> productTypeList = ["Ring", "Earring", "Necklace", "Bracelet", "Diamond"];
  Rx<String?> selectedProductType = Rx<String?>(null);
  Rx<String?> selectedProductCategoryID = Rx<String?>(null);

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

  //SideDiamondDetails Controllers
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

  //delete image handling
  List<String> deletedImageIDList = [];

  void tabHandleOfAddProduct() {
    if (categoryListModel.value == null || categoryListModel.value?.data?.isEmpty == true) {
      getCategoryList(isNotLoader: true);
    }
  }

  void onResetFormBtnTapped() {
    debugPrint("onResetFormBtnTapped -------------->");

    //General Selection Control
    selectedGender.value = "Female";
    selectedProductType.value = null;
    selectedProductCategoryID.value = null;

    //Diamond Detail Control
    selectedStoneType.value = "Diamond";
    selectedSideDiaStoneType.value = "Diamond";
    selectedCreationMethod.value = "Lab Grown";
    selectedSideDiaCreationMethod.value = "Lab Grown";
    for (var element in shapeList) {
      if (shapeList.indexOf(element) == 0) {
        element.isSelectedTab.value = true;
      } else {
        element.isSelectedTab.value = false;
      }
    }
    for (var element in sideDiaShapeList) {
      if (shapeList.indexOf(element) == 0) {
        element.isSelectedTab.value = true;
      } else {
        element.isSelectedTab.value = false;
      }
    }
    selectedShapeIndex.value = 0;
    selectedSideDiaShapeIndex.value = 0;
    selectedColor.value = null;
    selectedSideDiaColor.value = null;
    selectedColorHue.value = null;
    selectedSideDiaColorHue.value = null;
    selectedClarity.value = "VS1";
    selectedSideDiaClarity.value = "VS1";
    selectedCutGrade.value = "Excellent";
    selectedSideDiaCutGrade.value = "Excellent";
    selectedSetting.value = null;
    selectedSideDiaSetting.value = null;
    selectedPolish.value = null;
    selectedSideDiaPolish.value = null;
    selectedSymmetry.value = null;
    selectedSideDiaSymmetry.value = null;

    //Side Diamond Details
    isShowSideDiamondDetails.value = false;

    //RingStyle
    selectedRingStyle.value = null;
    selectedGeneralRhodiumPlated.value = "Yes";

    //EarringStyle
    selectedEarringStyle.value = null;
    selectedEarringBackType.value = null;

    //NecklaceStyle
    selectedNecklaceStyle.value = null;
    selectedChainType.value = null;
    selectedClaspType.value = null;

    //BraceletStyle
    selectedBraceletStyle.value = null;

    //Shipping Details
    selectedShippingDetails.value = ShippingDetailsRadio.Default.name;

    //Returns Details
    selectedReturnDetails.value = ReturnDetailsRadio.Default.name;

    //Visual Detail Handling
    visualDetailsList.clear();
    addVisualDetailElement();

    //Controllers
    //Basic Details Controllers.
    productNameController.clear();
    productSubTitleController.clear();
    productDetailsController.clear();
    productGeneralPriceController.clear();

    //AdditionalDetails Controllers.
    skuController.clear();
    averageWidthController.clear();
    caratTotalWeightController.clear();
    earringLengthController.clear();
    earringWidthController.clear();
    pendantLengthController.clear();
    pendantWidthController.clear();
    chainLengthController.clear();
    chainWidthController.clear();
    braceletLengthController.clear();
    braceletWidthController.clear();

    //DiamondDetails Controllers
    countController.clear();
    caratWeightController.clear();
    totalCaratWeightController.clear();
    depthController.clear();
    tableController.clear();
    measurementsController.clear();

    //SideDiamondDetails Controllers
    sideDiaCountController.clear();
    sideDiaCaratWeightController.clear();
    sideDiaTotalCaratWeightController.clear();
    sideDiaDepthController.clear();
    sideDiaTableController.clear();
    sideDiaMeasurementsController.clear();

    //Other Controller
    customShippingDetailsController.clear();
    customReturnsDetailsController.clear();

    //delete image
    deletedImageIDList.clear();

    //Change the EditProductView to the AddProductView
    if (isEditProductView.value != false) {
      isEditProductView.value = false;
    }
    editProductDetailModel.value = null;
  }

  void onProductTypeDropDownChanged({String? newVal}) {
    debugPrint("onProductTypeDropDownChanged -------------->");
    if (newVal != null) {
      debugPrint("newVal: $newVal");
      selectedProductCategoryID.value = newVal;
      categoryListModel.value?.data?.forEach((ele) {
        if (ele.id == selectedProductCategoryID.value) {
          selectedProductType.value = ele.categoryName;
        }
      });
    } else {
      debugPrint("DropDown Value is Null");
    }
  }

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

  Future<void> onImagePickerTapped({required int index, required VisualDetailModel element}) async {
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
                isRefreshVideo: false.obs,
              ),
            );
      }
      element.version++;
    } else {
      debugPrint("Image Picker Value is Null");
    }
  }

  void onImageCancelBtnTapped({required int outerIndex, required int innerIndex}) {
    if (visualDetailsList[outerIndex].imageList[innerIndex].netImagePath != null &&
        visualDetailsList[outerIndex].imageList[innerIndex].netImagePath?.isEmpty != true) {
      if (deletedImageIDList.contains(visualDetailsList[outerIndex].imageList[innerIndex].netImagePath ?? "-") !=
          true) {
        deletedImageIDList.add(visualDetailsList[outerIndex].imageList[innerIndex].netImagePath ?? "");
      }
    }
    visualDetailsList[outerIndex].imageList.removeAt(innerIndex);
  }

  Future<void> onVideoPickerTapped({required int index, required VisualDetailModel element}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );
    // debugPrint("files: $result");

    if (result != null) {
      Uint8List? fileBytes = result.files.first.bytes;
      String fileName = result.files.first.name;

      if (visualDetailsList[index].videoBytesData?.byteList.value != null) {
        visualDetailsList[index].videoBytesData?.byteList.value = null;
      }

      if (visualDetailsList[index].videoBytesData?.netImageUrl != null) {
        visualDetailsList[index].videoBytesData?.isRefreshVideo.value = true;
      }

      Future.delayed(const Duration(milliseconds: 300)).then((value) {
        visualDetailsList[index].videoBytesData?.isRefreshVideo.value = false;
        visualDetailsList[index].videoBytesData?.byteList.value = fileBytes;
        visualDetailsList[index].videoBytesData?.fileName = fileName;
        visualDetailsList[index].videoBytesData?.netImagePath = null;
        visualDetailsList[index].videoBytesData?.netImageUrl = null;
      });

      // debugPrint(visualDetailsList[index].videoBytesData?.netImageUrl);

      element.version++;
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

  Future<void> onUploadMediaBtnTapped({required VisualDetailModel element}) async {
    if (validateMedia(isVersionNotConsider: true) == true) {
      debugPrint("onUploadMediaBtnTapped --------------------->");

      element.isSaveLoading.value = true;

      List<Uint8List> imagePassList = [];
      bool isVideoUpload = true;

      //Upload Image
      for (var ele in element.imageList) {
        if (ele.byteList.value != null && ele.netImagePath == null || ele.netImagePath?.isEmpty == true) {
          imagePassList.add(ele.byteList.value!);
        }
      }

      //Upload Video
      if (element.videoBytesData?.netImagePath != null && element.videoBytesData?.netImagePath?.isEmpty != true) {
        isVideoUpload = false;
      }

      //all body print
      debugPrint("imagePassList: $imagePassList");
      debugPrint("isVideoUpload: $isVideoUpload");

      ///API Calling
      dynamic data = await ApiProvider.commonMultipartProvider(
        url: URLs.uploadVisualMediaUri,
        header: ApiProvider.commonHeader(),
        body: {},
        files: imagePassList,
        fieldName: Consts.productImagesKey,
        otherFiles: (isVideoUpload == true) ? element.videoBytesData?.byteList.value : null,
        otherFieldName: (isVideoUpload == true) ? Consts.productVideoKey : null,
      );

      if (data != null) {
        UploadMediaModel uploadMediaModel = UploadMediaModel.fromJson(data);

        if (uploadMediaModel.success == true) {
          element.version.value = 1;

          if (uploadMediaModel.data != null) {
            //Get Image
            if (uploadMediaModel.data?.productImages?.isNotEmpty == true) {
              int uploadImageLength = uploadMediaModel.data?.productImages?.length ?? 0;

              for (int i = 0, j = 0; i < element.imageList.length; i++) {
                if (j < uploadImageLength) {
                  MemoryFileModel image = element.imageList[i];

                  if (image.netImagePath == null || image.netImagePath?.isEmpty == true) {
                    image.netImagePath = uploadMediaModel.data?.productImages?[j];
                    j++;
                  }
                }
              }
            }

            //Get Video
            if (uploadMediaModel.data?.productVideo?.isNotEmpty == true) {
              element.videoBytesData?.netImagePath = uploadMediaModel.data?.productVideo;
            }
          }

          //all rest body print
          for (var element in element.imageList) {
            debugPrint("----------------->");
            debugPrint("fileName: ${element.fileName}");
            debugPrint("netImagePath: ${element.netImagePath}");
          }
          debugPrint("Video: ${element.videoBytesData?.netImagePath}");

          MyToasts.successToast(toast: uploadMediaModel.message ?? "No Message");
        } else {
          MyToasts.errorToast(toast: uploadMediaModel.message ?? "No Message");
        }
      } else {
        debugPrint("Data is null");
      }
    }
    element.isSaveLoading.value = false;
  }

  bool validateMedia({bool? isVersionNotConsider}) {
    bool isGoFurther = true;
    for (var element in visualDetailsList) {
      //save validate
      if (isVersionNotConsider != true) {
        //(default version is 1)
        if (element.version.value != 1 && element.isSaveLoading.value != true) {
          isGoFurther = false;
        }
      }

      //image validate
      if (element.imageList.value.isEmpty) {
        element.isImageError.value = true;
        isGoFurther = false;
      } else {
        element.isImageError.value = false;
      }
      //video validate
      if (element.videoBytesData?.netImageUrl != null || element.videoBytesData?.byteList.value != null) {
        element.isVideoError.value = false;
      } else {
        element.isVideoError.value = true;
        isGoFurther = false;
      }

      // if (element.videoBytesData?.netImageUrl == null || element.videoBytesData?.byteList.value == null) {
      //   element.isVideoError.value = true;
      //   isGoFurther = false;
      // } else {
      //   element.isVideoError.value = false;
      // }
    }
    return isGoFurther;
  }

  RxBool isAddBtnLoading = false.obs;

  Future<void> onAddEditProductBtnTapped({String? jewelID}) async {
    debugPrint("onAddEditProductBtnTapped----------------------->");
    bool isValidateMedia = validateMedia();
    bool? isValidateForm = formValidateKey.currentState?.validate();

    if (isValidateForm == true && isValidateMedia == true) {
      isAddBtnLoading.value = true;
      Map<String, dynamic> passingData = {};

      ///BasicDetails
      passingData.addAll({
        Consts.categoryIdKey: selectedProductCategoryID.value,
        Consts.nameKey: productNameController.text,
        Consts.subTitleKey: productSubTitleController.text,
        Consts.descriptionKey: productDetailsController.text,
        Consts.genderKey: selectedGender.value.toLowerCase(),
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
        Consts.diamondDetailsKey: diamondData.toString(),
      });

      ///SideDiamondDetails
      if (isShowSideDiamondDetails.value == true) {
        Map<String, dynamic> sideDiamondData = {};
        sideDiamondData.addInnerParamsIfNotNull(key: Consts.stoneTypeKey, value: selectedSideDiaStoneType.value);
        sideDiamondData.addInnerParamsIfNotNull(
            key: Consts.creationMethodKey, value: selectedSideDiaCreationMethod.value);
        sideDiamondData.addInnerParamsIfNotNull(
            key: Consts.shapeKey, value: shapeList[selectedSideDiaShapeIndex.value].shapeName);
        sideDiamondData.addInnerParamsIfNotNull(key: Consts.colorKey, value: selectedSideDiaColor.value);
        sideDiamondData.addInnerParamsIfNotNull(key: Consts.colorHueKey, value: selectedSideDiaColorHue.value);
        sideDiamondData.addInnerParamsIfNotNull(key: Consts.clarityKey, value: selectedSideDiaClarity.value);
        sideDiamondData.addInnerParamsIfNotNull(key: Consts.cutGradeKey, value: selectedSideDiaCutGrade.value);
        sideDiamondData.addInnerParamsIfNotNull(key: Consts.countKey, value: sideDiaCountController.text);
        sideDiamondData.addInnerParamsIfNotNull(key: Consts.carateWeightKey, value: sideDiaCaratWeightController.text);
        sideDiamondData.addInnerParamsIfNotNull(
            key: Consts.caratTotalWeightKey, value: sideDiaTotalCaratWeightController.text);
        sideDiamondData.addInnerParamsIfNotNull(key: Consts.settingKey, value: selectedSideDiaSetting.value);
        sideDiamondData.addInnerParamsIfNotNull(key: Consts.polishKey, value: selectedSideDiaPolish.value);
        sideDiamondData.addInnerParamsIfNotNull(key: Consts.symmetryKey, value: selectedSideDiaSymmetry.value);
        sideDiamondData.addInnerParamsIfNotNull(key: Consts.depthKey, value: sideDiaDepthController.text);
        sideDiamondData.addInnerParamsIfNotNull(key: Consts.tableKey, value: sideDiaTableController.text);
        sideDiamondData.addInnerParamsIfNotNull(key: Consts.measurementsKey, value: sideDiaMeasurementsController.text);

        passingData.addAll({
          Consts.sideDiamondDetailsKey: sideDiamondData.toString(),
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
        additionalData.addInnerParamsIfNotNull(key: Consts.styleKey, value: selectedBraceletStyle.value);
        additionalData.addInnerParamsIfNotNull(
            key: Consts.generalRhodiumPlatedKey, value: selectedGeneralRhodiumPlated.value);
        additionalData.addInnerParamsIfNotNull(key: Consts.caratTotalWeightKey, value: caratTotalWeightController.text);
        additionalData.addInnerParamsIfNotNull(key: Consts.braceletLengthKey, value: braceletLengthController.text);
        additionalData.addInnerParamsIfNotNull(key: Consts.braceletWidthKey, value: braceletWidthController.text);
        additionalData.addInnerParamsIfNotNull(key: Consts.claspTypeKey, value: selectedClaspType.value);
      } else {
        additionalData.addInnerParamsIfNotNull(key: Consts.productSkuKey, value: skuController.text);
      }

      if (additionalData.isNotEmpty) {
        passingData.addAll({
          Consts.additionalDetailsKey: additionalData.toString(),
        });
      }

      ///VisualDetails
      List<Map<String, dynamic>> visualDataList = [];
      for (var element in visualDetailsList) {
        if (element.version.value == 1) {
          Map<String, dynamic> innerVisualData = {};
          innerVisualData.addInnerParamsIfNotNull(
              key: Consts.metalTypeColorKey, value: element.selectedMetalType.value);
          innerVisualData.addInnerParamsIfNotNull(
              key: Consts.rhodiumPlatedKey, value: element.selectedRhodiumPlated.value);
          // innerVisualData.addInnerParamsIfNotNull(
          //     key: Consts.metalVisePriceKey,
          //     value: element.priceController.text);
          if (element.priceController.text.isNotEmpty == true) {
            innerVisualData.addAll({
              '"${Consts.metalVisePriceKey}"': num.parse(element.priceController.text),
            });
          }

          List<String> productImageList = [];
          for (var image in element.imageList) {
            if (image.netImagePath != null && image.netImagePath?.isNotEmpty == true) {
              productImageList.add(image.netImagePath!);
            }
          }

          innerVisualData.addInnerParamsIfNotNull(key: Consts.productImagesKey, value: productImageList.listStringify);
          innerVisualData.addInnerParamsIfNotNull(
              key: Consts.productVideoKey, value: element.videoBytesData?.netImagePath);

          visualDataList.add(innerVisualData);
        }
      }

      if (visualDataList.isNotEmpty) {
        passingData.addAll({
          Consts.visualDetailsKey: visualDataList.toString(),
        });
      }

      ///ShippingDetails
      passingData.addAll({
        Consts.shippingDetailsKey: selectedShippingDetails.value?.toLowerCase(),
      });

      if (selectedShippingDetails.value == ShippingDetailsRadio.Custom.name) {
        passingData.addAll({
          Consts.customShippingDetailsKey: customShippingDetailsController.text,
        });
      }

      ///ReturnDetails
      passingData.addAll({
        Consts.returnDetailsKey: selectedReturnDetails.value?.toLowerCase(),
      });

      if (selectedReturnDetails.value == ReturnDetailsRadio.Custom.name) {
        passingData.addAll({
          Consts.customReturnDetailsKey: customReturnsDetailsController.text,
        });
      }

      ///Edit Jewelry
      if (jewelID != null && jewelID.isEmpty != true) {
        passingData.addAll({
          Consts.jewelleryIdKey: jewelID,
        });
      }

      ///Delete Media Handling
      if (deletedImageIDList.isEmpty != true) {
        passingData.addAll({
          Consts.deletedMediaIdsKey: deletedImageIDList.listStringify.toString(),
        });
      }
      // debugPrint("passingData: $passingData");

      ///API Calling
      dynamic data = await ApiProvider.commonProvider(
        url: (jewelID != null && jewelID.isEmpty != true) ? URLs.editJewelleryUri : URLs.addJewelleryUri,
        body: passingData,
        header: ApiProvider.commonHeader(),
      );

      if (data != null) {
        ResponseModel responseModel = ResponseModel.fromJson(data);
        if (responseModel.success == true) {
          MyToasts.successToast(toast: responseModel.message ?? "No message");
          onResetFormBtnTapped();

          if (jewelID != null && jewelID.isEmpty != true) {
            onViewProductBtnTapped(jewelID: jewelID);
          }
        } else {
          MyToasts.errorToast(toast: responseModel.message ?? "No message");
        }
      } else {
        debugPrint("Data is null");
      }
    } else {
      if (isValidateForm == true) {
        if (isValidateMedia == false) {
          MyToasts.warningToast(toast: "Please save all media or recheck before proceeding.");
        }
      } else {
        MyToasts.warningToast(toast: "Please fill missing details.");
      }
    }

    isAddBtnLoading.value = false;
  }

  ///Edit Product Access............................................................................
  RxBool isEditProductView = false.obs;
  Rx<ProductDetailModel?> editProductDetailModel = Rx<ProductDetailModel?>(null);

  ///Search Product Access............................................................................
  List<FilterModel> shapeFilterList = [
    FilterModel(filterText: "Asscher", isSelected: false.obs, categoryText: Consts.shapeKey),
    FilterModel(filterText: "Cushion", isSelected: false.obs, categoryText: Consts.shapeKey),
    FilterModel(filterText: "Elongated Cushion", isSelected: false.obs, categoryText: Consts.shapeKey),
    FilterModel(filterText: "Emerald", isSelected: false.obs, categoryText: Consts.shapeKey),
    FilterModel(filterText: "Heart", isSelected: false.obs, categoryText: Consts.shapeKey),
    FilterModel(filterText: "Marquise", isSelected: false.obs, categoryText: Consts.shapeKey),
    FilterModel(filterText: "Oval", isSelected: false.obs, categoryText: Consts.shapeKey),
    FilterModel(filterText: "Pear", isSelected: false.obs, categoryText: Consts.shapeKey),
    FilterModel(filterText: "Princess", isSelected: false.obs, categoryText: Consts.shapeKey),
    FilterModel(filterText: "Radiant", isSelected: false.obs, categoryText: Consts.shapeKey),
    FilterModel(filterText: "Round", isSelected: false.obs, categoryText: Consts.shapeKey),
  ];
  List<FilterModel> colorHueFilterList = [
    FilterModel(filterText: "White", isSelected: false.obs, categoryText: Consts.colorHueKey),
    FilterModel(filterText: "Very Light Yellow", isSelected: false.obs, categoryText: Consts.colorHueKey),
    FilterModel(filterText: "Light Yellow", isSelected: false.obs, categoryText: Consts.colorHueKey),
    FilterModel(filterText: "Yellow", isSelected: false.obs, categoryText: Consts.colorHueKey),
  ];
  List<FilterModel> priceFilterList = [
    FilterModel(
        filterText: "\$0-\$50", isSelected: false.obs, categoryText: Consts.priceKey, minPrice: 0, maxPrice: 50),
    FilterModel(
        filterText: "\$50-\$100", isSelected: false.obs, categoryText: Consts.priceKey, minPrice: 50, maxPrice: 100),
    FilterModel(
        filterText: "\$100-\$200", isSelected: false.obs, categoryText: Consts.priceKey, minPrice: 100, maxPrice: 200),
    FilterModel(
        filterText: "\$200-\$400", isSelected: false.obs, categoryText: Consts.priceKey, minPrice: 200, maxPrice: 400),
    FilterModel(
        filterText: "\$400-\$1000",
        isSelected: false.obs,
        categoryText: Consts.priceKey,
        minPrice: 400,
        maxPrice: 1000),
    FilterModel(
        filterText: "\$1000-\$1500",
        isSelected: false.obs,
        categoryText: Consts.priceKey,
        minPrice: 1000,
        maxPrice: 1500),
    FilterModel(
        filterText: "\$1500-\$2000",
        isSelected: false.obs,
        categoryText: Consts.priceKey,
        minPrice: 1500,
        maxPrice: 2000),
    FilterModel(
        filterText: "\$2000-\$3000",
        isSelected: false.obs,
        categoryText: Consts.priceKey,
        minPrice: 2000,
        maxPrice: 3000),
    FilterModel(filterText: "Highest", isSelected: false.obs, categoryText: Consts.priceKey),
    FilterModel(filterText: "Lowest", isSelected: false.obs, categoryText: Consts.priceKey),
  ];
  List<FilterModel> metalFilterList = [
    FilterModel(filterText: "10K White Gold", isSelected: false.obs, categoryText: Consts.metalKey),
    FilterModel(filterText: "10K Yellow GOld", isSelected: false.obs, categoryText: Consts.metalKey),
    FilterModel(filterText: "10K Rose GOld", isSelected: false.obs, categoryText: Consts.metalKey),
    FilterModel(filterText: "14K White Gold", isSelected: false.obs, categoryText: Consts.metalKey),
    FilterModel(filterText: "14K Yellow GOld", isSelected: false.obs, categoryText: Consts.metalKey),
    FilterModel(filterText: "14K Rose GOld", isSelected: false.obs, categoryText: Consts.metalKey),
    FilterModel(filterText: "18K White Gold", isSelected: false.obs, categoryText: Consts.metalKey),
    FilterModel(filterText: "18K Yellow GOld", isSelected: false.obs, categoryText: Consts.metalKey),
    FilterModel(filterText: "18K Rose GOld", isSelected: false.obs, categoryText: Consts.metalKey),
    FilterModel(filterText: "22K White Gold", isSelected: false.obs, categoryText: Consts.metalKey),
    FilterModel(filterText: "22K Yellow GOld", isSelected: false.obs, categoryText: Consts.metalKey),
    FilterModel(filterText: "22K Rose GOld", isSelected: false.obs, categoryText: Consts.metalKey),
    FilterModel(filterText: "24K White Gold", isSelected: false.obs, categoryText: Consts.metalKey),
    FilterModel(filterText: "24K Yellow GOld", isSelected: false.obs, categoryText: Consts.metalKey),
    FilterModel(filterText: "24K Rose GOld", isSelected: false.obs, categoryText: Consts.metalKey),
    FilterModel(filterText: "Platinum", isSelected: false.obs, categoryText: Consts.metalKey),
  ];
  List<FilterModel> clarityFilterList = [
    FilterModel(filterText: "FL", isSelected: false.obs, categoryText: Consts.clarityKey),
    FilterModel(filterText: "IF", isSelected: false.obs, categoryText: Consts.clarityKey),
    FilterModel(filterText: "VVS1", isSelected: false.obs, categoryText: Consts.clarityKey),
    FilterModel(filterText: "VVS2", isSelected: false.obs, categoryText: Consts.clarityKey),
    FilterModel(filterText: "VS1", isSelected: false.obs, categoryText: Consts.clarityKey),
    FilterModel(filterText: "VS2", isSelected: false.obs, categoryText: Consts.clarityKey),
    FilterModel(filterText: "SI1", isSelected: false.obs, categoryText: Consts.clarityKey),
    FilterModel(filterText: "SI2", isSelected: false.obs, categoryText: Consts.clarityKey),
    FilterModel(filterText: "SI3", isSelected: false.obs, categoryText: Consts.clarityKey),
    FilterModel(filterText: "L1", isSelected: false.obs, categoryText: Consts.clarityKey),
    FilterModel(filterText: "L2", isSelected: false.obs, categoryText: Consts.clarityKey),
    FilterModel(filterText: "L3", isSelected: false.obs, categoryText: Consts.clarityKey),
  ];
  List<FilterModel> genderFilterList = [
    FilterModel(
        filterText: "Woman", isSelected: false.obs, categoryText: Consts.genderKey, paramName: Consts.femaleVal),
    FilterModel(filterText: "Other", isSelected: false.obs, categoryText: Consts.genderKey, paramName: Consts.otherVal),
    FilterModel(filterText: "Men", isSelected: false.obs, categoryText: Consts.genderKey, paramName: Consts.maleVal),
  ];
  List<FilterModel> inStockFilterList = [
    FilterModel(
        filterText: "In Stock",
        isSelected: false.obs,
        categoryText: Consts.abailibilityByKey,
        paramName: Consts.inStockVal),
    FilterModel(
        filterText: "In Waiting",
        isSelected: false.obs,
        categoryText: Consts.abailibilityByKey,
        paramName: Consts.inWaitingVal),
  ];
  List<FilterModel> shortByFilterList = [
    FilterModel(filterText: "Best Sellers", isSelected: false.obs, categoryText: Consts.shortByKey),
    FilterModel(
        filterText: "Top Rated", isSelected: false.obs, categoryText: Consts.shortByKey, paramName: Consts.topRatedVal),
    FilterModel(filterText: "Newest", isSelected: false.obs, categoryText: Consts.shortByKey),
    FilterModel(
        filterText: "Price: Low to High",
        isSelected: false.obs,
        categoryText: Consts.shortByKey,
        paramName: Consts.priceLhVal),
    FilterModel(
        filterText: "Price: High to Low",
        isSelected: false.obs,
        categoryText: Consts.shortByKey,
        paramName: Consts.priceHlVal),
    FilterModel(filterText: "Name(A-Z)", isSelected: false.obs, categoryText: Consts.shortByKey),
    FilterModel(filterText: "Name(Z-A)", isSelected: false.obs, categoryText: Consts.shortByKey),
  ];
  RxList<FilterModel> selectedFilterList = <FilterModel>[].obs;

  //Search API Handlers
  Rx<ViewProductListModel?> searchProductListModel = Rx<ViewProductListModel?>(null);
  TextEditingController searchController = TextEditingController();
  Timer? timer;

  //handlers of the table pagination
  RxInt selectedSearchTableIndex = 0.obs;
  RxInt searchPageLength = 0.obs;
  final ItemScrollController searchItemScrollController = ItemScrollController();

  void tabHandleOfSearchProduct() {
    selectedSearchTableIndex.value = 0;
    getSearchList(pageIndex: 1);
  }

  void onDeleteFilterBtnTapped({required FilterModel element, required int index}) {
    debugPrint("onDeleteFilterBtnTapped-------------------->");
    element.isSelected.value = false;
    selectedFilterList.removeAt(index);
    onSearchFieldAndFilterChanged();
  }

  void onResetAllBtnTapped() {
    debugPrint("onResetAllBtnTapped-------------------->");
    for (var element in selectedFilterList) {
      element.isSelected.value = false;
    }
    selectedFilterList.clear();
    onSearchFieldAndFilterChanged();
  }

  Future<void> getSearchList({int? pageIndex}) async {
    debugPrint("getSearchList ------------------------->");
    showLoader();

    Map<String, dynamic> passData = {
      Consts.pageKey: (pageIndex != null) ? pageIndex.toString() : 1.toString(),
      Consts.limitKey: Consts.limitValKey.toString(),
    };

    passData.addParamsIfNotNull(key: Consts.searchNameKey, value: searchController.text);

    List<String> colorHueList = [];
    List<String> metalList = [];
    List<String> clarityList = [];
    List<num> priceList = [];

    for (var element in selectedFilterList) {
      //Single Selection
      if (element.categoryText == Consts.shapeKey) {
        passData.addParamsIfNotNull(key: element.categoryText, value: element.filterText);
      }
      if (element.categoryText == Consts.genderKey) {
        passData.addParamsIfNotNull(key: element.categoryText, value: element.paramName);
      }
      if (element.categoryText == Consts.abailibilityByKey) {
        passData.addParamsIfNotNull(key: element.categoryText, value: element.paramName);
      }
      if (element.categoryText == Consts.shortByKey) {
        passData.addParamsIfNotNull(key: element.categoryText, value: element.paramName);
      }

      //Multiple Selection
      if (element.categoryText == Consts.colorHueKey) {
        colorHueList.add(element.filterText);
      }
      if (element.categoryText == Consts.metalKey) {
        metalList.add(element.filterText);
      }
      if (element.categoryText == Consts.clarityKey) {
        clarityList.add(element.filterText);
      }

      //price
      if (element.categoryText == Consts.priceKey) {
        priceList.add(element.minPrice ?? 0);
        priceList.add(element.maxPrice ?? 0);
      }
    }

    passData.addParamsIfNotNull(key: Consts.colorHueKey, value: colorHueList.listStringify);
    passData.addParamsIfNotNull(key: Consts.metalKey, value: metalList.listStringify);
    passData.addParamsIfNotNull(key: Consts.clarityKey, value: clarityList.listStringify);

    //Price logic
    if (priceList.isNotEmpty) {
      // Find the minimum number
      num minNumber = priceList.reduce((min, current) => current < min ? current : min);

      // Find the maximum number
      num maxNumber = priceList.reduce((max, current) => current > max ? current : max);

      passData.addParamsIfNotNull(key: Consts.minPriceKey, value: minNumber);
      passData.addParamsIfNotNull(key: Consts.maxPriceKey, value: maxNumber);
    }

    debugPrint("passData: $passData");

    ///API Calling
    dynamic data = await ApiProvider.commonProvider(
      url: URLs.searchJewelleryUri,
      body: passData,
      header: ApiProvider.commonHeader(),
    );

    if (data != null) {
      searchProductListModel.value = ViewProductListModel.fromJson(data);

      if (searchProductListModel.value?.success == true) {
        debugPrint("API Success is true");
        getPageLength(
            totalNumberOfData: searchProductListModel.value?.totalNumberOfData ?? 0, pageLength: searchPageLength);
      } else {
        debugPrint("API Success is false: ${searchProductListModel.value?.message}");
        MyToasts.errorToast(toast: searchProductListModel.value?.message.toString() ?? "");
      }
    } else {
      debugPrint("Data is null");
    }

    hideLoader();
  }

  void onSearchFieldAndFilterChanged() {
    timer?.cancel();
    timer = Timer(const Duration(milliseconds: 300), () {
      debugPrint("onSearchFieldChanged----------------------------------------->");
      selectedSearchTableIndex.value = 0;
      getSearchList(pageIndex: 1);
    });
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

  Future<void> getCategoryList({bool? isNotLoader}) async {
    debugPrint("getCategoryList --------------------------->");

    if (isNotLoader != true) {
      showLoader();
    }

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

    if (isNotLoader != true) {
      hideLoader();
    }
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
          body: passData,
          header: ApiProvider.commonHeader(),
        );

        if (data != null) {
          DeleteModel deleteModel = DeleteModel.fromJson(data);

          if (deleteModel.success == true) {
            debugPrint("API Success is true");
            categoryListModel.value?.data?.removeWhere((element) => (element.id == categoryID) ? true : false);

            bool isCurrentElementPresentInList = false;
            categoryListModel.value?.data?.forEach((ele) {
              if (ele.id == selectedProductCategoryID.value) {
                isCurrentElementPresentInList = true;
              }
            });
            if (isCurrentElementPresentInList != true) {
              if (selectedProductCategoryID.value != null) {
                selectedProductCategoryID.value = null;
              }
              if (selectedProductType.value != null) {
                selectedProductType.value = null;
              }
            }

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
      memoryFileModel.value =
          MemoryFileModel(byteList: null.obs, netImagePath: element.categoryImage ?? "", isRefreshVideo: false.obs);
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
            child: STxt(
              txt: (element != null) ? "Edit Category" : "Add Category",
              style: CustomTextStyle.dialogTitleStyle,
            ),
          ),
          const SizedBox(height: 15),
          STxt(
            txt: "Category Image",
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
          STxt(
            txt: "Product Type",
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
          STxt(
            txt: "Product Category Name",
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
                    header: ApiProvider.commonHeader(),
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
        isRefreshVideo: false.obs,
      );
      return memoryFileModel;
    } else {
      debugPrint("Image Picker Value is Null");
      return null;
    }
  }
}
