part of 'favorites_bloc.dart';

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