/**
 * AppLovin Banner SDK Mediation for MoPub
 * 
 * @author Matt Szaro
 * @version 1.2
 **/

package YOUR_PACKAGE_NAME;

import android.app.Activity;
import android.content.Context;
import android.util.Log;
import com.applovin.adview.AppLovinAdView;
import com.applovin.sdk.*;
import com.mopub.mobileads.CustomEventBanner;
import com.mopub.mobileads.MoPubErrorCode;

import java.util.Map;

public class AppLovinBanner extends CustomEventBanner implements AppLovinAdLoadListener, AppLovinAdClickListener
{

    private CustomEventBanner.CustomEventBannerListener mBannerListener;
    private AppLovinAdView                              adView;

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
        if ( context instanceof Activity )
        {
            activity = (Activity) context;
        }
        else
        {
            mBannerListener.onBannerFailed( MoPubErrorCode.INTERNAL_ERROR );
            return;
        }

        Log.d( "AppLovinAdapter", "Request received for new BANNER." );

        adView = new AppLovinAdView( AppLovinSdk.getInstance( context ), AppLovinAdSize.BANNER, activity );
        adView.setAutoDestroy( false );
        adView.setAdLoadListener( this );
        adView.setAdClickListener( this );
        adView.loadNextAd();
    }

    @Override
    public void onInvalidate()
    {
        adView.destroy();
    }

    @Override
    public void adReceived(AppLovinAd ad)
    {
        mBannerListener.onBannerLoaded( adView );
        Log.d( "AppLovinAdapter", "AdView was passed to MoPub." );
    }

    @Override
    public void failedToReceiveAd(int errorCode)
    {
        if ( errorCode == 204 )
        {
            mBannerListener.onBannerFailed( MoPubErrorCode.NO_FILL );
        }
        else if ( errorCode >= 500 )
        {
            mBannerListener.onBannerFailed( MoPubErrorCode.SERVER_ERROR );
        }
        else if ( errorCode < 0 )
        {
            mBannerListener.onBannerFailed( MoPubErrorCode.INTERNAL_ERROR );
        }
        else
        {
            mBannerListener.onBannerFailed( MoPubErrorCode.UNSPECIFIED );
        }
    }

    @Override
    public void adClicked(AppLovinAd appLovinAd)
    {
        mBannerListener.onLeaveApplication();
    }
}