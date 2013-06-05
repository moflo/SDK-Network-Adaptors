/**
 * AppLovin Interstitial SDK Mediation for MoPub
 * 
 * @author Matt Szaro
 * @version 1.0
 **/

package com.applovin.sdkdemo.matt;

import java.util.Map;

import android.app.Activity;
import android.content.Context;
import android.util.Log;
import android.widget.Toast;

import com.applovin.adview.AppLovinAdView;
import com.applovin.sdk.AppLovinAd;
import com.applovin.sdk.AppLovinAdLoadListener;
import com.applovin.sdk.AppLovinAdService;
import com.applovin.sdk.AppLovinAdSize;
import com.applovin.sdk.AppLovinSdk;
import com.mopub.mobileads.CustomEventInterstitial;

public class AppLovinInterstitial extends CustomEventInterstitial
        implements AppLovinAdLoadListener
{
    private CustomEventInterstitial.Listener mInterstitialListener;
    private Context context;
    private Activity parentActivity;
    private AppLovinAdService adService;
    private AppLovinAd lastReceived;

    /*
     * Abstract methods from CustomEventInterstitial
     */
    @Override
    public void loadInterstitial(Context context, CustomEventInterstitial.Listener interstitialListener, Map<String, Object> localExtras, Map<String, String> serverExtras)
    {
        mInterstitialListener = interstitialListener;

        if (context instanceof Activity)
        {
            parentActivity = (Activity) context;
        }
        else
        {
            mInterstitialListener.onAdFailed();
            return;
        }

        adService = AppLovinSdk.getInstance(context).getAdService();
        adService.loadNextAd(AppLovinAdSize.INTERSTITIAL, this);

        Log.d("AppLovinAdapter", "Interstitial loaded.");
    }

    @Override
    public void showInterstitial()
    {
        Toast.makeText(context, "Called native AppLovin SDK, not RTB.", Toast.LENGTH_LONG).show();
        final AppLovinAd adToRender = lastReceived;

        if (adToRender != null)
        {
            Log.d("MoPub", "Showing AppLovin interstitial ad...");

            parentActivity.runOnUiThread(new Runnable() {
                public void run()
                {
                    AppLovinAdView adView = new AppLovinAdView(AppLovinAdSize.BANNER, parentActivity);
                    adView.renderAd(adToRender);

                    mInterstitialListener.onShowInterstitial();
                }
            });
        }
        else
        {
            Log.e("MoPub", "Unable to ");
        }
    }

    @Override
    public void onInvalidate()
    {

    }

    @Override
    public void adReceived(AppLovinAd ad)
    {
        Log.d("MoPub", "AppLovin interstitial loaded successfully.");

        lastReceived = ad;

        parentActivity.runOnUiThread(new Runnable() {
            public void run()
            {
                mInterstitialListener.onAdLoaded();

            }
        });
    }

    @Override
    public void failedToReceiveAd(int errorCode)
    {
        parentActivity.runOnUiThread(new Runnable() {
            public void run()
            {
                mInterstitialListener.onAdFailed();
            }
        });
    }

}