package com.potatoproject.fries;

import android.app.Activity;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.content.res.Resources;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    private Activity mActivity;

    @Nullable
    @Override
    public FlutterEngine provideFlutterEngine(@NonNull Context context) {
        return EngineCache.getEngine(context);
    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        registerFlutterCallbacks(flutterEngine);
    }

    public void registerFlutterCallbacks(@NonNull FlutterEngine flutterEngine) {
        if (mActivity == null) mActivity = this;
        new MethodChannel(flutterEngine.getDartExecutor(), "fries/resources").setMethodCallHandler(
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
        new MethodChannel(flutterEngine.getDartExecutor(), "fries/utils").setMethodCallHandler(
                (call, result) -> {
                    if (call.method.equals("startActivity")) {
                        final String pkg = call.argument("pkg");
                        final String cls = call.argument("cls");
                        if (pkg != null && cls != null) {
                            mActivity.startActivity(new Intent().setComponent(new ComponentName(
                                    pkg, cls)));
                        }
                        result.success(null);
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
