/**
 * AppLovin Interstitial SDK Mediation for MoPub
 * 
 * @author Matt Szaro
 * @version 1.1
 **/

package YOUR_PKG_NAME;

import java.util.Map;

import android.app.Activity;
import android.content.Context;
import android.util.Log;

import com.applovin.adview.AppLovinAdView;
import com.applovin.sdk.AppLovinAd;
import com.applovin.sdk.AppLovinAdLoadListener;
import com.applovin.sdk.AppLovinAdService;
import com.applovin.sdk.AppLovinAdSize;
import com.applovin.sdk.AppLovinSdk;
import com.mopub.mobileads.CustomEventInterstitial;
import com.mopub.mobileads.MoPubErrorCode;

public class AppLovinInterstitial extends CustomEventInterstitial
        implements AppLovinAdLoadListener
{
    private CustomEventInterstitial.CustomEventInterstitialListener mInterstitialListener;
    private Context context;
    private Activity parentActivity;
    private AppLovinAdService adService;
    private AppLovinAd lastReceived;

    /*
     * Abstract methods from CustomEventInterstitial
     */
    @Override
    public void loadInterstitial(Context context, CustomEventInterstitial.CustomEventInterstitialListener interstitialListener, Map<String, Object> localExtras, Map<String, String> serverExtras)
    {
        mInterstitialListener = interstitialListener;

        if (context instanceof Activity)
        {
            parentActivity = (Activity) context;
        }
        else
        {
            mInterstitialListener.onInterstitialFailed(MoPubErrorCode.INTERNAL_ERROR);
            return;
        }

        adService = AppLovinSdk.getInstance(context).getAdService();
        adService.loadNextAd(AppLovinAdSize.INTERSTITIAL, this);

        Log.d("AppLovinAdapter", "Interstitial loaded.");
    }

    @Override
    public void showInterstitial()
    {
        final AppLovinAd adToRender = lastReceived;

        if (adToRender != null)
        {
            Log.d("MoPub", "Showing AppLovin interstitial ad...");

            parentActivity.runOnUiThread(new Runnable() {
                public void run()
                {   
                    AppLovinAdView adView = new AppLovinAdView(AppLovinAdSize.BANNER, parentActivity);
                    adView.renderAd(adToRender);

                    mInterstitialListener.onInterstitialShown();
                }
            });
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
                mInterstitialListener.onInterstitialLoaded();

            }
        });
    }

    @Override
    public void failedToReceiveAd(int errorCode)
    {
        if (errorCode == 202)
        {
            mInterstitialListener.onInterstitialFailed(MoPubErrorCode.NO_FILL);
        }
        else if (errorCode >= 500)
        {
            mInterstitialListener.onInterstitialFailed(MoPubErrorCode.SERVER_ERROR);
        }
        else if (errorCode < 0)
        {
            mInterstitialListener.onInterstitialFailed(MoPubErrorCode.INTERNAL_ERROR);
        }
        else
        {
            mInterstitialListener.onInterstitialFailed(MoPubErrorCode.UNSPECIFIED);
        }
    }

}