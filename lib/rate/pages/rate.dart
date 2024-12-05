import 'dart:math';

import 'package:cat_tinder/rate/widgets/menu_navigation.dart';
import 'package:flutter/material.dart';

class RatePage extends StatelessWidget {
  RatePage({super.key});

  final String url = 'https://images.unsplash.com/photo-1518288774672-b94e808873ff?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjB8fGNyYXp5JTIwY2F0fGVufDB8fDB8fHww';
  final double maxWidth = 600;
  final double columnScale = 0.8;
  final double imageScale = 0.85;

  final Radius borderRadius = Radius.circular(16.0);
  final double iconSize = 42.0;
  final TextStyle nameStyle = TextStyle(fontSize: 28, fontWeight: FontWeight.bold);
  
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double colWidth = min(maxWidth, size.width * columnScale);
    final double imageSize = colWidth * imageScale;

    return Scaffold(
      body: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: colWidth),
              child: Card.outlined(
                elevation: 12,
                child: Padding(
                  padding: const EdgeInsets.only(top: 24.0, bottom: 24.0),
                  child: Column(
                        
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(borderRadius),
                        child: Image.network(url, width: imageSize, height: imageSize, fit: BoxFit.cover),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 12.0),
                        constraints: BoxConstraints(minWidth: imageSize),
                        child: Text(
                          'Cute Cat', 
                          textAlign: TextAlign.left, 
                          style: nameStyle
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton.filled(
                              icon: Icon(Icons.favorite_rounded),
                              onPressed: () => print('Like'), 
                              style: IconButton.styleFrom(backgroundColor: Colors.pinkAccent.shade200, iconSize: iconSize),
                            ),
                            IconButton.filled(
                              icon: Icon(Icons.close),
                              onPressed: () => print('Dislike'), 
                              style: IconButton.styleFrom(backgroundColor: Colors.grey.shade400, iconSize: iconSize),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MenuNavigation(),
    );
  }
}

/* Swipe demo from https://stackoverflow.com/questions/77745630/how-to-swipe-card-like-tinder-app-in-flutter
class RatePage extends StatefulWidget {
  const RatePage({super.key});

  @override
  _RatePageState createState() => _RatePageState();
}

class _RatePageState extends State<RatePage> {
  List<String> cardList = ["Card 1", "Card 2", "Card 3", "Card 4", "Card 5"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Swipe Cards Demo"),
      ),
      body: Center(
        child: Stack(
          children: cardList.map((card) {
            int index = cardList.indexOf(card);
            return Dismissible(
              key: Key(card),
              direction: DismissDirection.horizontal,
              onDismissed: (direction) {
                setState(() {
                  cardList.removeAt(index);
                });
                if (direction == DismissDirection.endToStart) {
                  // Handle left swipe
                  print("Swiped left on card $index");
                } else if (direction == DismissDirection.startToEnd) {
                  // Handle right swipe
                  print("Swiped right on card $index");
                }
              },
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerLeft,
                child: Icon(Icons.thumb_down, color: Colors.white),
              ),
              secondaryBackground: Container(
                color: Colors.green,
                alignment: Alignment.centerRight,
                child: Icon(Icons.thumb_up, color: Colors.white),
              ),
              child: Card(
                child: Center(
                  child: Text(
                    card,
                    style: TextStyle(fontSize: 24.0),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
*/