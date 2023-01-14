import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'SignInForm.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.signInPageAppBarTitle),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const <Widget>[
          Expanded(
              child: Image(
            image: AssetImage('lib/assets/SignIn.png'),
            width: 300,
            height: 300,
          )),
          SignInForm()
        ],
      ),
    );
  }
}
