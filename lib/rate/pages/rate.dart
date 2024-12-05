import 'dart:math';

import 'package:cat_tinder/data_access/cat_information.dart';
import 'package:cat_tinder/rate/bloc/swipe_cubit.dart';
import 'package:cat_tinder/rate/widgets/menu_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class RatePage extends StatelessWidget {
  RatePage({super.key});

  final double maxWidth = 600;
  final double columnScale = 0.8;
  final double imageScale = 0.85;

  final Radius borderRadius = Radius.circular(16.0);
  final double iconSize = 42.0;
  final TextStyle tagStyle = TextStyle(fontSize: 14, fontStyle: FontStyle.italic);

  final SwipeCubit swipeController = SwipeCubit();

  final List<CatInformation> cards = [
    CatInformation(
      id: '007',
      tags: ['Cute cat', 'Gray'],
      imageUrl: 'https://images.unsplash.com/photo-1518288774672-b94e808873ff?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjB8fGNyYXp5JTIwY2F0fGVufDB8fDB8fHww'
    ),
    CatInformation(
      id: '008',
      imageUrl: 'https://images.unsplash.com/photo-1518288774672-b94e808873ff?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjB8fGNyYXp5JTIwY2F0fGVufDB8fDB8fHww'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double cardWidth = min(maxWidth, size.width * columnScale);
    final double imageSize = min(cardWidth * imageScale, size.height * 0.52);

    return Scaffold(
      body: SafeArea(
        child: CardSwiper(
          controller: swipeController.state,
          onSwipe: swipeController.onSwipe,
          cardsCount: cards.length,
          numberOfCardsDisplayed: 1,
          allowedSwipeDirection: AllowedSwipeDirection.symmetric(horizontal: true),
          threshold: 40,
          padding: EdgeInsets.all(16.0),
          cardBuilder: (context, index, horizontalThreshold, verticalThreshold) {
            return getCard(
              cat: cards.first,
              cardSize: cardWidth,
              imageSize: imageSize
            );
          }
        ),
      ),
      bottomNavigationBar: MenuNavigation(),
    );
  }

  Widget getCard({required CatInformation cat, required double cardSize, required double imageSize}) {
    return Center(
      child: SizedBox(
        width: cardSize,

        child: Card.outlined(
          elevation: 12,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Image
                  ClipRRect(
                    borderRadius: BorderRadius.all(borderRadius),
                    child: Image.network(
                      cat.imageUrl,
                      width: imageSize, 
                      height: imageSize, 
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Name
                  if (cat.tags.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.only(top: 12.0),
                      constraints: BoxConstraints(minWidth: imageSize),
                      child: Text(
                        cat.tags.join(', '),
                        textAlign: TextAlign.left, 
                        softWrap: true,
                        style: tagStyle
                      )
                    ),
                  // Buttons
                  Container(
                    padding: EdgeInsets.only(top: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton.filled(
                          icon: Icon(Icons.favorite_rounded),
                          onPressed: () {},
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.pinkAccent.shade200,
                            foregroundColor: Colors.white,
                            iconSize: iconSize
                          ),
                        ),
                        IconButton.filled(
                          icon: Icon(Icons.close),
                          onPressed: () {},
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.grey.shade600,
                            foregroundColor: Colors.white,
                            iconSize: iconSize
                          ),
                        ),
                      ],
                    )
                  )
                ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}