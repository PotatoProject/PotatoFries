package com.potatoproject.fries

import android.content.Context
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor.DartEntrypoint

class EngineCache {
    companion object {
        fun getEngine(context: Context?): FlutterEngine? {
            if (!FlutterEngineCache.getInstance().contains("mainEngine")) {
                val engine = FlutterEngine(context!!)
                engine.dartExecutor.executeDartEntrypoint(DartEntrypoint.createDefault())
                FlutterEngineCache.getInstance().put("mainEngine", engine)
            }
            return FlutterEngineCache.getInstance()["mainEngine"]
        }
    }
}