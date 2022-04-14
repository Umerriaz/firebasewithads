import 'package:firebasewithads/ad_helper.dart';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdProvider with ChangeNotifier {
  bool ishomepagead = false;
  bool isfullscreenad = false;

  late BannerAd homepagead;
  late InterstitialAd fullscreenad;
  RewardedAd? _rewardedAd;

  void intitializeHomepageBanner() async {
    homepagead = BannerAd(
      size: AdSize.banner,
      adUnitId: AdHelper.homepageBanner(),
      listener: BannerAdListener(onAdLoaded: ((ad) {
        ishomepagead = true;
        print("Bannerad on homepage loaded ");
      }), onAdClosed: (ad) {
        ad.dispose();
        ishomepagead = false;
      }, onAdFailedToLoad: (ad, err) {
        print("Failed to load ad: Error is ${err.toString()} !!!! ");
        ishomepagead = false;
      }),
      request: AdRequest(),
    ); //banner ad
    await homepagead.load();
    notifyListeners();
  }

  ///intitializeHomepageBanner////
  ///initialization of banner ad is a little different from interstacial ad

  void initializeFullpageInterstaticial() async {
    await InterstitialAd.load(
        adUnitId: AdHelper.signoutpageInterstatial(),
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
          fullscreenad = ad;
          print("full page ad loaded");
          isfullscreenad = true;
        }, onAdFailedToLoad: (err) {
          print(err.toString());
          isfullscreenad = false;
        }));
    notifyListeners();
  }

  void loadRewardad() {
    RewardedAd.load(
        adUnitId: AdHelper.rewardedAd(),
        request: AdRequest(),
        rewardedAdLoadCallback:
        RewardedAdLoadCallback(onAdLoaded: (RewardedAd ad) {
          this._rewardedAd = ad;
        }, onAdFailedToLoad: (err) {
          print("Add failed to load $err");
        }));
  }

  void showRewardad() {
    _rewardedAd?.show(onUserEarnedReward: (ad, rewardItem) {
      print("rewards erned and point are: ${rewardItem.amount}");
    });

    _rewardedAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        print("reward earned");
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
      },
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        ad.dispose();
      },
      onAdImpression: (ad) {
        print('$ad impression occurred.');
      },
    );
  }
}
