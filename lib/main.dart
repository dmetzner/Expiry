import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expiry/BlackMaterialColor.dart';
import 'package:expiry/Item/AddItemActionButton.dart';
import 'package:expiry/Layout/SearchAwareAppBar.dart';
import 'package:expiry/Layout/Sidebar/SidebarDrawer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

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
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SearchAwareAppBar(),
      drawer: const SidebarDrawer(),
      body: Center(
        child: FutureBuilder(
          future: db.collection("products").get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(child: Text('An error occured: ${snapshot.error}'));
              } else {
                List<DocumentSnapshot> sortedDocs = snapshot.data!.docs;
                sortedDocs.sort((a, b) {
                  Timestamp expiryA = (a.data() as Map)['expiryDate'];
                  Timestamp expiryB = (b.data() as Map)['expiryDate'];
                  return expiryA.compareTo(expiryB);
                });

                return ListView.builder(
                  itemCount: sortedDocs.length,
                  itemBuilder: (context, index) {
                    var doc = sortedDocs[index];
                    Map data = (doc.data() as Map);

                    Timestamp currentExpiryDate = data['expiryDate'];
                    Timestamp? prevExpiryDate = index > 0 ? (sortedDocs[index - 1].data() as Map)['expiryDate'] : null;

                    var widgets = <Widget>[];

                    if (prevExpiryDate == null ||
                        getDaysUntilExpiry(currentExpiryDate) != getDaysUntilExpiry(prevExpiryDate)) {
                      widgets.add(Container(
                        height: 50,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.grey[200]!, Colors.white],
                            stops: const [1.0, 1.0],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: getColorForExpiry(currentExpiryDate),
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(getTextForExpiry(currentExpiryDate)),
                            Expanded(child: Container()),
                            GestureDetector(
                              onTap: () {
                                print("Hello World");
                              },
                              child: Container(
                                width: 17.5,
                                height: 17.5,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey[300],
                                ),
                                child: const Icon(
                                  Icons.close_rounded,
                                  size: 11,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ));
                    }

                    widgets.add(Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey[400]!,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 80.0,
                            width: 80.0,
                            decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.grey, width: 1.0)),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(data["imageUrl"] ?? "https://picsum.photos/200/300"),
                              ),
                            ),
                          ),
                          SizedBox(width: 16.0),
                          Container(
                            height: 80.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(formatTimestamp(data["expiryDate"]),
                                    style: TextStyle(
                                      color: Colors.grey[400],
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12,
                                    )),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(data["name"],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        )),
                                  ),
                                ),
                                Text(data["description"],
                                    style: TextStyle(
                                      color: Colors.grey[400],
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12,
                                    )),
                              ],
                            ),
                          ),
                          Spacer(),
                          Container(
                            height: 80.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: ((data["tags"] ?? []) as List<dynamic>)
                                  .map((e) => Container(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(e.toString(),
                                            style: TextStyle(
                                              color: Colors.grey[400],
                                              fontWeight: FontWeight.w300,
                                              fontSize: 16,
                                            )),
                                      ))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ));

                    return Column(
                      children: widgets,
                    );
                  },
                );
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      floatingActionButton: const AddItemActionButton(),
    );
  }
}

getTextForExpiry(Timestamp expiryDate) {
  var days = getDaysUntilExpiry(expiryDate);
  if (days < 0) {
    return "Expired";
  } else if (days == 0) {
    return "Expires today";
  } else if (days == 1) {
    return "Expires tomorrow";
  } else {
    return "Expires in $days days";
  }
}

getColorForExpiry(Timestamp expiryDate) {
  var days = getDaysUntilExpiry(expiryDate);
  if (days < 0) {
    return Colors.red[900]!;
  } else if (days < 2) {
    return Colors.deepOrange;
  } else if (days < 7) {
    return Colors.orange;
  } else {
    return Colors.green;
  }
}

int getDaysUntilExpiry(Timestamp expiryDate) {
  var now = DateTime.now();
  var expiry = expiryDate.toDate();
  var difference = expiry.difference(now);
  var days = difference.inDays;
  return days < 0 ? -1 : days;
}

String formatTimestamp(Timestamp timestamp) {
  return DateFormat('dd MMM yyyy').format(timestamp.toDate());
}
