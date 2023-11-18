import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PlatformAdmin{

  BuildContext context;

  PlatformAdmin({required this.context});

  double getScreenWidth(){
    double width = MediaQuery.of(context).size.width;
    return width;
  }

  double getScreenHeight(){
    double height = MediaQuery.of(context).size.height;
    return height;
  }

  String getImagePath() {
    // Construir la ruta de la imagen basada en la plataforma actual
    late String platform;

    if(kIsWeb) {
      platform = "web";
    }else if(Platform.isIOS){
      platform = "ios";
    }else if(Platform.isAndroid){
      platform = "android";
    }

    return 'resources/$platform';
  }

}