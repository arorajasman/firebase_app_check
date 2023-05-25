import 'dart:convert';

import 'package:firebase_project/app_details_model.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class FirebaseRemoteConfigBloc {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  Future<AppDetailsModel> init() async {
    AppDetailsModel appDetailsModel = const AppDetailsModel();
    try {
      await _remoteConfig.ensureInitialized();
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 15),
          minimumFetchInterval: const Duration(seconds: 2),
        ),
      );
      await _remoteConfig.fetchAndActivate();
      RemoteConfigValue appData = _remoteConfig.getAll()['app_update']!;
      Map<String, dynamic> decodedData = jsonDecode(appData.asString());
      appDetailsModel = AppDetailsModel.fromJSON(decodedData);
      print("decode: ${appDetailsModel.toJSON()}");
      return appDetailsModel;
    } catch (err) {
      print("err: $err");
      return appDetailsModel;
    }
  }
}

FirebaseRemoteConfigBloc firebaseRemoteConfigBloc = FirebaseRemoteConfigBloc();
