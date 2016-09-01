package YOUR_PACKAGE_NAME;

import android.app.Activity;
import android.util.Log;
import android.view.View;

import com.applovin.nativeAds.AppLovinNativeAd;
import com.applovin.nativeAds.AppLovinNativeAdLoadListener;
import com.applovin.sdk.AppLovinPostbackListener;
import com.applovin.sdk.AppLovinSdk;
import com.mopub.nativeads.CustomEventNative;
import com.mopub.nativeads.NativeErrorCode;
import com.mopub.nativeads.NativeImageHelper;
import com.mopub.nativeads.StaticNativeAd;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

public class AppLovinNativeAdapter extends CustomEventNative implements AppLovinNativeAdLoadListener {

    private CustomEventNativeListener mNativeListener;
    private Activity parentActivity;
    private View mView;

    private String TAG = "MopubAppLovinNativeAdapter";

    @Override
    public void loadNativeAd(Activity activity, CustomEventNativeListener interstitialListener, Map<String, Object> localExtras, Map<String, String> serverExtras) {


        mNativeListener = interstitialListener;
        parentActivity = activity;

        Log.d(TAG, "Request received for new native ad.");

        AppLovinSdk sdk = AppLovinSdk.getInstance(activity);
        sdk.setPluginVersion("MoPubNative-1.0");
        sdk.getNativeAdService().loadNativeAds(1, this);
    }


    @Override
    public void onNativeAdsLoaded(List nativeAds)

    {
        Log.d(TAG, "AppLovin Native ad loaded successfully.");
        final List<AppLovinNativeAd> nativeAdsList = (List<AppLovinNativeAd>) nativeAds;
        parentActivity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                precacheImage(new AppLovinMopubNativeAd(nativeAdsList.get(0)));
            }
        });


    }

    @Override
    public void onNativeAdsFailedToLoad(final int errorCode) {
        parentActivity.runOnUiThread(new Runnable() {
            public void run() {
                if (errorCode == 204) {
                    mNativeListener.onNativeAdFailed(NativeErrorCode.NETWORK_NO_FILL);
                } else if (errorCode >= 500) {
                    mNativeListener.onNativeAdFailed(NativeErrorCode.SERVER_ERROR_RESPONSE_CODE);
                } else if (errorCode < 0) {
                    mNativeListener.onNativeAdFailed(NativeErrorCode.NETWORK_INVALID_REQUEST);
                } else {
                    mNativeListener.onNativeAdFailed(NativeErrorCode.UNSPECIFIED);
                }
            }
        });


    }


    public class AppLovinMopubNativeAd extends StaticNativeAd

    {

        AppLovinNativeAd mNativeAd;
        boolean isImpressionTracked;



        public AppLovinMopubNativeAd(AppLovinNativeAd nativeAd) {


            mNativeAd = nativeAd;

            setTitle(nativeAd.getTitle());
            setText(nativeAd.getDescriptionText());
            setIconImageUrl(nativeAd.getIconUrl());
            setMainImageUrl(nativeAd.getImageUrl());
            setCallToAction(nativeAd.getCtaText());
            double startRatingDouble = nativeAd.getStarRating();
            setStarRating(startRatingDouble);
            setClickDestinationUrl(nativeAd.getClickUrl());

            isImpressionTracked = false;

        }


        private void trackImpression(final AppLovinNativeAd nativeAd) {
        
	        if(isImpressionTracked) return;

            final AppLovinSdk sdk = AppLovinSdk.getInstance(parentActivity);
            final String impressionUrl = nativeAd.getImpressionTrackingUrl();
            sdk.getPostbackService().dispatchPostbackAsync(impressionUrl, new AppLovinPostbackListener() {
                @Override
                public void onPostbackSuccess(String url) {
                    notifyAdImpressed();
                    isImpressionTracked = true;
                }

                @Override
                public void onPostbackFailure(String url, int errorCode) {
                    Log.d(TAG, "Failed to track impression.");
                }
            });
        }

        @Override
        public void prepare(View view) {
            trackImpression(mNativeAd);
        }


        /**
         * use the code below if you would like AppLovin to handle the ad clicks for you:
         *

        @Override
        public void prepare(View view) {
            mView = view;
            mView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    mNativeAd.launchClickTarget(parentActivity);
                    notifyAdClicked();
                }
            });
            trackImpression(mNativeAd);
        }

        @Override
        public void clear(View view) {
            mView = null;
        }

        **/

        @Override
        public void destroy() {
            mNativeListener = null;
            parentActivity = null;
        }

    }

    private void precacheImage(final AppLovinMopubNativeAd appLovinMopubNativeAd) {

        String[] urls = {appLovinMopubNativeAd.getIconImageUrl(), appLovinMopubNativeAd.getMainImageUrl()};

        NativeImageHelper.preCacheImages(parentActivity, Arrays.asList(urls), new NativeImageHelper.ImageListener() {
            @Override
            public void onImagesCached() {
                parentActivity.runOnUiThread(new Runnable() {
                    @Override
                    public void run() {

                        Log.i(TAG, "AppLovin native ad images were loaded successfully.");
                        mNativeListener.onNativeAdLoaded(appLovinMopubNativeAd);

                    }
                });

            }

            @Override
            public void onImagesFailedToCache(NativeErrorCode nativeErrorCode) {

                parentActivity.runOnUiThread(new Runnable() {
                    @Override
                    public void run() {

                        mNativeListener.onNativeAdLoaded(appLovinMopubNativeAd);

                    }
                });

            }
        });

    }


}
