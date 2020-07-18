package com.potatoproject.fries;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

import co.potatoproject.effectsplugin.EffectsPluginService;

public class BootCompleteReceiver extends BroadcastReceiver {

    private static final String TAG = "FlutterAudioEffectsNative";

    @Override
    public void onReceive(Context context, Intent intent) {
        if (Intent.ACTION_BOOT_COMPLETED.equals(intent.getAction())) {
            Log.i(TAG, "AudioFX init triggered!");
            context.startService(new Intent(context, EffectsPluginService.class));
        }
    }
}
