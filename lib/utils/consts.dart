class URLs {
  /// Local
  static const String ipAddress = '127.0.0.1';
  static const String port = '8001';
  static const String baseUrl = 'http://$ipAddress:$port/admin/v1/auth';

  ///Dev(for developer and tester use)
// String baseUrl = 'https://ad-anima.com:8081/v1/user';

  ///Staging(for client use)
// String baseUrl = 'https://ad-anima.com:8080/v1/user';

  ///Live(for production use)
  // String baseUrl = 'https://ad-anima.com:8082/v1/user';

  ///All Uri
  static const String adminLoginUri = "${URLs.baseUrl}/admin_login";
  static const String adminLogoutUri = "${URLs.baseUrl}/admin_logout";
  static const String adminChangePasswordUri = "${URLs.baseUrl}/admin_change_password";

  ///Jewelery Operations
  static const String addJewelleryUri = "${URLs.baseUrl}/add_jewellery";
  static const String jewelleryListUri = "${URLs.baseUrl}/jewellery_list";
  static const String jewelleryDetailsUri = "${URLs.baseUrl}/jewellery_details";
  static const String deleteJewelleryUri = "${URLs.baseUrl}/delete_jewellery";

  ///Category Operations
  static const String categoryListUri = "${URLs.baseUrl}/category_list";
  static const String addCategoryUri = "${URLs.baseUrl}/add_category";
  static const String editCategoryUri = "${URLs.baseUrl}/edit_category";
  static const String deleteCategoryUri = "${URLs.baseUrl}/delete_category";
}

class Consts {
  ///User Login Data
  static const String userDataKey = "user_data";

  ///Comparison Keys..................................
  static const String ringKey = "Ring";
  static const String earringKey = "Earring";
  static const String necklaceKey = "Necklace";
  static const String braceletKey = "Bracelet";
  static const String diamondKey = "Diamond";
  static const String customKey = "Custom";

  ///Add Jewellery API
  static const String categoryIdKey = "category_id";
  static const String nameKey = "name";
  static const String subTitleKey = "sub_title";
  static const String descriptionKey = "description";
  static const String genderKey = "gender";
  static const String generalPriceKey = "general_price";
  static const String diamondDetailsKey = "diamond_details";
  static const String sideDiamondDetailsKey = "side_diamond_details";
  static const String shippingDetailsKey = "shipping_details";
  static const String customShippingDetailsKey = "custom_shipping_details";
  static const String returnDetailsKey = "return_details";
  static const String customReturnDetailsKey = "custom_return_details";
  static const String visualDetailKey = "visual_detail";
  static const String additionalDetailsKey = "additional_details";
  static const String stoneTypeKey = "stone_type";
  static const String creationMethodKey = "creation_method";
  static const String shapeKey = "shape";
  static const String colorKey = "color";
  static const String colorHueKey = "color_hue";
  static const String clarityKey = "clarity";
  static const String cutGradeKey = "cut_grade";
  static const String countKey = "count";
  static const String carateWeightKey = "carate_weight";
  static const String totalCarateWeightKey = "total_carate_weight";
  static const String settingKey = "setting";
  static const String polishKey = "polish";
  static const String symmetryKey = "symmetry";
  static const String depthKey = "depth";
  static const String tableKey = "table";
  static const String measurementsKey = "measurements";
  static const String metalTypeColorKey = "metal_type_color";
  static const String rhodiumPlatedKey = "rhodium_plated";
  static const String metalVisePriceKey = "metal_vise_price";
  static const String productImagesKey = "product_images";
  static const String productVideoKey = "product_video";
  static const String productSkuKey = "product_sku";
  static const String styleKey = "style";
  static const String generalRhodiumPlatedKey = "general_rhodium_plated";
  static const String averageWidthKey = "average_width";
  static const String caratTotalWeightKey = "carat_total_weight";
  static const String backTypeKey = "back_type";
  static const String earringLengthKey = "earring_length";
  static const String earringWidthKey = "earring_width";
  static const String pendantLengthKey = "pendant_length";
  static const String pendantWidthKey = "pendant_width";
  static const String chainLengthKey = "chain_length";
  static const String chainWidthKey = "chain_width";
  static const String braceletLengthKey = "bracelet_length";
  static const String braceletWidthKey = "bracelet_width";
  static const String chainTypeKey = "chain_type";
  static const String claspTypeKey = "clasp_type";
  static const String jewelleryIdKey = "jewellery_id";

  ///Change Pass
  static const String oldPasswordKey = "old_password";
  static const String newPasswordKey = "new_password";

  ///Auth
  static const String emailAddressKey = "email_address";
  static const String passwordKey = "password";

  ///Category
  static const String categoryNameKey = "category_name";
  static const String categoryImageKey = "category_image";

  ///Other || General Parameters
  static const String pageKey = "page";
  static const String limitKey = "limit";
  static const int limitValKey = 10;
  static const String statuscodeKey = "statuscode";
  static const String successKey = "success";
}
