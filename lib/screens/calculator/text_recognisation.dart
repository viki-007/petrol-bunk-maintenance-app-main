import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class RecognizePage extends StatefulWidget {
  final String? path;
  const RecognizePage({Key? key, this.path}) : super(key: key);

  @override
  State<RecognizePage> createState() => _RecognizePageState();
}

class _RecognizePageState extends State<RecognizePage> {
  bool _isBusy = false;

  var scanval = {} ;
  
  @override
  void initState() {
    super.initState();

    final InputImage inputImage = InputImage.fromFilePath(widget.path!);

    processImage(inputImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("recognized page")),
        body: _isBusy == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text("Nozzle : ${scanval.keys.first}"),
                    Text("tot : ${scanval[scanval.keys.first]}"),
                    Text("is it coorect ? if wrong re-scan"),
                    ElevatedButton(onPressed: () {
                      Get.offAllNamed('calci',arguments: scanval);
                    }, child: Text("Yes, its correct"))
                  ],
                )
              ));
  }

  void processImage(InputImage image) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

    setState(() {
      _isBusy = true;
    });

    log(image.filePath!);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(image);


    RegExp regExp = RegExp("No(z{0,2}2? ?le) No\.[ ]{0,1}:[ ]{0,1}[0-9]+", caseSensitive: false , multiLine: true );
    RegExp regExp2 = RegExp("Vtot:[ ]{0,1}[0-9]*\.[ ]{0,1}[0-9]+", caseSensitive: false , multiLine: true );
    
    var a = regExp.allMatches(recognizedText.text).first[0]!.split(":")[1] ;
    var b = regExp2.allMatches(recognizedText.text).first[0]!.split(":")[1] ;
    scanval[a] = b ;

    setState(() {
      _isBusy = false;
    });
  }
}
