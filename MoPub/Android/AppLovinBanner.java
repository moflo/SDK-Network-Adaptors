/**
 * AppLovin Banner SDK Mediation for MoPub
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
import com.applovin.sdk.AppLovinAdSize;
import com.applovin.sdk.AppLovinSdk;
import com.mopub.mobileads.CustomEventBanner;
import com.mopub.mobileads.MoPubErrorCode;

public class AppLovinBanner extends CustomEventBanner implements AppLovinAdLoadListener
{

    private CustomEventBanner.CustomEventBannerListener mBannerListener;
    private AppLovinAdView ALAdView;

    /*
     * Abstract methods from CustomEventBanner
     */
    @Override
    public void loadBanner(Context context,
            CustomEventBanner.CustomEventBannerListener bannerListener,
            Map localExtras, Map serverExtras)
    {
        mBannerListener = bannerListener;

        Activity activity = null;
        if (context instanceof Activity)
        {
            activity = (Activity) context;
        }
        else
        {
            mBannerListener.onBannerFailed(MoPubErrorCode.INTERNAL_ERROR);
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
        mBannerListener.onBannerLoaded(ALAdView);
        Log.d("AppLovinAdapter", "AdView was passed to MoPub.");
    }

    @Override
    public void failedToReceiveAd(int errorCode)
    {
        if (errorCode == 202)
        {
            mBannerListener.onBannerFailed(MoPubErrorCode.NO_FILL);
        }
        else if (errorCode >= 500)
        {
            mBannerListener.onBannerFailed(MoPubErrorCode.SERVER_ERROR);
        }
        else if (errorCode < 0)
        {
            mBannerListener.onBannerFailed(MoPubErrorCode.INTERNAL_ERROR);
        }
        else
        {
            mBannerListener.onBannerFailed(MoPubErrorCode.UNSPECIFIED);
        }
    }
}