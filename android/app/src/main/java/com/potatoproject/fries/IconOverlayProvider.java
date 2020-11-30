package com.potatoproject.fries;

import android.content.Context;
import android.content.pm.PackageManager;
import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.BlendMode;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.PorterDuff;
import android.graphics.drawable.BitmapDrawable;
import android.graphics.drawable.Drawable;
import android.os.Process;
import android.util.Log;

import java.io.ByteArrayOutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class IconOverlayProvider {
    String OVERLAY_CATEGORY_ICON_ANDROID = "android.theme.customization.icon_pack.android";

    private HashMap<String, HashMap<String, byte[]>> mIconsWithPreviews = new HashMap<String, HashMap<String, byte[]>>();
    private HashMap<String, String> mIconsWithLabels = new HashMap<String, String>();

    private Context mContext;
    private OverlayManagerCompat mOverlayManager;
    private List<String> mOverlayPackages;

    public IconOverlayProvider(Context context) {
        mContext = context;
        mOverlayManager = new OverlayManagerCompat(context);
        String[] targetPackages = mOverlayManager.getPackagesToOverlay(context);
        mOverlayPackages = new ArrayList<>();
        mOverlayPackages.addAll(mOverlayManager.getOverlayPackagesForCategory(OVERLAY_CATEGORY_ICON_ANDROID,
                Process.myUid(), targetPackages));

        loadOptions();
    }

    public HashMap<String, HashMap<String, byte[]>> getIconsWithPreview() {
        return mIconsWithPreviews;
    }

    public HashMap<String, String> getIconsWithLabels() {
        return mIconsWithLabels;
    }

    private void loadOptions() {
        addDefault();

        for (String overlayPackage : mOverlayPackages) {
            try {
                PackageManager pm = mContext.getPackageManager();
                String label = pm.getApplicationInfo(overlayPackage, 0).loadLabel(pm).toString();
                mIconsWithLabels.put(overlayPackage, label);
                mIconsWithPreviews.put(overlayPackage, getPreviews(overlayPackage));
            } catch (Resources.NotFoundException | PackageManager.NameNotFoundException e) {
                Log.w("IconOverlayProvider", String.format("Couldn't load icon overlay details for %s, will skip it",
                        overlayPackage), e);
            }
        }
    }

    private byte[] loadIconPreviewDrawable(String drawableName, String packageName)
            throws PackageManager.NameNotFoundException, Resources.NotFoundException {
        final Resources resources = "android".equals(packageName)
                ? Resources.getSystem()
                : mContext.getPackageManager().getResourcesForApplication(packageName);

        Drawable drawable = resources.getDrawable(
                resources.getIdentifier(drawableName, "drawable", packageName), null);
        Bitmap bitmap = Bitmap.createBitmap(drawable.getIntrinsicWidth(),
                drawable.getIntrinsicHeight(), Bitmap.Config.ARGB_8888);
        bitmap.eraseColor(Color.TRANSPARENT);
        Canvas canvas = new Canvas(bitmap);
        canvas.drawColor(Color.BLACK, PorterDuff.Mode.CLEAR);
        drawable.setBounds(0, 0, canvas.getWidth(), canvas.getHeight());
        drawable.draw(canvas);
        ByteArrayOutputStream stream = new ByteArrayOutputStream();
        bitmap.compress(Bitmap.CompressFormat.PNG, 100, stream);
        return stream.toByteArray();
    }

    private void addDefault() {
        mIconsWithLabels.put(null, "Default");
        mIconsWithPreviews.put(null, getPreviews("android"));
    }

    private HashMap<String, byte[]> getPreviews(String packageName) {
        String android;
        String sysUI;
        String settings;

        if("android".equals(packageName)) {
            android = "android";
            sysUI = "com.android.systemui";
            settings = "com.android.settings";
        } else {
            final String prefix = packageName.substring(0, packageName.lastIndexOf("."));
            android = prefix + ".android";
            sysUI = prefix + ".systemui";
            settings = prefix + ".settings";
        }

        HashMap<String, String> ICONS = new HashMap<String, String>(){{
            put("ic_wifi_signal_3", android);
            put("ic_wifi_signal_4", android);
            put("ic_qs_bluetooth", android);
            put("ic_swap_vert", sysUI);
            put("ic_qs_dnd", android);
            put("ic_qs_flashlight", android);
            put("ic_qs_auto_rotate", android);
            put("ic_settings_multiuser", settings);
            put("ic_search_24dp", settings);
            put("ic_settings_wireless", settings);
            put("ic_apps", settings);
            put("ic_devices_other", settings);
        }};
        HashMap<String, byte[]> iconData = new HashMap<String, byte[]>();

        for (int i = 0; i < ICONS.size(); i++) {
            Object[] keys = ICONS.keySet().toArray();
            try {
                final String key = (String) keys[i];
                iconData.put(key, loadIconPreviewDrawable(key, ICONS.get(key)));
            } catch (PackageManager.NameNotFoundException | Resources.NotFoundException e) {
                Log.w("IconOverlayProvider", "Didn't find icon, will skip option", e);
            }
        }

        return iconData;
    }
}
