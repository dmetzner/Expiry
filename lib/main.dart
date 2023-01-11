import 'package:flutter/material.dart';
import 'package:householder/Item/AddItemActionButton.dart';
import 'package:householder/BlackMaterialColor.dart';
import 'package:householder/SearchAwareAppBar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// import 'package:flutter/rendering.dart';  // debug paint

void main() {
  // debugPaintSizeEnabled = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        primarySwatch: blackMaterialColor,
        drawerTheme: const DrawerThemeData(
          backgroundColor: Colors.black,
        ),
      ),
      title: "AppLocalizations.of(context)!.appTitle",
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SearchAwareAppBar(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Text(
                'Coming soon',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
            ),
            ListTile(
              textColor: Colors.white,
              iconColor: Colors.white,
              leading: const Icon(Icons.settings),
              title: Text(AppLocalizations.of(context)!.settings),
            ),
          ],
        ),
      ),
      body: Center(
        child: ListView.builder(itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.image_rounded),
            title: Text('Produkt $index'),
            subtitle: Text('Produkt $index'),
            trailing: Icon(Icons.favorite),
          );
        }),
      ),
      floatingActionButton: const AddItemActionButton(),
    );
  }
}

// class SignInForm extends StatefulWidget {
//   @override
//   _SignInFormState createState() => _SignInFormState();
// }
//
// class _SignInFormState extends State<SignInForm> {
//   final _formKey = GlobalKey<FormState>();
//   String? _email;
//   String? _password;
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           TextFormField(
//             decoration: InputDecoration(labelText: 'Email'),
//             validator: (value) {
//               if (value.isEmpty) {
//                 return 'Please enter a valid email';
//               }
//               return null;
//             },
//             onSaved: (value) => _email = value,
//           ),
//           TextFormField(
//             decoration: InputDecoration(labelText: 'Password'),
//             obscureText: true,
//             validator: (value) {
//               if (value.isEmpty) {
//                 return 'Please enter a valid password';
//               }
//               return null;
//             },
//             onSaved: (value) => _password = value,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 16.0),
//             child: RaisedButton(
//               onPressed: () {
//                 if (_formKey.currentState.validate()) {
//                   _formKey.currentState.save();
//                   // Sign in the user with the email and password
//                 }
//               },
//               child: Text('Sign In'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
