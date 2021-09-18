import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:smart_apaga/Home/Home/HomeScreen.dart';
import 'package:smart_apaga/Pickup/Model/Wast.dart';
import 'package:smart_apaga/Pickup/View/WastTypeScreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QRScanScreen extends StatefulWidget {
  const QRScanScreen({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRScanScreenState();
}

class _QRScanScreenState extends State<QRScanScreen> {
  String result;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  TextEditingController _textFieldController =
      TextEditingController(text: 'bagCode');

  @override
  void initState() {
    //_textFieldController.addListener(_onTextFieldChange);
    super.initState();
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          title: Text(AppLocalizations.of(context).scanQrCodeText),
          backgroundColor: Colors.green[300],
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          )),
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(height: 20),
                TextFormField(
                  controller: _textFieldController,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.grey),
                    labelText: AppLocalizations.of(context).bagIdText,
                    hintStyle: TextStyle(color: Colors.grey[500], fontSize: 13),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green[700]),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                ),
                //
                SizedBox(height: 20),
                //
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ConstrainedBox(
                      constraints:
                          BoxConstraints(minWidth: screenSize.width * 0.3),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.green),
                          ),
                          primary: Colors.green,
                          textStyle: TextStyle(color: Colors.white),
                          padding: EdgeInsets.all(8.0),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          if (_textFieldController.text != null ||
                              _textFieldController.text != '') {
                            _pushWastTypeScreen(
                                _textFieldController.text, context);
                          }
                          // _pushWastTypeScreen(null, context);
                        },
                        child: Text(
                          AppLocalizations.of(context).confirmId,
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: screenSize.width * 0.10),
                    ConstrainedBox(
                      constraints:
                          BoxConstraints(minWidth: screenSize.width * 0.4),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.green)),
                          primary: Colors.green,
                          textStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          _pushWastTypeScreen(null, context);
                        },
                        child: Flex(
                          direction: Axis.horizontal,
                          children: [
                            Text(
                              AppLocalizations.of(context).dontHaveBagsText,
                              style: TextStyle(fontSize: 14),
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                //
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
              child: Container(
            margin: EdgeInsets.all(8),
            child: RaisedButton(
                onPressed: () => setState(() {
                      controller?.flipCamera();
                    }),
                child: FutureBuilder(
                  future: controller?.getCameraInfo(),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return Text(
                          '${AppLocalizations.of(context).cameraFacingText} ${describeEnum(snapshot.data)}');
                    } else {
                      return Text('loading');
                    }
                  },
                )),
          )),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      cameraFacing: CameraFacing.front,
      onQRViewCreated: _onQRViewCreated,
      formatsAllowed: [BarcodeFormat.qrcode],
      overlay: QrScannerOverlayShape(
        borderColor: Colors.green,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData.code;
        _pushWastTypeScreen(result, context);
      });
    });
  }

  List<Waste> wastes = [];
  void _pushWastTypeScreen(String barCode, BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WastTypeScreen(
            barcode: barCode,
            wastes: wastes,
          ),
        ));
    if (result != null || result != false) {
      wastes = result;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
