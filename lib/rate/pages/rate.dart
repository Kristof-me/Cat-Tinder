import 'dart:math';

import 'package:cat_tinder/data_access/cat_information.dart';
import 'package:cat_tinder/rate/widgets/menu_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class RatePage extends StatefulWidget {
  const RatePage({super.key});

  @override
  State<RatePage> createState() => _RatePageState();
}

class _RatePageState extends State<RatePage> {
  final double maxWidth = 600;
  final double columnScale = 0.8;
  final double imageScale = 0.85;

  final Radius borderRadius = Radius.circular(16.0);
  final double iconSize = 42.0;
  final TextStyle nameStyle =
      TextStyle(fontSize: 28, fontWeight: FontWeight.bold);

  final CardSwiperController controller = CardSwiperController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  final List<CatInformation> cards = [
    CatInformation(
        id: '007',
        name: 'Cute cat',
        imageUrl:
            'https://images.unsplash.com/photo-1518288774672-b94e808873ff?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjB8fGNyYXp5JTIwY2F0fGVufDB8fDB8fHww'),
    CatInformation(
        id: '008',
        name: 'Cute cat 2',
        imageUrl:
            'https://images.unsplash.com/photo-1518288774672-b94e808873ff?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjB8fGNyYXp5JTIwY2F0fGVufDB8fDB8fHww'),
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double cardWidth = min(maxWidth, size.width * columnScale);
    final double imageSize = min(cardWidth * imageScale, size.height * imageScale);

    return Scaffold(
      body: SafeArea(
        child: Flexible(
          fit: FlexFit.tight,
          child: CardSwiper(
            controller: controller,
            onSwipe: _onSwipe,
            cardsCount: cards.length,
            numberOfCardsDisplayed: 2,
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
      ),
      bottomNavigationBar: MenuNavigation(),
    );
  }

  Widget getCard({required CatInformation cat, required double cardSize, required double imageSize}) {
    return Card.outlined(
      elevation: 12,
      child: Padding(
        padding: const EdgeInsets.only(top: 24.0, bottom: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(borderRadius),
              child: Image.network(cat.imageUrl,
                  width: imageSize, height: imageSize, fit: BoxFit.cover),
            ),
            Container(
                padding: const EdgeInsets.only(top: 12.0),
                constraints: BoxConstraints(minWidth: imageSize),
                child: Text(cat.name,
                    textAlign: TextAlign.left, style: nameStyle)),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton.filled(
                    icon: Icon(Icons.favorite_rounded),
                    onPressed: () {},
                    style: IconButton.styleFrom(
                        backgroundColor: Colors.pinkAccent.shade200,
                        iconSize: iconSize),
                  ),
                  SizedBox(width: 64.0),
                  IconButton.filled(
                    icon: Icon(Icons.close),
                    onPressed: () {},
                    style: IconButton.styleFrom(
                        backgroundColor: Colors.grey.shade400,
                        iconSize: iconSize),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

    bool _onSwipe(int previousIndex, int? currentIndex, CardSwiperDirection direction) {
    print('The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top');
    return true;
  }
}