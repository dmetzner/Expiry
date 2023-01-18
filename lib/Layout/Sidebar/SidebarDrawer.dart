import 'package:expiry/Layout/Sidebar/BaseListTile.dart';
import 'package:expiry/Security/SignIn/SignInPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../Security/AuthenticationHelper.dart';

class SidebarDrawer extends StatefulWidget {
  const SidebarDrawer({Key? key}) : super(key: key);

  @override
  State<SidebarDrawer> createState() => _SidebarDrawerState();
}

class _SidebarDrawerState extends State<SidebarDrawer> {
  isUserLoggedIn() {
    return AuthenticationHelper().instance.currentUser != null;
  }

  getDisplayName() {
    return AuthenticationHelper().instance.currentUser?.displayName ??
        AuthenticationHelper().instance.currentUser?.email ??
        '';
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Visibility(
              visible: isUserLoggedIn(),
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey[600]!,
                      width: 1,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.group, color: Colors.white, size: 40),
                    const SizedBox(height: 10),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text('Group name', style: TextStyle(color: Colors.white, fontSize: 22)),
                          Text(getDisplayName(), style: const TextStyle(color: Colors.white, fontSize: 18)),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: 20),
          BaseListTile(
            isVisible: !isUserLoggedIn(),
            icon: Icons.login,
            text: AppLocalizations.of(context)!.sidebarDrawer_MenuTitle_SignIn,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInPage()));
            },
          ),
          BaseListTile(
            isVisible: isUserLoggedIn(),
            icon: Icons.settings,
            text: AppLocalizations.of(context)!.sidebarDrawer_MenuTitle_Settings,
            onTap: () {
              print("ToDo Implement Settings");
            },
          ),
          BaseListTile(
            isVisible: isUserLoggedIn(),
            icon: Icons.help,
            text: AppLocalizations.of(context)!.sidebarDrawer_MenuTitle_Support,
            onTap: () {
              print("ToDo Implement Support");
            },
          ),
          BaseListTile(
            isVisible: isUserLoggedIn(),
            icon: Icons.logout,
            text: AppLocalizations.of(context)!.sidebarDrawer_MenuTitle_SignOut,
            onTap: () {
              AuthenticationHelper().instance.signOut();
            },
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Image.asset("lib/assets/ExpiryLogoLight.png", width: 70),
            ),
          ),
        ],
      ),
    );
  }
}
