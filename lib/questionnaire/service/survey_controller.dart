import 'package:get/get.dart';

import '../../core/constants.dart';



//NavigationService navigation = NavigationService.instance;

class SurveyController extends GetxController {
  var count = 0.obs;
  var isVisibleChe = false.obs;
  var isVisibleLoc = true.obs;
  var isVisiblePho = false.obs;

  void increment() {
    count++;
    // ignore: unrelated_type_equality_checks
    if (count == 4) {
    //  navigation.navigateToPage(path: NavigationConstants.HOME_VIEW);
      count = 0.obs;
    }
  }

  void decrease() {
    count--;
    // ignore: unrelated_type_equality_checks
    if (count == -1) {
      count = 0.obs;
      //navigation.navigateToPage(path: NavigationConstants.LOGIN);
    }
  }

  void visibilityfunc() {
    // ignore: unrelated_type_equality_checks
    if (count == 0) {
      isVisibleLoc = true.obs;
      isVisiblePho = false.obs;
      isVisibleChe = false.obs;
    }
    // ignore: unrelated_type_equality_checks
    if (count == 1) {
      isVisibleLoc = false.obs;
      isVisiblePho = true.obs;
      isVisibleChe = false.obs;
    }
    // ignore: unrelated_type_equality_checks
    if (count == 2) {
      isVisibleChe = true.obs;
      isVisibleLoc = false.obs;
      isVisiblePho = false.obs;
    }
    // ignore: unrelated_type_equality_checks
    if (count == 3) {
      isVisibleChe = true.obs;
      isVisibleLoc = false.obs;
      isVisiblePho = false.obs;
    }
  }

  Future<List<String>> fetchSuggestions(String searchValue) async {
    await Future.delayed(const Duration(milliseconds: 750));

    List<String> _suggestions = countryList;
    List<String> _filteredSuggestions = _suggestions.where((element) {
      return element.toLowerCase().contains(searchValue.toLowerCase());
    }).toList();

    return _filteredSuggestions;
  }
}
