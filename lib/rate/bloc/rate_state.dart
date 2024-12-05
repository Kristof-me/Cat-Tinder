import 'package:cat_tinder/data_access/cat_information.dart';
import 'package:equatable/equatable.dart';

class RateState extends Equatable {
  final List<CatInformation> liked;
  final List<CatInformation> disliked;
  final CatInformation? currentCat;

  const RateState({
    required this.liked,
    required this.disliked,
    this.currentCat,
  });

  RateState copyWith({
    List<CatInformation>? liked,
    List<CatInformation>? disliked,
    CatInformation? currentCat,
  }) {
    return RateState(
      liked: liked ?? this.liked,
      disliked: disliked ?? this.disliked,
      currentCat: currentCat ?? this.currentCat,
    );
  }

  RateState copyWithRate(CatInformation cat, bool isLiked) {
    return RateState(
      liked: isLiked ? [...liked, cat] : liked,
      disliked: isLiked ? disliked : [...disliked, cat],
      currentCat: currentCat,
    );
  }
  
  @override
  List<Object?> get props => [liked, disliked, currentCat]; 
}

class InitialState extends RateState {
  InitialState() : super(liked: [], disliked: [], currentCat: null);
}