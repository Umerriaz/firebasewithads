import 'dart:io';

class AdHelper {
  // a function woth return type of string
// if we want to use these all functions without creating instance we make them static
  static String homepageBanner() {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/6300978111";
    } else {
      return "";
    }
  }

  static String signoutpageInterstatial() {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/1033173712";
    } else {
      return "";
    }
  }

  static String rewardedAd() {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/5224354917";
    } else {
      return "";
    }
  }
}
