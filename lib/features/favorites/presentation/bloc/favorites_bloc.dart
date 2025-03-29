import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final List<String> _favoriteIds = [];

  FavoritesBloc() : super(FavoritesInitial()) {
    on<ToggleFavorite>(_onToggleFavorite);
  }

  void _onToggleFavorite(ToggleFavorite event, Emitter<FavoritesState> emit) {
    emit(FavoritesLoading());
    try {
      if (_favoriteIds.contains(event.propertyId)) {
        _favoriteIds.remove(event.propertyId);
      } else {
        _favoriteIds.add(event.propertyId);
      }
      emit(FavoritesLoaded(List.from(_favoriteIds)));
    } catch (e) {
      emit(FavoritesError('Failed to toggle favorite'));
    }
  }

  bool isFavorite(String propertyId) {
    return _favoriteIds.contains(propertyId);
  }
} 