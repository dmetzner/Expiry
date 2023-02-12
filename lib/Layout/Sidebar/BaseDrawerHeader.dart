import 'package:flutter/material.dart';

class BaseDrawerHeader extends StatelessWidget {
  final IconData? icon;
  final String displayName;
  final String groupName;
  final bool isVisible;

  const BaseDrawerHeader(
      {Key? key, required this.icon, required this.displayName, this.groupName = '', this.isVisible = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: isVisible,
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
              Visibility(visible: icon != null, child: Icon(icon, color: Colors.white, size: 40)),
              const SizedBox(height: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(groupName, style: const TextStyle(color: Colors.white, fontSize: 22)),
                    Text(displayName, style: const TextStyle(color: Colors.white, fontSize: 18)),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
