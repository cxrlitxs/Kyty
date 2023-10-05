import 'package:flutter/material.dart';
import 'Kyty.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Kyty kytyApp = Kyty();
  runApp(kytyApp);
}