import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'Form/SignInForm.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.signInPage_AppBar_Title),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const <Widget>[
            Image(
              image: AssetImage('lib/assets/SignIn.png'),
              width: 200,
              height: 200,
            ),
            SizedBox(height: 20),
            SignInForm()
          ],
        ),
      ),
    );
  }
}
