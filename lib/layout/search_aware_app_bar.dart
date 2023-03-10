import 'package:flutter/material.dart';

class SearchAwareAppBar extends StatefulWidget with PreferredSizeWidget {
  const SearchAwareAppBar({Key? key}) : super(key: key);

  @override
  State<SearchAwareAppBar> createState() => _SearchAwareAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SearchAwareAppBarState extends State<SearchAwareAppBar> {
  bool _isSearchBarVisible = false;

  Icon _getAppBarSearchButtonIcon() {
    return _isSearchBarVisible
        ? const Icon(Icons.close)
        : const Icon(Icons.search);
  }

  _search(String value) {
    print('Search: ${value}');
  }

  Widget _getAppBarTitle() {
    if (_isSearchBarVisible) {
      return ListTile(
        leading: const Icon(
          Icons.search,
          color: Colors.white,
          size: 28,
        ),
        title: TextField(
          decoration: const InputDecoration(
            hintText: 'tippe hier zum Suchen...',
            hintStyle: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontStyle: FontStyle.italic,
            ),
            border: InputBorder.none,
          ),
          style: const TextStyle(
            color: Colors.white,
          ),
          autofocus: true,
          onSubmitted: _search,
          onChanged: _search,
        ),
      );
    }

    return const Text("Alle Produkte");
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: _getAppBarTitle(),
      automaticallyImplyLeading: !_isSearchBarVisible,
      actions: [
        IconButton(
            onPressed: () {
              setState(() {
                _isSearchBarVisible = !_isSearchBarVisible;
              });
            },
            icon: _getAppBarSearchButtonIcon(),
            padding: const EdgeInsets.only(right: 20)),
      ],
    );
  }
}
