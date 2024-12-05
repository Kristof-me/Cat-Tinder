import 'package:cat_tinder/rate/widgets/menu_navigation.dart';
import 'package:flutter/material.dart';

class LikedPage extends StatelessWidget {
  const LikedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liked'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
        return ListTile(
          title: Text('Cat $index'),
          leading: Icon(Icons.favorite),
        );
      }),
      bottomNavigationBar: MenuNavigation(),
    );
  }
  
}