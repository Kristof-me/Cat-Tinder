import 'package:cat_tinder/data_access/cat_information.dart';
import 'package:cat_tinder/rate/bloc/rate_event.dart';
import 'package:cat_tinder/rate/bloc/rate_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategorizationBloc extends Bloc<RateEvent, RateState> {
  final List<CatInformation> _loadedCats; 
  int _currentIndex = 0;

  CategorizationBloc(this._loadedCats) : super(RateState(liked: [], disliked: [], currentCat: null)) {
    on<LoadNextBatch>((event, emit) {
      // TODO Load the next batch of cats
      _currentIndex = 0;
      emit(state.copyWith(liked: [], disliked: []));
    });

    // To load the initial batch
    add(LoadNextBatch());

    on<LoadNextCat>((event, emit) {
      if (_currentIndex < _loadedCats.length) {
        emit(state.copyWith(currentCat: _loadedCats[_currentIndex]));
        _currentIndex++;
      } else {
        emit(state.copyWith(currentCat: null));
        add(LoadNextBatch());
      }
    });

    on<RatedCat>((event, emit) {
      emit(state.copyWithRate(event.cat, event.isLiked));
      add(LoadNextCat()); // Automatically load the next item
    });
  }
}
