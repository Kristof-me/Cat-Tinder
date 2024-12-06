import 'package:cat_tinder/data_access/cat_information.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class RateState extends Equatable {
  final List<CatInformation> fetched;

  final List<CatInformation> liked;
  final List<CatInformation> disliked;
  final DocumentSnapshot? lastLikedDoc;
  final DocumentSnapshot? lastDislikedDoc;
  
  final CatInformation? currentCat;
  final bool loading;

  const RateState({
    required this.fetched,
    required this.liked,
    required this.disliked,
    this.lastLikedDoc,
    this.lastDislikedDoc,
    this.currentCat,
    required this.loading,
  });

  RateState copyWith({
    List<CatInformation>? fetched,
    List<CatInformation>? liked,
    List<CatInformation>? disliked,
    DocumentSnapshot? lastLikedDoc,
    DocumentSnapshot? lastDislikedDoc,
    CatInformation? currentCat,
    bool? loading,
  }) {
    return RateState(
      fetched: fetched ?? this.fetched,
      liked: liked ?? this.liked,
      disliked: disliked ?? this.disliked,
      lastLikedDoc: lastLikedDoc ?? this.lastLikedDoc,
      lastDislikedDoc: lastDislikedDoc ?? this.lastDislikedDoc,
      currentCat: currentCat ?? this.currentCat,
      loading: loading ?? this.loading,
    );
  }

  RateState copyWithRate(CatInformation cat, bool isLiked) {
    if(isLiked) {
      return copyWith(liked: [...liked, cat]);
    }

    return copyWith(disliked: [...disliked, cat]);
  }

  RateState copyWithPersistedRates(List<CatInformation> information, bool isLiked, DocumentSnapshot? lastDoc) {
    if (information.isEmpty || lastDoc == null) {
      return this;
    }

    if (isLiked) {
      return copyWith(
        liked: [...information, ...liked], 
        lastLikedDoc: lastDoc,
      );
    } 
      
    return copyWith(
      disliked: [...information, ...disliked],
      lastDislikedDoc: lastDoc,
    );
  }
  
  @override
  List<Object?> get props => [fetched, liked, disliked, currentCat, loading]; 
}

class InitialRateState extends RateState {
  InitialRateState() : super(
    fetched: [],
    liked: [],
    disliked: [],
    loading: false,
  );
}