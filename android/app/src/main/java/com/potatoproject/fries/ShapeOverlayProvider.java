package com.potatoproject.fries;

import android.content.Context;
import android.content.om.OverlayInfo;
import android.content.om.OverlayManager;
import android.content.pm.PackageManager;
import android.content.res.Resources;
import android.graphics.Path;
import android.os.Process;
import android.os.UserHandle;
import android.util.Log;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class ShapeOverlayProvider {
    private HashMap<String, String> mOverlayInfo = new HashMap<String, String>();
    private HashMap<String, String> mOverlayLabels = new HashMap<String, String>();
    private final String[] mTargetPackages;
    private List<String> mOverlayPackages;
    private OverlayManagerCompat mOverlayManager;
    private Context mContext;

    public ShapeOverlayProvider(Context context) {
        mContext = context;
        mOverlayManager = new OverlayManagerCompat(context);
        mTargetPackages = mOverlayManager.getPackagesToOverlay(context);
        mOverlayPackages = new ArrayList<>();
        mOverlayPackages.addAll(mOverlayManager.getOverlayPackagesForCategory("android.theme.customization.adaptive_icon_shape",
                Process.myUid(), mTargetPackages));
        loadOptions();
    }

    public HashMap<String, String> getInfo() {
        return mOverlayInfo;
    }

    public HashMap<String, String> getLabels() {
        return mOverlayLabels;
    }

    private void loadOptions() {
        addDefault();
        for (String overlayPackage : mOverlayPackages) {
            try {
                String path = loadPath(mContext.getPackageManager()
                        .getResourcesForApplication(overlayPackage), overlayPackage);
                PackageManager pm = mContext.getPackageManager();
                String label = pm.getApplicationInfo(overlayPackage, 0).loadLabel(pm).toString();
                mOverlayInfo.put(overlayPackage, path);
                mOverlayLabels.put(overlayPackage, label);
            } catch (PackageManager.NameNotFoundException | Resources.NotFoundException e) {
                Log.w("ShapeOverlayParser", String.format("Couldn't load shape overlay %s, will skip it",
                        overlayPackage), e);
            }
        }
    }

    private void addDefault() {
        Resources system = Resources.getSystem();
        String path = loadPath(system, "android");
        mOverlayInfo.put(null, path);
        mOverlayLabels.put(null, "Default");
    }

    private String loadPath(Resources overlayRes, String packageName) {
        String shape = overlayRes.getString(overlayRes.getIdentifier("config_icon_mask", "string",
                packageName));

        return shape;
    }
}