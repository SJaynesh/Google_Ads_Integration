import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logger/logger.dart';

class ADSHelper {
  ADSHelper._();

  static ADSHelper adsHelper = ADSHelper._();

  BannerAd? bannerAd;
  InterstitialAd? interstitialAd;
  RewardedAd? rewardedAd;
  NativeAd? nativeAd;
  Logger logger = Logger();

  Future<void> loadBannerAds() async {
    bannerAd = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: Platform.isAndroid
          ? "ca-app-pub-3940256099942544/6300978111"
          : "ca-app-pub-3940256099942544/2934735716",
      listener: const BannerAdListener(),
      request: const AdRequest(),
    )..load();
  }

  void loadInterAds() {
    InterstitialAd.load(
      adUnitId: Platform.isAndroid
          ? "ca-app-pub-3940256099942544/1033173712"
          : "ca-app-pub-3940256099942544/4411468910",
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          interstitialAd = ad;
        },
        onAdFailedToLoad: (error) {
          logger.e("ERROR : $error");
        },
      ),
    );
  }

  void loadRewardAds() {
    RewardedAd.load(
      adUnitId: (Platform.isAndroid)
          ? "ca-app-pub-3940256099942544/5224354917"
          : "ca-app-pub-3940256099942544/1712485313",
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          rewardedAd = ad;
        },
        onAdFailedToLoad: (error) {
          logger.e("REWARDED ERROR : $error");
        },
      ),
    );
  }

  void loadOpenAds() {}

  Future<void> loadNativeAds() async {
    nativeAd = NativeAd(
      adUnitId: "ca-app-pub-3940256099942544/2247696110",
      listener: NativeAdListener(),
      request: const AdRequest(),
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.medium,
        primaryTextStyle: NativeTemplateTextStyle(
          size: 25,
          textColor: Colors.black,
        ),
        secondaryTextStyle: NativeTemplateTextStyle(
          size: 25,
          textColor: Colors.black,
        ),
        tertiaryTextStyle: NativeTemplateTextStyle(
          size: 25,
          textColor: Colors.black,
        ),
        callToActionTextStyle: NativeTemplateTextStyle(
          size: 25,
          textColor: Colors.black,
        ),
        cornerRadius: 20,
        mainBackgroundColor: Colors.blue.shade200,
      ),
    );

    await nativeAd?.load().then(
      (value) {
        logger.i("Native add Loaded...");
      },
    ).onError(
      (error, stackTrace) {
        logger.e("ERROR : $error");
      },
    );
  }
}
