package com.potatoproject.fries

import android.app.Activity
import android.content.Context
import android.database.ContentObserver
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.os.SystemProperties
import android.provider.Settings
import androidx.annotation.RequiresApi
import androidx.core.view.WindowCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    private var _activity: Activity? = null
    private val _streamHandler: SettingsStreamHandler = SettingsStreamHandler()

    override fun onCreate(savedInstanceState: Bundle?) {
      WindowCompat.setDecorFitsSystemWindows(window, false)
  
      super.onCreate(savedInstanceState)
    }

    override fun provideFlutterEngine(context: Context): FlutterEngine? {
        return EngineCache.getEngine(context)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        registerFlutterCallbacks(flutterEngine)
    }

    private fun registerFlutterCallbacks(flutterEngine: FlutterEngine) {
        if(_activity == null) _activity = this

        EventChannel(flutterEngine.dartExecutor, "fries/settings/sink")
            .setStreamHandler(_streamHandler)

        MethodChannel(flutterEngine.dartExecutor, "fries/settings/controls").setMethodCallHandler { call, result ->
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

        MethodChannel(flutterEngine.dartExecutor, "fries/properties/controls").setMethodCallHandler { call, result ->
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
                Handler(Looper.getMainLooper(),
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