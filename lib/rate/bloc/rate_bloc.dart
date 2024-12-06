import 'dart:async';
import 'dart:math';

import 'package:cat_tinder/auth/bloc/auth_bloc.dart';
import 'package:cat_tinder/auth/bloc/auth_state.dart';
import 'package:cat_tinder/data_access/cat_information.dart';
import 'package:cat_tinder/data_access/firestore_service.dart';
import 'package:cat_tinder/data_access/image_service.dart';
import 'package:cat_tinder/rate/bloc/rate_event.dart';
import 'package:cat_tinder/rate/bloc/rate_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class RateBloc extends Bloc<RateEvent, RateState> {
  CardSwiperController controller = CardSwiperController();

  AuthState authState = InitialAuthState();
  late final StreamSubscription authListener;

  final ImageService _imageService = ImageService();
  final FirestoreService _firestoreService = FirestoreService();

  bool get _isAuthorized => authState is SignedInUser;
  String get _uid => (authState as SignedInUser).user.uid.toString();

  RateBloc(AuthBloc authBloc) : super(InitialRateState()) {

    on<FetchCats>((event, emit) => _fetchCats(event, emit));
    on<GetNextCat>((event, emit) => _getNextCat(event, emit));
    on<RateCat>((event, emit) => _rateCat(event, emit));
    on<LoadPersisted>((event, emit) => _loadPersisted(event, emit));

    // The initialization process
    on<InitializeRate>((event, emit) async {
      emit(InitialRateState());
      add(LoadPersisted(true));
      add(LoadPersisted(false));
      add(FetchCats(loadAutomatically: true));
    });

    authState = authBloc.state;

    authListener = authBloc.stream.listen((state) {
      authState = state;
      if(state is SignedInUser) {
        add(InitializeRate());
      }
    });

    add(InitializeRate());
  }

  void _fetchCats(FetchCats event, Emitter<RateState> emit) async {
    if (!_isAuthorized) { return; }
    
    emit(state.copyWith(loading: true));
    
    // we select the indexes randomly (otherwise we would need locks and really complex logic)
    Random random = Random();
    int maxNumberOfImages = 1941;
    final cats = await _imageService.getImages(skip: random.nextInt(maxNumberOfImages - 10));

    if (event.loadAutomatically) {
      emit(state.copyWith(fetched: cats, loading: false, currentCat: cats.first));
    }
    else {
      emit(state.copyWith(fetched: cats, loading: false));
    }
  }

  void _getNextCat(GetNextCat event, Emitter<RateState> emit) {
    if (!_isAuthorized || state.fetched.isEmpty) { return; }

    int index = state.currentCat == null ? -1 : state.fetched.indexOf(state.currentCat!);
    
    if (state.fetched.length > index + 1) {
      emit(state.copyWith(currentCat: state.fetched[index + 1]));
    } else {
      add(FetchCats(loadAutomatically: true));
    }
    
  }

  void _rateCat(RateCat event, Emitter<RateState> emit) {
    if (!_isAuthorized) { return; }

    _firestoreService.addRating(_uid, event.cat, event.isLiked);
    emit(state.copyWithRate(event.cat, event.isLiked));
    add(GetNextCat()); // Automatically load the next item after rating
  }

  void _loadPersisted(LoadPersisted event, Emitter<RateState> emit) async {
    if (!_isAuthorized) { return; }

    emit(state.copyWith(loading: true));
    final lastDoc = event.isLiked ? state.lastLikedDoc : state.lastDislikedDoc;

    final ratings = await _firestoreService.getRatings(_uid, event.isLiked, lastDoc);

    if (ratings.docs.isEmpty) {
        emit(state.copyWith(loading: false));
       return; 
      }

    DocumentSnapshot? lastDocLoaded = ratings.docs.last;
    List<CatInformation> cats = ratings.docs
      .map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        return CatInformation(
          id: data['id'],
          imageUrl: data['imageUrl'],
          tags: List<String>.from(data['tags'])
        );
      })
      .toList();
      
    emit(state.copyWithPersistedRates(cats, event.isLiked, lastDocLoaded));
  }

  bool onSwipe(int previousIndex, int? currentIndex, CardSwiperDirection direction) {
    if (direction == CardSwiperDirection.left) {
      add(RateCat(state.currentCat!, true));
    } else if (direction == CardSwiperDirection.right) {
      add(RateCat(state.currentCat!, false));
    }

    return true;
  }

  @override
  Future<void> close() {
    authListener.cancel();
    return super.close();
  }
}
