import 'package:expiry/Layout/Sidebar/BaseDrawerHeader.dart';
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

  getHeaderIcon() {
    return isUserLoggedIn() ? Icons.people : null;
  }

  getGroupName() {
    return isUserLoggedIn() ? "Group name" : '';
  }

  getDisplayName() {
    return AuthenticationHelper().instance.currentUser?.displayName ??
        AuthenticationHelper().instance.currentUser?.email ??
        '';
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: <Widget>[
                BaseDrawerHeader(icon: getHeaderIcon(), displayName: getDisplayName(), groupName: getGroupName()),
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
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
              child: Image.asset("lib/assets/ExpiryLogoLight.png", width: 70),
            ),
          ),
        ],
      ),
    );
  }
}
