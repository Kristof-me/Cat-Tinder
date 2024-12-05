import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class SwipeCubit extends Cubit<CardSwiperController> {
  SwipeCubit() : super(CardSwiperController());
  
  bool onSwipe(int previousIndex, int? currentIndex, CardSwiperDirection direction) {
    print('The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top');
    return true;
  }
}