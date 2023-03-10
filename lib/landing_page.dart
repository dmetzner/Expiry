import 'package:flutter/material.dart';

import 'item/add_item_action_button.dart';
import 'item/item_overview_page.dart';
import 'layout/search_aware_app_bar.dart';
import 'layout/sidebar/sidebar_drawer.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SearchAwareAppBar(),
      drawer: const SidebarDrawer(),
      body: Center(
        child: ItemOverview(),
      ),
      floatingActionButton: const AddItemActionButton(),
    );
  }
}
