import 'package:flutter/material.dart';

import '../app_navigation_bar.dart';
class ScaffoldWithNavbarPage extends StatefulWidget {
  const ScaffoldWithNavbarPage({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<ScaffoldWithNavbarPage> createState() => _ScaffoldWithNavbarPageState();
}

class _ScaffoldWithNavbarPageState extends State<ScaffoldWithNavbarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(minWidth: 200, maxWidth: 300),
            child: AppNavigationBar(), // navbar will stay
          ),
          Expanded(child: widget.child) //dynamic pages based on routing
        ],
      ),
    );
  }
}
