package com.potatoproject.fries;

import android.content.pm.PackageManager;
import android.content.res.Resources;
import android.os.Bundle;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);
        new MethodChannel(getFlutterView(), "fries/resources").setMethodCallHandler(
                (call, result) -> {
                    if (call.method.equals("getColor")) {
                        String pkg = call.argument("pkg");
                        String resName = call.argument("resName");
                        resultSuccess(result, getColor(pkg, resName));
                    } else {
                        result.notImplemented();
                    }
                }
        );
    }

    int getColor(String pkg, String resName) {
        Resources res = null;
        try {
            res = this.getPackageManager().getResourcesForApplication("com.android.systemui");
            int resId = res.getIdentifier(pkg + ":color/" + resName, null, null);
            return res.getColor(resId);
        } catch (PackageManager.NameNotFoundException e) {
            e.printStackTrace();
        } catch (NullPointerException e) {
            e.printStackTrace();
        }
        return 0;
    }

    private void resultSuccess(final MethodChannel.Result result, final Object object) {
        this.runOnUiThread(() -> result.success(object));
    }

}
