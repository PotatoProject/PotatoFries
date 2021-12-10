package com.potatoproject.fries

import android.annotation.SuppressLint
import android.app.Activity
import android.app.WallpaperManager
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.content.res.Configuration
import android.content.res.Resources
import android.database.ContentObserver
import android.graphics.Bitmap
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.Drawable
import android.net.Uri
import android.os.*
import android.provider.Settings
import androidx.core.view.WindowCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking
import java.io.ByteArrayOutputStream

class MainActivity : FlutterActivity() {
    private var _activity: Activity? = null
    private val _streamHandler: SettingsStreamHandler = SettingsStreamHandler()
    private var _darkTheme: Boolean? = null
    private var _activityReady: Boolean? = null
    private var _themeRelatedChangeRequested: Boolean = false

    private lateinit var _settingSinkChannel: EventChannel
    private lateinit var _settingControlChannel: MethodChannel
    private lateinit var _propertyControlChannel: MethodChannel
    private lateinit var _utilsChannel: MethodChannel

    override fun onCreate(savedInstanceState: Bundle?) {
        WindowCompat.setDecorFitsSystemWindows(window, false)
        context.registerReceiver(wallpaperChangedReceiver, IntentFilter(Intent.ACTION_WALLPAPER_CHANGED))

        if(savedInstanceState != null) {
            _activityReady = savedInstanceState.getBoolean("acceptThemeChanges")
        }

        super.onCreate(savedInstanceState)
    }

    override fun provideFlutterEngine(context: Context): FlutterEngine? {
        return EngineCache.getEngine(context)
    }

    override fun onSaveInstanceState(outState: Bundle) {
        super.onSaveInstanceState(outState)
        outState.putBoolean("acceptThemeChanges", _activityReady ?: false)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        _settingSinkChannel = EventChannel(flutterEngine.dartExecutor, "fries/settings/sink")
        _settingControlChannel = MethodChannel(flutterEngine.dartExecutor, "fries/settings/controls")
        _propertyControlChannel = MethodChannel(flutterEngine.dartExecutor, "fries/properties/controls")
        _utilsChannel = MethodChannel(flutterEngine.dartExecutor, "fries/utils")

        if(_themeRelatedChangeRequested && _activityReady == true) notifyMonetChange("config")
        _themeRelatedChangeRequested = false

        if(_activityReady == null) _activityReady = true

        registerFlutterCallbacks()
    }

    @SuppressLint("MissingPermission")
    private fun registerFlutterCallbacks() {
        if(_activity == null) _activity = this

        _settingSinkChannel.setStreamHandler(_streamHandler)

        _settingControlChannel.setMethodCallHandler { call, result ->
            when(call.method) {
                "subscribe" -> {
                    assert(call.hasArgument("uri"))
                    assert(call.hasArgument("defaultValue"))

                    _streamHandler.subscribe(
                        Uri.parse(call.argument("uri")!!),
                        call.argument("defaultValue")!!,
                    )

                    result.success(true)
                }
                "write" -> {
                    assert(call.hasArgument("uri"))
                    assert(call.hasArgument("value"))

                    val uri: Uri = Uri.parse(call.argument("uri")!!)
                    val value: String = call.argument("value")!!
                    val actualValue: String? = if(value != "null") value else null

                    val table: String = uri.pathSegments.first()
                    val name: String = uri.pathSegments.last()

                    when(table) {
                        "global" -> Settings.Global.putString(contentResolver, name, actualValue)
                        "system" -> Settings.System.putString(contentResolver, name, actualValue)
                        "secure" -> Settings.Secure.putString(contentResolver, name, actualValue)
                        else -> throw Exception("Value not supported for table")
                    }
                    
                    result.success(true)
                }
                else -> result.notImplemented()
            }
        }

        _propertyControlChannel.setMethodCallHandler { call, result ->
            when(call.method) {
                "read" -> {
                    assert(call.hasArgument("name"))

                    val name: String = call.argument("name")!!
                    val value: String = SystemProperties.get(name)

                    result.success(value)
                }
                "write" -> {
                    assert(call.hasArgument("name"))
                    assert(call.hasArgument("value"))

                    val name: String = call.argument("name")!!
                    val value: String = call.argument("value")!!

                    SystemProperties.set(name, value)
                    
                    result.success(true)
                }
                else -> result.notImplemented()
            }
        }

        _utilsChannel.setMethodCallHandler { call, result ->
            when(call.method) {
                "getWallpaper" -> {
                    val drawable: Drawable = WallpaperManager.getInstance(this).drawable
                    val bitmap = (drawable as BitmapDrawable).bitmap
                    val outputStream = ByteArrayOutputStream()


                    runBlocking {
                        launch {
                            bitmap.compress(Bitmap.CompressFormat.WEBP_LOSSY, 40, outputStream)

                            result.success(outputStream.toByteArray())
                        }
                    }
                }
                "getMonetColors" -> {
                    result.success(getCorePalette(resources))
                }
                else -> result.notImplemented()
            }
        }
    }

