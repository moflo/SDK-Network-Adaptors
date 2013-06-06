/**
 * AppLovin Banner SDK Mediation for MoPub
 * Copyright (C) 2013 AppLovin. 
 *
 * @author Matt Szaro
 * @version 1.0
 **/

package YOUR_PACKAGE_NAME;

import java.util.Map;

import android.app.Activity;
import android.content.Context;
import android.util.Log;
import android.widget.Toast;

import com.applovin.adview.AppLovinAdView;
import com.applovin.sdk.AppLovinAd;
import com.applovin.sdk.AppLovinAdLoadListener;
import com.applovin.sdk.AppLovinAdSize;
import com.applovin.sdk.AppLovinSdk;
import com.mopub.mobileads.CustomEventBanner;

public class AppLovinBanner extends CustomEventBanner implements
        AppLovinAdLoadListener
{
    private CustomEventBanner.Listener mBannerListener;
    private AppLovinAdView ALAdView;

    /*
     * Abstract methods from CustomEventBanner
     */
    @Override
    public void loadAd(Context context,
            CustomEventBanner.Listener bannerListener,
            Map<String, Object> localExtras, Map<String, String> serverExtras)
    {
        Toast.makeText(context, "Called native AppLovin SDK, not RTB.", Toast.LENGTH_LONG).show();
        mBannerListener = bannerListener;

        Activity activity = null;
        if (context instanceof Activity)
        {
            activity = (Activity) context;
        }
        else
        {
            mBannerListener.onAdFailed();
            return;
        }

        Log.d("AppLovinAdapter", "Reqeust received for new BANNER.");

        ALAdView = new AppLovinAdView(AppLovinSdk.getInstance(context), AppLovinAdSize.BANNER, activity);
        ALAdView.setAdLoadListener(this);
        ALAdView.loadNextAd();
    }

    @Override
    public void onInvalidate()
    {
        ALAdView.setAdLoadListener(null);
    }

    @Override
    public void adReceived(AppLovinAd ad)
    {
        mBannerListener.setAdContentView(ALAdView);
        Log.d("AppLovinAdapter", "AdView was passed to MoPub.");
        mBannerListener.onAdLoaded();
    }

    @Override
    public void failedToReceiveAd(int errorCode)
    {
        mBannerListener.onAdFailed();
    }
}