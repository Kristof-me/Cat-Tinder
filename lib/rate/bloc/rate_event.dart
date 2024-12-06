import 'package:cat_tinder/data_access/cat_information.dart';
import 'package:equatable/equatable.dart';

abstract class RateEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitializeRate extends RateEvent {}

class FetchCats extends RateEvent {
  FetchCats({required this.loadAutomatically});
  final bool loadAutomatically;

  @override
  List<Object?> get props => [loadAutomatically];
}

class GetNextCat extends RateEvent {}

class RateCat extends RateEvent {
  RateCat(this.cat, this.isLiked);

  final CatInformation cat;
  final bool isLiked;

  @override
  List<Object?> get props => [cat, isLiked];
}

class LoadPersisted extends RateEvent {
  LoadPersisted(this.isLiked);

  final bool isLiked;

  @override
  List<Object?> get props => [isLiked];
}