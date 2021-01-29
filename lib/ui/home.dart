import 'package:flutter/material.dart';

import 'package:jessynote/ui/jessynote_screen.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("JessyNote"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: new JessyNoteScreen(),
    );
  }
}


