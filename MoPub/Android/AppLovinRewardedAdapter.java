package YOUR_PACKAGE_NAME;

import android.app.Activity;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.util.Log;

import com.applovin.sdk.AppLovinAd;
import com.applovin.sdk.AppLovinAdLoadListener;
import com.applovin.sdk.AppLovinAdClickListener;
import com.applovin.sdk.AppLovinAdRewardListener;
import com.applovin.sdk.AppLovinAdDisplayListener;
import com.applovin.adview.AppLovinIncentivizedInterstitial;
import com.mopub.common.LifecycleListener;
import com.mopub.common.MoPubReward;
import com.mopub.mobileads.CustomEventRewardedVideo;
import com.mopub.mobileads.MoPubErrorCode;
import com.mopub.mobileads.MoPubRewardedVideoManager;

import java.util.Map;

public class AppLovinRewardedAdapter extends CustomEventRewardedVideo implements AppLovinAdLoadListener, AppLovinAdClickListener,
        AppLovinAdDisplayListener, AppLovinAdRewardListener {

    private volatile static boolean adReady = false;
    private volatile static boolean initialized = false;
    private static final boolean loggingEnabled = true;

    private AppLovinIncentivizedInterstitial mIncent;
    private Activity parentActivity;

    @Override
    protected boolean checkAndInitializeSdk(@NonNull Activity activity, @NonNull Map<String, Object> localExtras,
                                            @NonNull Map<String, String> serverExtras) throws Exception {
        if (!initialized) {
            ALLog("Initializing AppLovin SDK for rewarded video.");
            initialized = true;

            return true;
        } else {
            return false;
        }
    }

    @Override
    @Nullable
    protected LifecycleListener getLifecycleListener() {
        return null;
    }

    @Override
    @NonNull
    protected String getAdNetworkId() {
        return "";
    }

    @Override
    protected void loadWithSdkInitialized(@NonNull Activity activity, @NonNull Map<String, Object> localExtras,
                                          @NonNull Map<String, String> serverExtras) throws Exception {
        ALLog("Loading rewarded video.");
        parentActivity = activity;
        mIncent = AppLovinIncentivizedInterstitial.create(activity);
        mIncent.preload(this);
    }

    @Override
    protected void onInvalidate() {
    }

    @Override
    @Nullable
    protected CustomEventRewardedVideoListener getVideoListenerForSdk() {
        return null;
    }

    @Override
    protected boolean hasVideoAvailable() {
        return adReady;
    }

    @Override
    protected void showVideo() {
        if (hasVideoAvailable()) {
            ALLog("Showing rewarded video.");
            mIncent.show(parentActivity, this, null, this, this);
            adReady = false;
        } else {
            ALLog("No rewarded video available to show.");
            MoPubRewardedVideoManager.onRewardedVideoPlaybackError(AppLovinRewardedAdapter.class, "",
                    MoPubErrorCode.VIDEO_PLAYBACK_ERROR);
        }
    }

    @Override
    public void adReceived(AppLovinAd ad) {
        ALLog("Rewarded video loaded.");
        adReady = true;
        MoPubRewardedVideoManager.onRewardedVideoLoadSuccess(AppLovinRewardedAdapter.class, "");
    }

    @Override
    public void failedToReceiveAd(final int errorCode) {
        ALLog("Rewarded video failed to load: " + errorCode);
        MoPubErrorCode error;

        switch (errorCode) {
            case 204:
                error = MoPubErrorCode.NO_FILL;
                break;
            default:
                error = MoPubErrorCode.INTERNAL_ERROR;
        }

        MoPubRewardedVideoManager.onRewardedVideoLoadFailure(AppLovinRewardedAdapter.class, "", error);
    }

    @Override
    public void adClicked(AppLovinAd ad) {
        ALLog("Rewarded video clicked.");
        MoPubRewardedVideoManager.onRewardedVideoClicked(AppLovinRewardedAdapter.class, "");
    }

    @Override
    public void adHidden(AppLovinAd ad) {
        ALLog("Ad hidden.");
        MoPubRewardedVideoManager.onRewardedVideoClosed(AppLovinRewardedAdapter.class, "");
    }

    @Override
    public void adDisplayed(AppLovinAd ad) {
        ALLog("Ad displayed.");
        MoPubRewardedVideoManager.onRewardedVideoStarted(AppLovinRewardedAdapter.class, "");
    }

    @Override
    public void userRewardVerified(AppLovinAd appLovinAd, Map map) {
        ALLog("Granting reward.");

        int amount = (int) Double.parseDouble((String) map.get("amount"));
        String currency = (String) map.get("currency");

        MoPubReward reward = MoPubReward.success(currency, amount);
        MoPubRewardedVideoManager.onRewardedVideoCompleted(AppLovinRewardedAdapter.class, "", reward);
    }

    @Override
    public void userOverQuota(AppLovinAd appLovinAd, Map map) {
        ALLog("User over quota.");
        MoPubRewardedVideoManager.onRewardedVideoCompleted(AppLovinRewardedAdapter.class, "", MoPubReward.failure());
    }

    @Override
    public void userRewardRejected(AppLovinAd appLovinAd, Map map) {
        ALLog("Reward rejected by AppLovin.");
        MoPubRewardedVideoManager.onRewardedVideoCompleted(AppLovinRewardedAdapter.class, "", MoPubReward.failure());
    }

    @Override
    public void validationRequestFailed(AppLovinAd appLovinAd, int i) {
        ALLog("Validation request to server failed or user closed ad early.");
        MoPubRewardedVideoManager.onRewardedVideoCompleted(AppLovinRewardedAdapter.class, "", MoPubReward.failure());
    }

    @Override
    public void userDeclinedToViewAd(AppLovinAd appLovinAd) {
        ALLog("User declined to view ad.");
        adReady = true;
        MoPubRewardedVideoManager.onRewardedVideoClosed(AppLovinRewardedAdapter.class, "");
    }

    private void ALLog(String logMessage) {
        if (loggingEnabled) {
            Log.d("AppLovinAdapter", logMessage);
        }
    }
}