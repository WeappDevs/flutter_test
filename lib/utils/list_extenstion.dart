extension ListExtension on List<String> {
  List<String> get listStringify {
    List<String> returnList = [];

    for (var element in this) {
      returnList.add('"$element"');
    }

    return returnList;
  }
}
