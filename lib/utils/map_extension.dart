extension MapExtension on Map<String, dynamic> {
  void addInnerParamsIfNotNull({required String key, required dynamic value}) {
    if (value != null) {
      addAll({
        '"$key"':
            '"${(value.runtimeType == String) ? value.toString().replaceAll("\n", " ") : value}"'
      });
    }
  }

  void addParamsIfNotNull({required String key, required dynamic value}) {
    if (value != null) {
      addAll({
        key: (value.runtimeType == String)
            ? value.toString().replaceAll("\n", " ")
            : value
      });
    }
  }
}
