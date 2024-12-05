import 'package:cat_tinder/rate/widgets/menu_navigation.dart';
import 'package:flutter/material.dart';

class DislikedPage extends StatelessWidget {
  const DislikedPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Disliked')),
      body: Center(
        child: Text('Disliked'),
      ),
      bottomNavigationBar: MenuNavigation(),
    );
  }
}