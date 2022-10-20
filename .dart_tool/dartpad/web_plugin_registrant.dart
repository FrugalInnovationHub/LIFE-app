// Flutter web plugin registrant file.
//
// Generated file. Do not edit.
//

// @dart = 2.13
// ignore_for_file: type=lint

import 'package:device_info_plus_web/device_info_plus_web.dart';
import 'package:flutter_native_splash/flutter_native_splash_web.dart';
import 'package:pdfx/src/renderer/web/pdfx_plugin.dart';
import 'package:video_player_web/video_player_web.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void registerPlugins([final Registrar? pluginRegistrar]) {
  final Registrar registrar = pluginRegistrar ?? webPluginRegistrar;
  DeviceInfoPlusPlugin.registerWith(registrar);
  FlutterNativeSplashWeb.registerWith(registrar);
  PdfxPlugin.registerWith(registrar);
  VideoPlayerPlugin.registerWith(registrar);
  registrar.registerMessageHandler();
}
