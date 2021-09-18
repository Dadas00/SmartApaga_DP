import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_apaga/LoginRegister/Bloc/RegisterBloc/UserRepository.dart';
import 'package:smart_apaga/LoginRegister/view/login/LoginScrean.dart';
import 'package:smart_apaga/MenuButton_screens/Contactifo_screen/contactInfo_screen.dart';
import 'package:smart_apaga/MenuButton_screens/MyQrCode_Screen.dart';
import 'package:smart_apaga/MenuButton_screens/dashboard_Screen.dart';
import 'package:smart_apaga/MenuButton_screens/orderBag_Screen.dart';
import 'package:smart_apaga/MenuButton_screens/settings_Screen.dart';
import 'package:smart_apaga/Pickup/View/SchedulScreen.dart';
import 'package:smart_apaga/Pickup/View/WastTypeScreen.dart';
import 'package:smart_apaga/l10n/L10n.dart';
import 'package:smart_apaga/l10n/locale_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MenuButton extends StatelessWidget {
  final UserRepository _userRepository = new UserRepository();
  final List<int> countwast;
  final int plastic;
  final int paper;
  final int glass;

  //WastTypeScreenState _wastTypeScreenState = new WastTypeScreenState();
  MenuButton({Key key, this.plastic, this.paper, this.glass, this.countwast})
      : super(key: key);

  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    final locale = provider.locale ?? Locale('en');
    return Drawer(
      child: Material(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 90.0,
              child: DrawerHeader(
                decoration: BoxDecoration(color: Colors.green.shade300),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: locale,
                        icon: Container(width: 12),
                        items: L10n.all.map(
                          (locale) {
                            final flag = L10n.getFlag(locale.languageCode);

                            return DropdownMenuItem(
                              child: Center(
                                child: Text(
                                  flag,
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              value: locale,
                              onTap: () {
                                final provider = Provider.of<LocaleProvider>(
                                    context,
                                    listen: false);

                                provider.setLocale(locale);
                              },
                            );
                          },
                        ).toList(),
                        onChanged: (_) {},
                      ),
                    ),

                    // TextButton(
                    //   style: TextButton.styleFrom(
                    //     shape: CircleBorder(),
                    //   ),
                    //   onPressed: () {
                    //     final provider =
                    //         Provider.of<LocaleProvider>(context, listen: false);

                    //     provider.setLocale(locale);
                    //   },
                    //   child: Text(
                    //     'HY',
                    //     style: TextStyle(
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    // ),
                    // TextButton(
                    //   style: TextButton.styleFrom(
                    //     shape: CircleBorder(),
                    //   ),
                    //   onPressed: () {},
                    //   child: Text(
                    //     'EN',
                    //     style: TextStyle(
                    //       inherit: 10.isOdd,
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    // ),
                    // TextButton(
                    //   style: TextButton.styleFrom(
                    //     shape: CircleBorder(),
                    //   ),
                    //   onPressed: () {},
                    //   child: Text(
                    //     'RU',
                    //     style: TextStyle(color: Colors.white),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            buildMenu(
              text: AppLocalizations.of(context).dashbroadText,
              onCliced: () => selectedItem(context, 0),
            ),
            Divider(
              endIndent: 150.0,
              color: Colors.green.shade300,
              thickness: 1.0,
              indent: 15,
              height: 0.0,
            ),
            buildMenu(
              text: AppLocalizations.of(context).shedulText,
              onCliced: () => selectedItem(context, 1),
            ),
            Divider(
              endIndent: 150.0,
              color: Colors.green.shade300,
              thickness: 1.0,
              indent: 15,
              height: 0.0,
            ),
            buildMenu(
              text: AppLocalizations.of(context).qrCodeText,
              onCliced: () => selectedItem(context, 2),
            ),
            Divider(
              endIndent: 150.0,
              color: Colors.green.shade300,
              thickness: 1.0,
              indent: 15,
              height: 0.0,
            ),
            buildMenu(
              text: AppLocalizations.of(context).orderBags,
              onCliced: () => selectedItem(context, 3),
            ),
            Divider(
              endIndent: 150.0,
              color: Colors.green.shade300,
              thickness: 1.0,
              indent: 15,
              height: 0.0,
            ),
            buildMenu(
              text: AppLocalizations.of(context).contatcIfno,
              onCliced: () => selectedItem(context, 4),
            ),
            Divider(
              endIndent: 150.0,
              color: Colors.green.shade300,
              thickness: 1.0,
              indent: 15,
              height: 0.0,
            ),
            buildMenu(
              text: AppLocalizations.of(context).settingsText,
              onCliced: () => selectedItem(context, 5),
            ),
            Divider(
              endIndent: 150.0,
              color: Colors.green.shade300,
              thickness: 1.0,
              indent: 15,
              height: 0.0,
            ),
            buildMenu(
              text: AppLocalizations.of(context).logOutText,
              onCliced: () => selectedItem(context, 6),
            ),
            Image(
                fit: BoxFit.contain,
                height: 200.0,
                width: 200.0,
                alignment: Alignment.topCenter,
                image: AssetImage('assets/images/eco_earth.png')),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenu({
    String text,
    VoidCallback onCliced,
  }) {
    final color = Colors.black;
    final hoverColor = Colors.black87;
    final fontsize = 13.0;
    return ListTile(
      title: Text(
        text,
        style: TextStyle(fontSize: fontsize, color: color),
      ),
      hoverColor: hoverColor,
      onTap: onCliced,
    );
  }

  Future<void> selectedItem(BuildContext context, int index) async {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Dashboard(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SchedulScreen(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => QrCodeScreen(),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => OrderBags(),
        ));
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ContactScreen(),
        ));
        break;
      case 5:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SettingsScreen(),
        ));
        break;
      case 6:
        print('kayf');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove('email');
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext ctx) => LoginScreen()));
    }
  }
}
