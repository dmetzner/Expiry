import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expiry/item/edit_item_page.dart';
import 'package:expiry/layout/page_loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'overview/expiry_item_seperator.dart';

class ItemOverview extends StatefulWidget {
  const ItemOverview({Key? key}) : super(key: key);

  @override
  State<ItemOverview> createState() => _ItemOverviewState();
}

class _ItemOverviewState extends State<ItemOverview> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    var future = db.collection('products').get();

    return FutureBuilder(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(child: Text('An error occurred: ${snapshot.error}'));
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
                var id = doc.id;
                Map data = (doc.data() as Map);

                Timestamp currentExpiryDate = data['expiryDate'];
                Timestamp? prevExpiryDate = index > 0 ? (sortedDocs[index - 1].data() as Map)['expiryDate'] : null;

                var widgets = <Widget>[];

                if (prevExpiryDate == null || getDaysUntilExpiry(currentExpiryDate) != getDaysUntilExpiry(prevExpiryDate)) {
                  widgets.add(ExpiryItemSeparator(daysUntilExpiry: getDaysUntilExpiry(currentExpiryDate)));
                }

                widgets.add(Container(
                  // item dividing line
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey[400]!,
                        width: 1.0,
                      ),
                    ),
                  ),
                  // item content
                  child: InkWell(
                    onTap: () {
                      // Navigate to the second page with an ID
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditItemPage(itemId: id),
                        ),
                      ).then((value) => {
                            setState(() {
                              // refresh the page
                              future = db.collection('products').get();
                            })
                          });
                    },
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          height: 80.0,
                          width: 80.0,
                          child: _getImagePreviewWidget(data['image']),
                        ),
                        const SizedBox(width: 16.0),
                        SizedBox(
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
                                      style: const TextStyle(
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
                        const Spacer(),
                        SizedBox(
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
                  ),
                ));

                return Column(
                  children: widgets,
                );
              },
            );
          }
        } else {
          return const PageLoadingAnimation();
        }
      },
    );
  }

  Widget _getImagePreviewWidget(String? imageBase64) {
    if (_hasValidBase64Image(imageBase64)) {
      return ClipRRect(borderRadius: BorderRadius.circular(8), child: _loadImageFromMemory(base64Decode(imageBase64!)));
    } else {
      return const Icon(Icons.image_rounded, color: Colors.grey, size: 80);
    }
  }

  bool _hasValidBase64Image(String? imageBase64) {
    if (imageBase64 == null || imageBase64.isEmpty) {
      return false;
    }
    try {
      base64Decode(imageBase64);
      return true;
    } catch (e) {
      return false;
    }
  }

  Widget _loadImageFromNetwork(String filePath) {
    return Image.network(
      filePath,
      fit: BoxFit.cover,
      width: 100,
      height: 100,
    );
  }

  Widget _loadImageFromMemory(Uint8List base64ImageByeList) {
    return Image.memory(
      base64ImageByeList,
      fit: BoxFit.cover,
      width: 100,
      height: 100,
    );
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
}
