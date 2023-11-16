import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kyty/Services/Personalized_TextFields.dart';

class PhoneLoginView extends StatefulWidget{
  @override
  State<PhoneLoginView> createState() => _PhoneLoginViewState();
}

class _PhoneLoginViewState extends State<PhoneLoginView> {

  TextEditingController tecPhone = TextEditingController();
  TextEditingController tecVerify = TextEditingController();
  String sVerificationCode = "";
  bool blShowVerification = false;
  int _currentStep = 0;

  void sendPhonePressed() async{
    String sTelefono = tecPhone.text;

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: sTelefono,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: waitingTimeFinishing);
        print(blShowVerification);
  }

  void sendVerifyPressed() async{
    String smsCode = tecVerify.text;

    // Create a PhoneAuthCredential with the code
    PhoneAuthCredential credential =
    PhoneAuthProvider.credential(verificationId: sVerificationCode, smsCode: smsCode);

    // Sign the user in (or link) with the credential
    await FirebaseAuth.instance.signInWithCredential(credential);

    Navigator.pushReplacementNamed(context, '/homeview');
  }

  void verificationCompleted(PhoneAuthCredential credencial) async{
    await FirebaseAuth.instance.signInWithCredential(credencial);

    Navigator.of(context).popAndPushNamed("/homeview");
  }

  void verificationFailed(FirebaseAuthException excepcion){
    if (excepcion.code == 'invalid-phone-number') {
      print('The provided phone number is not valid.');
    }
  }

  void codeSent(String codigo, int? resendToken) async{
    sVerificationCode=codigo;
    setState(() {
      blShowVerification=true;
    });
  }

  void waitingTimeFinishing(String verID){

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child: Scaffold(
          body: Stepper(
            currentStep: _currentStep,
            onStepContinue: (){
              // Enviar codigo al número
              if (_currentStep == 0){
                sendPhonePressed();
                setState(() {
                  if (blShowVerification) {
                    _currentStep++;
                  }
                });
              }
              if (_currentStep == 1){
                // verificar codigo y pasar a home
                sendVerifyPressed();
              }
            },
            onStepCancel: (){
              if (_currentStep == 0){
                Navigator.pushReplacementNamed(context, '/loginview');
              }
              if (_currentStep <= 0) return;
              setState(() {
                _currentStep--;
              });
            },
            steps: [
              Step(
                title: const Text("Número de teléfono"),
                content: Personalized_TextFields(
                  controller: tecPhone,
                  hintText: 'Introduce tu número de teléfono',
                  obscuredText: false,
                  boolMaxLines: false,
                ),
              ),
              Step(
                  title: const Text("Introduce el código de verificación"),
                  content: Personalized_TextFields(
                    controller: tecVerify,
                    hintText: 'Código de verificación',
                    obscuredText: false,
                    boolMaxLines: false,
                  ),
              ),
            ],
          ),
        ),

    );
  }
}