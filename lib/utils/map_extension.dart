extension MapExtension on Map<String, dynamic> {
  void addInnerParamsIfNotNull({required String key, required dynamic value}) {
    if (value != null && (value is String ? value.isNotEmpty : true) && (value is List ? value.isNotEmpty : true)) {
      addAll({
        '"$key"': (value is List)
            ? value.toString()
            : '"${(value is String) ? value.replaceAll("\n", " ") : value.toString()}"'
      });
    }
  }

  void addParamsIfNotNull({required String key, required dynamic value}) {
    if (value != null && (value is String ? value.isNotEmpty : true) && (value is List ? value.isNotEmpty : true)) {
      addAll({key: (value.runtimeType == String) ? value.toString().replaceAll("\n", " ") : value.toString()});
    }
  }
}
