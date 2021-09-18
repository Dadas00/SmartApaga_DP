import 'dart:async';
import 'package:smart_apaga/LoginRegister/Bloc/AddressBloc/AddressState.dart';
import 'package:smart_apaga/LoginRegister/model/Address.dart' as address;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_apaga/LoginRegister/Bloc/AddressBloc/AddressBloc.dart';
import 'package:smart_apaga/LoginRegister/Bloc/AddressBloc/AddressEvent.dart';
import 'package:smart_apaga/Pickup/Model/Pickup.dart';
import 'package:smart_apaga/Pickup/PickupBloc/PickupBloc.dart';
import 'package:smart_apaga/Pickup/PickupBloc/pickupEvent.dart';
import 'package:smart_apaga/Pickup/View/SchedulScreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddressConfirmationForm extends StatefulWidget {
  @override
  _AddressConfirmationState createState() => _AddressConfirmationState();
}

class _AddressConfirmationState extends State<AddressConfirmationForm> {
  Completer<GoogleMapController> _controller = Completer();

  String value;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(40.1872, 44.5152),
    zoom: 12,
  );
  bool disclimer = true;

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  double mapHeight = 0;

  bool _pending = false;
  AddressBloc _addressesBloc;
  PickupBloc _pickupBloc;

  TextEditingController _streetNameController =
      TextEditingController(text: 'baxramyan');
  TextEditingController _bdgController = TextEditingController(text: '12');
  TextEditingController _aptController = TextEditingController(text: '12');
  TextEditingController _floorController = TextEditingController(text: '12');
  TextEditingController _entrController = TextEditingController(text: '12');
  TextEditingController _commentController = TextEditingController(text: '12');
  TextEditingController _longitudeController =
      TextEditingController(text: '45.022131');
  TextEditingController _latitudeController =
      TextEditingController(text: '40.0321356');

  bool get isPopulated =>
      _bdgController.text.isNotEmpty &&
      _aptController.text.isNotEmpty &&
      _floorController.text.isNotEmpty &&
      _entrController.text.isNotEmpty &&
      _commentController.text.isNotEmpty;

  bool isButtonEnabled(AddressState state) {
    return state.isAddressValid && isPopulated;
  }

  @override
  void initState() {
    super.initState();
    _addressesBloc = BlocProvider.of<AddressBloc>(context);

    _streetNameController.addListener(_onStreetNameChanged);
    _bdgController.addListener(_onBdgChanged);
    _aptController.addListener(_onAptChanged);
    _floorController.addListener(_onFloorChanged);
    _entrController.addListener(_onEntryChanged);
    _commentController.addListener(_onCommentChanged);
    _latitudeController.addListener(_onLanditudeChanged);
    _longitudeController.addListener(_onLongitudeChanged);
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    _addressesBloc = BlocProvider.of<AddressBloc>(context);
    return BlocListener<AddressBloc, AddressState>(
      bloc: _addressesBloc = BlocProvider.of<AddressBloc>(context),
      listener: (context, state) {
        if (state.isFailure) {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Address Failure'),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Color(0xffffae88),
              ),
            );
        }

        if (state.isSumbiting) {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Addressing...'),
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  ],
                ),
                backgroundColor: Color(0xffffae88),
              ),
            );
        }

        if (state.isSuccess) {
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<AddressBloc, AddressState>(
        bloc: BlocProvider.of<AddressBloc>(context),
        builder: (context, state) {
          mapHeight = screenSize.height * 0.3;
          // var apiKey;
          return SingleChildScrollView(
            // resizeToAvoidBottomInset: false,
            child: Column(children: <Widget>[
              AppBar(
                  title: Text(
                      AppLocalizations.of(context).addressConfirmationText),
                  backgroundColor: Colors.grey[400],
                  automaticallyImplyLeading: false,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context, false),
                  )),

              // Map
              Container(
                padding: EdgeInsets.all(0),
                child: Column(
                  children: [
                    // Map
                    Container(
                      height: mapHeight,
                      child: Stack(
                        children: [
                          GoogleMap(
                            mapType: MapType.normal,
                            initialCameraPosition: _kGooglePlex,
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
                            },
                            onCameraMove: (position) async {
                              final coordinates = Coordinates(
                                position.target.latitude,
                                position.target.longitude,
                              );
                              var addresses = await Geocoder.local
                                  .findAddressesFromCoordinates(coordinates);
                              var first = addresses.first;
                              //print("${first.featureName} : ${first.addressLine}");

                              setState(() {
                                _longitudeController.text =
                                    coordinates.longitude.toString();
                                _latitudeController.text =
                                    coordinates.latitude.toString();

                                _streetNameController.text =
                                    "${first.countryName} : ${first.addressLine}";
                              });
                            },
                          ),
                          Positioned(
                              left: screenSize.width / 2 - 25,
                              bottom: mapHeight / 2,
                              child: Icon(
                                Icons.pin_drop_outlined,
                                size: 50,
                                color: Colors.red,
                              ))
                        ],
                      ),
                    ),
                    SizedBox(height: 10),

                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _streetNameController,
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: Colors.grey),
                              labelText:
                                  AppLocalizations.of(context).streetLabelText,
                              hintStyle: TextStyle(
                                  color: Colors.grey[500], fontSize: 13),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.green[700]),
                              ),
                              errorText: !state.isStreetNameValid
                                  ? "${AppLocalizations.of(context).invalidText} ${AppLocalizations.of(context).streetLabelText}"
                                  : null,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            onChanged: (text) {
                              value = text;
                            },
                          ),
                          Row(
                            children: [
                              // 1
                              Expanded(
                                child: TextFormField(
                                  autofocus: true,
                                  controller: _bdgController,
                                  decoration: InputDecoration(
                                    labelStyle: TextStyle(color: Colors.grey),
                                    labelText:
                                        AppLocalizations.of(context).bdgText,
                                    hintStyle: TextStyle(
                                        color: Colors.grey[500], fontSize: 13),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.green[700]),
                                    ),
                                    errorText: !state.isBdgValid
                                        ? '${AppLocalizations.of(context).invalidText} ${AppLocalizations.of(context).bdgText}'
                                        : null,
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  autocorrect: false,
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              // 2
                              Expanded(
                                child: TextFormField(
                                  controller: _aptController,
                                  decoration: InputDecoration(
                                    labelStyle: TextStyle(color: Colors.grey),
                                    labelText:
                                        AppLocalizations.of(context).aptText,
                                    hintStyle: TextStyle(
                                        color: Colors.grey[500], fontSize: 13),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.green[700]),
                                    ),
                                    errorText: !state.isAptValid
                                        ? "${AppLocalizations.of(context).invalidText} ${AppLocalizations.of(context).aptText}"
                                        : null,
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  autocorrect: false,
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              // 3
                              Expanded(
                                child: TextFormField(
                                  controller: _floorController,
                                  decoration: InputDecoration(
                                    labelStyle: TextStyle(color: Colors.grey),
                                    labelText:
                                        AppLocalizations.of(context).floorText,
                                    hintStyle: TextStyle(
                                        color: Colors.grey[500], fontSize: 13),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.green[700]),
                                    ),
                                    errorText: !state.isFloorValid
                                        ? "${AppLocalizations.of(context).invalidText} ${AppLocalizations.of(context).floorText}"
                                        : null,
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  autocorrect: false,
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              // 4
                              Expanded(
                                child: TextFormField(
                                  controller: _entrController,
                                  decoration: InputDecoration(
                                    labelStyle: TextStyle(color: Colors.grey),
                                    labelText:
                                        AppLocalizations.of(context).entryText,
                                    hintStyle: TextStyle(
                                        color: Colors.grey[500], fontSize: 13),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.green[700]),
                                    ),
                                    errorText: !state.isEntryValid
                                        ? "${AppLocalizations.of(context).invalidText} ${AppLocalizations.of(context).entryText}"
                                        : null,
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  autocorrect: false,
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          /**
                           * 
                           * 
                 Address Comment
                
                
                 */

                          Container(
                            height: 100,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.grey[300])),
                            child: Column(
                              children: [
                                Container(
                                  height: 30,
                                  color: Colors.grey[300],
                                  child: Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)
                                            .addressComment,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Expanded(
                                        child: SizedBox.shrink(),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: _commentController,
                                    maxLines: null,
                                    cursorColor: Colors.grey,
                                    decoration: InputDecoration(
                                      hintText: AppLocalizations.of(context)
                                          .addressComment,
                                      hintStyle: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 13),
                                      border: InputBorder.none,
                                      errorText: !state.isComentValid
                                          ? "invadfjdlf"
                                          : null,
                                    ),
                                    autocorrect: false,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: screenSize.width * 0.1,
                          ),
                          /**
                 
                 
                 Bottom Buttons
                

                 */
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              //cancel
                              Align(
                                // constraints: BoxConstraints(
                                //     minWidth: screenSize.width * 0.3),
                                alignment: Alignment.bottomLeft,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.green),
                                    ),
                                    primary: Colors.green,
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                    ),
                                    padding: EdgeInsets.all(8.0),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    AppLocalizations.of(context).cancelText,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              //confirm
                              Align(
                                alignment: Alignment.bottomRight,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side: BorderSide(color: Colors.green)),
                                    primary: Colors.green,
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed: () {
                                    if (isButtonEnabled(state)) {
                                      _onFormSubmitted();

                                      // Navigator.of(context).push(
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             SchedulScreen(
                                      //               value: _streetNameController
                                      //                   .text,
                                      //             )));
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        AppLocalizations.of(context)
                                            .confirmText,
                                        style: TextStyle(fontSize: 14)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // SizedBox(
                          //   height: 20,
                          // ),
                        ],
                      ),
                    ),

                    // FloatingActionButton.extended(
                    //   onPressed: _goToTheLake,
                    //   label: Text('To the lake!'),
                    //   icon: Icon(Icons.directions_boat),
                    // ),
                  ],
                ),
              ),
            ]),
          );
        },
      ),
    );
  }

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }

  // void getAdd() async {
  //   List<Placemark> placemarks =
  //       await placemarkFromCoordinates(52.2165157, 6.9437819);
  //   print(placemarks);
  // }

  void _onStreetNameChanged() {
    _addressesBloc
        .add(AddressStreetNameChanged(streetName: _streetNameController.text));
    //print('Second text field: ${_streetNameController.text}');
  }

  void _onBdgChanged() {
    _addressesBloc.add(AddressBgdChanged(bgd: _bdgController.text));
  }

  void _onFloorChanged() {
    _addressesBloc.add(AddressfloorChanged(floor: _floorController.text));
  }

  void _onEntryChanged() {
    _addressesBloc.add(AddressEntryChanged(entry: _entrController.text));
  }

  void _onAptChanged() {
    _addressesBloc.add(AddressAptChanged(apt: _aptController.text));
  }

  void _onCommentChanged() {
    _addressesBloc.add(AddressComentChanged(coment: _commentController.text));
  }

  void _onLongitudeChanged() {
    _addressesBloc
        .add(AddressLongitudeChanged(longitude: _longitudeController.text));
  }

  void _onLanditudeChanged() {
    _addressesBloc
        .add(AddressLatitudeChanged(latitude: _latitudeController.text));
  }

  showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text('Click Disclimer.'),
          actions: <Widget>[
            TextButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _onFormSubmitted() {
    final streetName = _streetNameController.text;
    final bdg = _bdgController.text;
    final apt = _aptController.text;
    final floor = _floorController.text;
    final entry = _entrController.text;
    final comment = _commentController.text;
    final longitude = _longitudeController.text;
    final latitude = _latitudeController.text;

    address.Address addresses = address.Address(
      streetName: streetName,
      bdg: bdg,
      apt: apt,
      floor: floor,
      entry: entry,
      comment: comment,
      latitude: latitude,
      longitude: longitude,
    );

    _addressesBloc.add(AddressSubmitted(addresses: addresses));
  }

  @override
  void dispose() {
    _streetNameController.dispose();
    _bdgController.dispose();
    _aptController.dispose();
    _floorController.dispose();
    _entrController.dispose();
    _commentController.dispose();
    _longitudeController.dispose();
    _latitudeController.dispose();

    super.dispose();
  }
}
