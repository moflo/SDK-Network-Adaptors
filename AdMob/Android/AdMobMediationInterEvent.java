/**
 * Copyright (c) 2013 AppLovin.
 */
package YOUR_PACKAGE_NAME;

import android.app.Activity;

import com.applovin.adview.AppLovinInterstitialAd;
import com.applovin.adview.AppLovinInterstitialAdDialog;
import com.applovin.sdk.AppLovinAd;
import com.applovin.sdk.AppLovinAdDisplayListener;
import com.applovin.sdk.AppLovinAdLoadListener;
import com.applovin.sdk.AppLovinAdSize;
import com.applovin.sdk.AppLovinSdk;
import com.google.ads.mediation.MediationAdRequest;
import com.google.ads.mediation.customevent.CustomEventInterstitial;
import com.google.ads.mediation.customevent.CustomEventInterstitialListener;

/**
 * This class must be defined and referenced from AdMob's website for AdMob Mediation
 * 
 * @author David Anderson
 * @since 4.2
 */
public class AdMobMediationInterEvent implements CustomEventInterstitial
{
    private Activity   mActivity;
    private AppLovinAd lastAd;

    /**
     * This method will be called by AdMob's Mediation through Custom Event mechanism.
     */
    @Override
    public void requestInterstitialAd(final CustomEventInterstitialListener listener,
            final Activity activity,
            String label,
            String serverParameter,
            MediationAdRequest request,
            Object unused)
    {
        mActivity = activity;

        AppLovinSdk.getInstance( activity ).getAdService().loadNextAd( AppLovinAdSize.INTERSTITIAL, new AppLovinAdLoadListener() {
            @Override
            public void adReceived(AppLovinAd ad)
            {
                lastAd = ad;
                listener.onReceivedAd();
            }

            @Override
            public void failedToReceiveAd(int errorCode)
            {
                listener.onFailedToReceiveAd();
            }
        } );
    }

    @Override
    public void showInterstitial()
    {
        if ( lastAd == null ) return;
        if ( mActivity == null ) return;

        AppLovinInterstitialAdDialog dialog = AppLovinInterstitialAd.create( AppLovinSdk.getInstance( mActivity ), mActivity );

        dialog.setAdDisplayListener( new AppLovinAdDisplayListener() {
            @Override
            public void adHidden(AppLovinAd ad)
            {
                listener.onDismissScreen();
            }

            @Override
            public void adDisplayed(AppLovinAd ad)
            {
                listener.onPresentScreen();
            }
        } );

        dialog.showAndRender( lastAd );
    }

    @Override
    public void destroy()
    {
        lastAd = null;
        mActivity = null;
    }
}