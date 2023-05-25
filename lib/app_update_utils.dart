import 'dart:io';

import 'package:firebase_project/app_details_model.dart';
import 'package:firebase_project/ios_immediate_update_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUpdateUtils {
  void redirectUserToAppStore() async {
    final Uri url = Uri.parse(
      'https://apps.apple.com/us/app/devicethread-beta/id1640216639',
    );
    try {
      if (!await launchUrl(url)) {
        print("Success");
      }
    } catch (e) {
      print(e);
    }
  }

  // method to convert app version to integer
  int getExtendedVersionNumber(String version) {
    if (version.isNotEmpty) {
      List versionCells = version.split('.');
      versionCells = versionCells.map((i) => int.parse(i)).toList();
      return versionCells[0] * 100000 +
          versionCells[1] * 1000 +
          versionCells[2];
    } else {
      return 0;
    }
  }

  String performAndroidImmediateUpdate() {
    String message = "";
    InAppUpdate.performImmediateUpdate().then((appUpdateResult) {
      if (appUpdateResult == AppUpdateResult.success) {
        message = "Inside immediate uppdate\napp update successful";
      } else if (appUpdateResult == AppUpdateResult.userDeniedUpdate) {
        /// kill application
        SystemNavigator.pop();
      }
    });
    return message;
  }

  String performAndroidFlexibleUpdate() {
    String message = "";
    InAppUpdate.startFlexibleUpdate().then((appUpdateResult) {
      if (appUpdateResult == AppUpdateResult.success) {
        //App Update successful
        InAppUpdate.completeFlexibleUpdate();
        message = "app flexible update successful";
      }
    });
    return message;
  }

  String androidAppUpdate(
    AppDetailsModel appDetailsModel,
    int lastImmediateAndroidAppVersion,
    int currentAppVersion,
  ) {
    String forceUpdateMessage = "";
    forceUpdateMessage = "Inside isAndroid";
    InAppUpdate.checkForUpdate().then((value) {
      forceUpdateMessage = "Inside Check for update method";
      if (value.updateAvailability == UpdateAvailability.updateAvailable) {
        forceUpdateMessage = "Inside Update Available";
        if (appDetailsModel.priority == 0) {
          /// Perform immediate update
          forceUpdateMessage = performAndroidImmediateUpdate();
        } else if (appDetailsModel.priority == 1) {
          if (currentAppVersion <
              lastImmediateAndroidAppVersion /* ||  7 days check */) {
            /* priority == 1 && appVersion < lastImmediateVersion  do immediate update  else  do flexible update */
            forceUpdateMessage = performAndroidImmediateUpdate();
          } else {
            forceUpdateMessage = performAndroidFlexibleUpdate();
          }
        } else {
          forceUpdateMessage = performAndroidFlexibleUpdate();
        }
      } else {
        forceUpdateMessage = "Update not available";
      }
    }).catchError((error) {
      forceUpdateMessage = "error: ${error.toString()}";
    });
    return forceUpdateMessage;
  }

  String iOSAppUpdate(
    AppDetailsModel appDetailsModel,
    int appVersion,
    BuildContext context,
  ) {
    String message = "";
    final int iOSVersionFromRemoteConfig =
        getExtendedVersionNumber(appDetailsModel.currentIOSVersion);
    final int iOSLastImmediateUpdateVersion =
        getExtendedVersionNumber(appDetailsModel.iOSLastMinimumUpdateVersion);
    if (appVersion < iOSVersionFromRemoteConfig) {
      if (appDetailsModel.priority == 0) {
        /// show popup for immediate update
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return IOSImmediateUpdateBottomSheet(
              currentVersion: appVersion.toString(),
              updateVersion: appDetailsModel.iOSLastMinimumUpdateVersion,
              onPressed: redirectUserToAppStore,
              closeBtnPressed: () {
                exit(0);
              },
            );
          },
        );
      } else {
        if (appVersion < iOSLastImmediateUpdateVersion) {
          /// perform immediate update
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return IOSImmediateUpdateBottomSheet(
                currentVersion: appVersion.toString(),
                updateVersion: appDetailsModel.iOSLastMinimumUpdateVersion,
                onPressed: redirectUserToAppStore,
                closeBtnPressed: () {
                  exit(0);
                },
              );
            },
          );
        } else {
          /// perform flexible update
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return IOSImmediateUpdateBottomSheet(
                currentVersion: appVersion.toString(),
                updateVersion: appDetailsModel.iOSLastMinimumUpdateVersion,
                onPressed: redirectUserToAppStore,
                closeBtnPressed: () {
                  Navigator.pop(context);
                },
              );
            },
          );
        }
      }
    }

    return message;
  }
}
