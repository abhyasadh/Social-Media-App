import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/app.dart';
import 'core/storage/hive_service.dart';

void main() async {
  runZonedGuarded(() async {
    FlutterNativeSplash.preserve(widgetsBinding: WidgetsFlutterBinding.ensureInitialized());

    await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp],
    );

    try {
      await HiveService().init();
      Map<String, dynamic>? data = await HiveService().getData();

      runApp(
        ProviderScope(
          child: App(
            data: data,
          ),
        ),
      );

      FlutterNativeSplash.remove();
    } catch (e) {
      debugPrint('Error during initialization: $e');
    }
  }, (error, stackTrace) {
    debugPrint('Unhandled error: $error');
  });
}
