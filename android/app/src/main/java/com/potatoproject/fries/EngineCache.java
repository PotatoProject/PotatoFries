package com.potatoproject.fries;

import android.content.Context;

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.FlutterEngineCache;
import io.flutter.embedding.engine.dart.DartExecutor.DartEntrypoint;

public class EngineCache {
    public static FlutterEngine getEngine(Context context) {
        if(!FlutterEngineCache.getInstance().contains("mainEngine")) {
            FlutterEngine engine = new FlutterEngine(context);

            engine
                .getDartExecutor()
                .executeDartEntrypoint(
                    DartEntrypoint.createDefault()
                );
            
            FlutterEngineCache
                .getInstance()
                .put("mainEngine", engine);
        }

        return FlutterEngineCache.getInstance().get("mainEngine");
    }
}