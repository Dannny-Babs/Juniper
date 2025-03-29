import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class ToggleFavorite extends FavoritesEvent {
  final String propertyId;

  const ToggleFavorite(this.propertyId);

  @override
  List<Object> get props => [propertyId];
}

// States
abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<String> favoriteIds;

  const FavoritesLoaded(this.favoriteIds);

  @override
  List<Object> get props => [favoriteIds];
}

class FavoritesError extends FavoritesState {
  final String message;

  const FavoritesError(this.message);

  @override
  List<Object> get props => [message];
}

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