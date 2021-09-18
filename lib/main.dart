import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:smart_apaga/Home/Home/HomeScreen.dart';
// import 'package:smart_apaga/Home/Home/HomeScreen.dart';
import 'package:smart_apaga/LoginRegister/Bloc/AddressBloc/AddressBloc.dart';
import 'package:smart_apaga/LoginRegister/Bloc/LoginBloc/LoginBloc.dart';
import 'package:smart_apaga/LoginRegister/Bloc/PhoneNumberBloc/PhoneNmBloc.dart';
import 'package:smart_apaga/LoginRegister/Bloc/RegisterBloc/RegisterBloc.dart';
import 'package:smart_apaga/LoginRegister/Bloc/RegisterBloc/UserRepository.dart';
import 'package:smart_apaga/LoginRegister/view/login/LoginScrean.dart';
// import 'package:smart_apaga/LoginRegister/view/login/ForgotPassword/ForgotScreen.dart';
// import 'package:smart_apaga/LoginRegister/view/login/LoginScrean.dart';
import 'package:smart_apaga/LoginRegister/view/overal/AddressConfirmationScreen.dart';
import 'package:smart_apaga/LoginRegister/view/register/RegScreen.dart';
import 'package:smart_apaga/MenuButton_screens/Contactifo_screen/contactInfo_screen.dart';
import 'package:smart_apaga/MenuButton_screens/MyQrCode_Screen.dart';
import 'package:smart_apaga/MenuButton_screens/orderBag_Screen.dart';
// import 'package:smart_apaga/LoginRegister/view/register/RegScreen.dart';
// import 'package:smart_apaga/MenuButton_screens/Contactifo_screen/contactInfo_screen.dart';
// import 'package:smart_apaga/MenuButton_screens/MyQrCode_Screen.dart';
import 'package:smart_apaga/Pickup/PickupBloc/PickupBloc.dart';
// import 'package:smart_apaga/Pickup/View/QRScanScreen.dart';
// import 'package:smart_apaga/Pickup/View/WastTypeScreen.dart';
// import 'package:smart_apaga/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_apaga/Pickup/View/QRScanScreen.dart';
import 'package:smart_apaga/Pickup/View/SchedulScreen.dart';
import 'package:smart_apaga/Pickup/View/WastTypeScreen.dart';
import 'package:smart_apaga/l10n/L10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'l10n/locale_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MainScreen());
  });
  runApp(MainScreen());
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isHomeScreen = false;

  UserRepository _userRepository;

  Future<void> checkFirstScreen() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      isHomeScreen = pref.getBool('login') ?? false;
      super.deactivate();
    });
  }

  @override
  void initState() {
    checkFirstScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => LocaleProvider(),
      builder: (context, child) {
        final provider = Provider.of<LocaleProvider>(context);
        return MultiBlocProvider(
          providers: [
            BlocProvider<LoginBloc>(
              create: (BuildContext context) => LoginBloc(_userRepository),
            ),
            BlocProvider<RegisterBloc>(
              create: (BuildContext context) => RegisterBloc(),
            ),
            BlocProvider<AddressBloc>(
              create: (BuildContext context) => AddressBloc(),
            ),
            BlocProvider<PhoneNmBloc>(
              create: (BuildContext context) => PhoneNmBloc(),
            ),
            BlocProvider<PickupBloc>(
              create: (BuildContext context) => PickupBloc(),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: provider.locale,
            supportedLocales: L10n.all,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            home: HomeScreen(),
          ),
        );
      });
}
