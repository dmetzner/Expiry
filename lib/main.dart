import 'package:expiry/BlackMaterialColor.dart';
import 'package:expiry/Item/AddItemActionButton.dart';
import 'package:expiry/Layout/SearchAwareAppBar.dart';
import 'package:expiry/Layout/Sidebar/SidebarDrawer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'firebase_options.dart';

// import 'package:flutter/rendering.dart';  // debug paint

void main() async {
  // debugPaintSizeEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      title: "Expiry",
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
      drawer: const SidebarDrawer(),
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
