import 'package:couter_app_with_ads/utills/helper/ads_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    ADSHelper.adsHelper.loadBannerAds();
    ADSHelper.adsHelper.loadInterAds();
    ADSHelper.adsHelper.loadRewardAds();
    Future.delayed(const Duration(seconds: 2), () {
      ADSHelper.adsHelper.loadNativeAds();
    });
  }

  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Counter App",
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: ADSHelper.adsHelper.bannerAd?.size.height.toDouble(),
            width: ADSHelper.adsHelper.bannerAd?.size.width.toDouble(),
            child: AdWidget(
              ad: ADSHelper.adsHelper.bannerAd!,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          OutlinedButton(
            onPressed: () {
              if (ADSHelper.adsHelper.interstitialAd != null) {
                ADSHelper.adsHelper.interstitialAd?.show();
              }
              ADSHelper.adsHelper.loadInterAds();
            },
            child: const Text("ADS"),
          ),
          const SizedBox(
            height: 20,
          ),
          OutlinedButton(
            onPressed: () {
              if (ADSHelper.adsHelper.rewardedAd != null) {
                ADSHelper.adsHelper.rewardedAd?.show(
                    onUserEarnedReward: (ad, reward) {
                  SnackBar snackBar = SnackBar(
                    content: Text("REWARDED : $reward"),
                    backgroundColor: Colors.green,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });
              }
            },
            child: const Text("Rewarded Ads"),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                counter.toString().padLeft(2, '0'),
                style: const TextStyle(
                  fontSize: 40,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 200,
            width: double.infinity,
            child: (ADSHelper.adsHelper.nativeAd != null)
                ? AdWidget(
                    ad: ADSHelper.adsHelper.nativeAd!,
                  )
                : const Text("Native Add is Come Here...."),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              counter++;
              setState(() {});
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            onPressed: () {
              counter--;
              setState(() {});
            },
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
