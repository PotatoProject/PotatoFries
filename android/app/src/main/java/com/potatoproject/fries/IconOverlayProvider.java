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

    private HashMap<String, byte[]> mIconsWithPreview = new HashMap<String, byte[]>();
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

    public HashMap<String, byte[]> getIconsWithPreview() {
        return mIconsWithPreview;
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
                mIconsWithPreview.put(overlayPackage, loadIconPreviewDrawable("ic_wifi_signal_3", overlayPackage));
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
        bitmap.compress(Bitmap.CompressFormat.JPEG, 100, stream);
        return stream.toByteArray();
    }

    private void addDefault() {
        mIconsWithLabels.put(null, "Default");
        try {
            mIconsWithPreview.put(null, loadIconPreviewDrawable("ic_wifi_signal_3", "android"));
        } catch (PackageManager.NameNotFoundException | Resources.NotFoundException e) {
            Log.w("IconOverlayProvider", "Didn't find SystemUi package icons, will skip option", e);
        }
    }
}