    override fun onDestroy() {
        context.unregisterReceiver(wallpaperChangedReceiver)
        super.onDestroy()
    }

    override fun onConfigurationChanged(newConfig: Configuration) {
        theme = context.theme
        if(_darkTheme != context.isDarkMode){
            notifyMonetChange("config")
        }
        _darkTheme = context.isDarkMode
        super.onConfigurationChanged(newConfig)
    }

    override fun onApplyThemeResource(theme: Resources.Theme?, resid: Int, first: Boolean) {
        super.onApplyThemeResource(theme, resid, first)
        _themeRelatedChangeRequested = true
    }

    private val wallpaperChangedReceiver = object: BroadcastReceiver() {
        override fun onReceive(context: Context?, intent: Intent?) {
            notifyMonetChange("wallpaper")
        }
    }

    private fun notifyMonetChange(reason: String) {
        _utilsChannel.invokeMethod("onColorsChanged", reason)
    }

    private fun getCorePalette(resources: Resources): IntArray {
        return intArrayOf(
            // Primary tonal palette.
            resources.getColor(R.color.system_accent1_0, null),
            resources.getColor(R.color.system_accent1_10, null),
            resources.getColor(R.color.system_accent1_50, null),
            resources.getColor(R.color.system_accent1_100, null),
            resources.getColor(R.color.system_accent1_200, null),
            resources.getColor(R.color.system_accent1_300, null),
            resources.getColor(R.color.system_accent1_400, null),
            resources.getColor(R.color.system_accent1_500, null),
            resources.getColor(R.color.system_accent1_600, null),
            resources.getColor(R.color.system_accent1_700, null),
            resources.getColor(R.color.system_accent1_800, null),
            resources.getColor(R.color.system_accent1_900, null),
            resources.getColor(R.color.system_accent1_1000, null),
            // Secondary tonal palette.
            resources.getColor(R.color.system_accent2_0, null),
            resources.getColor(R.color.system_accent2_10, null),
            resources.getColor(R.color.system_accent2_50, null),
            resources.getColor(R.color.system_accent2_100, null),
            resources.getColor(R.color.system_accent2_200, null),
            resources.getColor(R.color.system_accent2_300, null),
            resources.getColor(R.color.system_accent2_400, null),
            resources.getColor(R.color.system_accent2_500, null),
            resources.getColor(R.color.system_accent2_600, null),
            resources.getColor(R.color.system_accent2_700, null),
            resources.getColor(R.color.system_accent2_800, null),
            resources.getColor(R.color.system_accent2_900, null),
            resources.getColor(R.color.system_accent2_1000, null),
            // Tertiary tonal palette.
            resources.getColor(R.color.system_accent3_0, null),
            resources.getColor(R.color.system_accent3_10, null),
            resources.getColor(R.color.system_accent3_50, null),
            resources.getColor(R.color.system_accent3_100, null),
            resources.getColor(R.color.system_accent3_200, null),
            resources.getColor(R.color.system_accent3_300, null),
            resources.getColor(R.color.system_accent3_400, null),
            resources.getColor(R.color.system_accent3_500, null),
            resources.getColor(R.color.system_accent3_600, null),
            resources.getColor(R.color.system_accent3_700, null),
            resources.getColor(R.color.system_accent3_800, null),
            resources.getColor(R.color.system_accent3_900, null),
            resources.getColor(R.color.system_accent3_1000, null),
            // Neutral tonal palette.
            resources.getColor(R.color.system_neutral1_0, null),
            resources.getColor(R.color.system_neutral1_10, null),
            resources.getColor(R.color.system_neutral1_50, null),
            resources.getColor(R.color.system_neutral1_100, null),
            resources.getColor(R.color.system_neutral1_200, null),
            resources.getColor(R.color.system_neutral1_300, null),
            resources.getColor(R.color.system_neutral1_400, null),
            resources.getColor(R.color.system_neutral1_500, null),
            resources.getColor(R.color.system_neutral1_600, null),
            resources.getColor(R.color.system_neutral1_700, null),
            resources.getColor(R.color.system_neutral1_800, null),
            resources.getColor(R.color.system_neutral1_900, null),
            resources.getColor(R.color.system_neutral1_1000, null),
            // Neutral variant tonal palette.
            resources.getColor(R.color.system_neutral2_0, null),
            resources.getColor(R.color.system_neutral2_10, null),
            resources.getColor(R.color.system_neutral2_50, null),
            resources.getColor(R.color.system_neutral2_100, null),
            resources.getColor(R.color.system_neutral2_200, null),
            resources.getColor(R.color.system_neutral2_300, null),
            resources.getColor(R.color.system_neutral2_400, null),
            resources.getColor(R.color.system_neutral2_500, null),
            resources.getColor(R.color.system_neutral2_600, null),
            resources.getColor(R.color.system_neutral2_700, null),
            resources.getColor(R.color.system_neutral2_800, null),
            resources.getColor(R.color.system_neutral2_900, null),
            resources.getColor(R.color.system_neutral2_1000, null),
        );
    }

