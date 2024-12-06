import 'dart:math';
import 'package:cat_tinder/rate/bloc/rate_bloc.dart';
import 'package:cat_tinder/rate/bloc/rate_state.dart';
import 'package:cat_tinder/rate/widgets/menu_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LikedPage extends StatelessWidget {
  const LikedPage({super.key});

  final double maxWidth = 600;
  final double imageScale = 0.75;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final imageSize = min(size.width * imageScale, maxWidth);

    return Scaffold(
      appBar: AppBar(
        title: Text('Liked'),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<RateBloc, RateState>(
          builder: (context, state) {
            List<Widget> children = state.liked.map((cat) {
              return Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Image.network(
                  cat.imageUrl,
                  width: imageSize,
                  height: imageSize,
                  fit: BoxFit.cover
                ),
              );
          }).toList();
            
            return Center(child: Column(children: children));
          },
        ),
      ),
      bottomNavigationBar: MenuNavigation(),
    );
  }
}
