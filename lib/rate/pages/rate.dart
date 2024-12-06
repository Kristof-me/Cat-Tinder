import 'dart:math';

import 'package:cat_tinder/data_access/cat_information.dart';
import 'package:cat_tinder/rate/bloc/rate_bloc.dart';
import 'package:cat_tinder/rate/bloc/rate_event.dart';
import 'package:cat_tinder/rate/bloc/rate_state.dart';
import 'package:cat_tinder/rate/widgets/menu_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class RatePage extends StatelessWidget {
  RatePage({super.key});

  final double maxWidth = 600;
  final double columnScale = 0.8;
  final double imageScale = 0.85;

  final Radius borderRadius = Radius.circular(16.0);
  final double iconSize = 42.0;
  final TextStyle tagStyle =
      TextStyle(fontSize: 14, fontStyle: FontStyle.italic);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double cardWidth = min(maxWidth, size.width * columnScale);
    final double imageSize = min(cardWidth * imageScale, size.height * 0.52);

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<RateBloc, RateState>(
          builder: (context, state) {
            final rateBloc = BlocProvider.of<RateBloc>(context);

            final cardsLength = state.fetched.length;

            if (state.loading || (state.currentCat == null && cardsLength > 0)) {
              return Center(child: CircularProgressIndicator());
            }

            if (cardsLength == 0) {
              return Center(child: Text('No more cats to rate'));
            }

            return CardSwiper(
            controller: rateBloc.controller,
            onSwipe: rateBloc.onSwipe,
            cardsCount: cardsLength,
            numberOfCardsDisplayed: 1,
            allowedSwipeDirection: AllowedSwipeDirection.symmetric(horizontal: true),
            threshold: 40,
            padding: EdgeInsets.all(16.0),
            cardBuilder:
              (context, index, horizontalThreshold, verticalThreshold) {
                return getCard(
                  cat: state.currentCat!,
                  cardSize: cardWidth,
                  imageSize: imageSize,
                  rateBloc: rateBloc,
                );
              }
            );
          },
        ),
      ),
      bottomNavigationBar: MenuNavigation(),
    );
  }

  Widget getCard({
    required CatInformation cat,
    required double cardSize,
    required double imageSize,
    required RateBloc rateBloc,
  }) {
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
                        child: Text(cat.tags.join(', '),
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
                              onPressed: () => rateBloc.add(RateCat(cat, true)),
                              style: IconButton.styleFrom(
                                  backgroundColor: Colors.pinkAccent.shade200,
                                  foregroundColor: Colors.white,
                                  iconSize: iconSize),
                            ),
                            IconButton.filled(
                            icon: Icon(Icons.close),
                            onPressed: () => rateBloc.add(RateCat(cat, false)),
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