    private inner class SettingsStreamHandler : EventChannel.StreamHandler {
        private var eventSink: EventChannel.EventSink? = null
        private val observers: MutableList<SettingObserver> = mutableListOf()

        override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
            eventSink = events
        }

        override fun onCancel(arguments: Any?) {
            eventSink = null
            observers.forEach { it.dispose() }
            observers.clear()
        }

        fun notify(uri: Uri, value: String) {
            if(eventSink == null) return

            eventSink!!.success("$uri\u2022$value")
        }

        fun subscribe(uri: Uri, defaultValue: String) {
            val observer = SettingObserver(
                uri,
                defaultValue,
                this,
                Handler(
                    Looper.getMainLooper(),
                ),
            )
            observers.add(observer)
        }
    }

    private inner class SettingObserver(
        val uri: Uri,
        val defaultValue: String,
        val streamHandler: SettingsStreamHandler,
        handler: Handler?,
    ) : ContentObserver(handler) {
        init {
            contentResolver.registerContentObserver(
                uri,
                false, this
            )
            onChange(true, uri)
        }

        fun dispose() {
            contentResolver.unregisterContentObserver(this)
        }

        override fun onChange(selfChange: Boolean, uri: Uri?) {
            val value: String? = when(this.uri.pathSegments.first()) {
                "global" -> Settings.Global.getString(
                    _activity!!.contentResolver,
                    this.uri.pathSegments.last(),
                )
                "system" -> Settings.System.getString(
                    _activity!!.contentResolver,
                    this.uri.pathSegments.last(),
                )
                "secure" -> Settings.Secure.getString(
                    _activity!!.contentResolver,
                    this.uri.pathSegments.last(),
                )
                else -> throw Exception("Invalid type for setting")
            }

            streamHandler.notify(this.uri, value ?: defaultValue)
        }
    }
}

internal val Context.isDarkMode: Boolean
    get() {
        return when (resources.configuration.uiMode and Configuration.UI_MODE_NIGHT_MASK) {
            Configuration.UI_MODE_NIGHT_YES -> true
            Configuration.UI_MODE_NIGHT_NO -> false
            Configuration.UI_MODE_NIGHT_UNDEFINED -> false
            else -> false
        }
    }