import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../authentication/authentication_handler.dart';
import '../../authentication/sign_in/sign_in_page.dart';
import 'sidebar_drawer_header.dart';
import 'sidebar_list_tile.dart';

class SidebarDrawer extends StatefulWidget {
  const SidebarDrawer({Key? key}) : super(key: key);

  @override
  State<SidebarDrawer> createState() => _SidebarDrawerState();
}

class _SidebarDrawerState extends State<SidebarDrawer> {
  isUserLoggedIn() {
    return AuthenticationHandler().instance.currentUser != null;
  }

  getHeaderIcon() {
    return isUserLoggedIn() ? Icons.people : null;
  }

  getGroupName() {
    return isUserLoggedIn() ? "Group name" : '';
  }

  getDisplayName() {
    return AuthenticationHandler().instance.currentUser?.displayName ??
        AuthenticationHandler().instance.currentUser?.email ??
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
                SidebarDrawerHeader(icon: getHeaderIcon(), displayName: getDisplayName(), groupName: getGroupName()),
                const SizedBox(height: 20),
                SidebarListTile(
                  isVisible: !isUserLoggedIn(),
                  icon: Icons.login,
                  text: AppLocalizations.of(context)!.sidebarDrawer_MenuTitle_SignIn,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInPage()));
                  },
                ),
                SidebarListTile(
                  isVisible: isUserLoggedIn(),
                  icon: Icons.settings,
                  text: AppLocalizations.of(context)!.sidebarDrawer_MenuTitle_Settings,
                  onTap: () {
                    print("ToDo Implement Settings");
                  },
                ),
                SidebarListTile(
                  isVisible: isUserLoggedIn(),
                  icon: Icons.help,
                  text: AppLocalizations.of(context)!.sidebarDrawer_MenuTitle_Support,
                  onTap: () {
                    print("ToDo Implement Support");
                  },
                ),
                SidebarListTile(
                  isVisible: isUserLoggedIn(),
                  icon: Icons.logout,
                  text: AppLocalizations.of(context)!.sidebarDrawer_MenuTitle_SignOut,
                  onTap: () {
                    AuthenticationHandler().instance.signOut();
                  },
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
              child: Image.asset("lib/assets/expiry_logo_light.png", width: 70),
            ),
          ),
        ],
      ),
    );
  }
}
