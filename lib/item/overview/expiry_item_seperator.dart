import 'package:flutter/material.dart';

class ExpiryItemSeparator extends StatelessWidget {
  final int daysUntilExpiry;
  const ExpiryItemSeparator({Key? key, required this.daysUntilExpiry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.only(left: 10, right: 10),
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
              color: getColorForExpiry(daysUntilExpiry),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
          ),
          const SizedBox(width: 10),
          Text(getTextForExpiry(daysUntilExpiry)),
          Expanded(child: Container()),
          GestureDetector(
            onTap: () {
              print("501 - Delete not implemented");
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
    );
  }

  getTextForExpiry(int daysUntilExpiry) {
    if (daysUntilExpiry < 0) {
      return "Expired";
    } else if (daysUntilExpiry == 0) {
      return "Expires today";
    } else if (daysUntilExpiry == 1) {
      return "Expires tomorrow";
    } else {
      return "Expires in $daysUntilExpiry days";
    }
  }

  getColorForExpiry(int daysUntilExpiry) {
    if (daysUntilExpiry < 0) {
      return Colors.red[900]!;
    } else if (daysUntilExpiry < 2) {
      return Colors.deepOrange;
    } else if (daysUntilExpiry < 7) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }
}
