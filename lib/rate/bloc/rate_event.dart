import 'package:cat_tinder/data_access/cat_information.dart';
import 'package:equatable/equatable.dart';

abstract class RateEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadNextBatch extends RateEvent {}

class LoadNextCat extends RateEvent {}

class RatedCat extends RateEvent {
  RatedCat(this.cat, this.isLiked);

  final CatInformation cat;
  final bool isLiked;

  @override
  List<Object?> get props => [cat, isLiked];
}
