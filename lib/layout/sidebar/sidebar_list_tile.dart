import 'package:flutter/material.dart';

class SidebarListTile extends StatefulWidget {
  final Function() onTap;
  final IconData icon;
  final String text;
  bool isVisible;
  SidebarListTile({Key? key, required this.icon, required this.text, required this.onTap, this.isVisible = true})
      : super(key: key);

  @override
  State<SidebarListTile> createState() => _SidebarListTileState();
}

class _SidebarListTileState extends State<SidebarListTile> {
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.isVisible,
      child: InkWell(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(color: getBackgroundColor(), borderRadius: BorderRadius.circular(5)),
          child: ListTile(
            textColor: Colors.white,
            iconColor: Colors.white,
            leading: Icon(widget.icon),
            title: Text(widget.text),
          ),
        ),
        onHover: (bool isHover) {
          setState(() {
            _isHover = isHover;
          });
        },
        onTap: () {
          widget.onTap();
        },
      ),
    );
  }

  getBackgroundColor() {
    return _isHover ? Colors.white24 : Colors.transparent;
  }
}
