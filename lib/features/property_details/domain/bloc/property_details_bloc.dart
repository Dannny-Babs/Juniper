import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/property_details.dart';
import '../repositories/property_repository.dart';

// Events
abstract class PropertyDetailsEvent extends Equatable {
  const PropertyDetailsEvent();

  @override
  List<Object?> get props => [];
}

class LoadPropertyDetails extends PropertyDetailsEvent {
  final String propertyId;

  const LoadPropertyDetails(this.propertyId);

  @override
  List<Object> get props => [propertyId];
}

class RefreshPropertyDetails extends PropertyDetailsEvent {
  final String propertyId;

  const RefreshPropertyDetails(this.propertyId);

  @override
  List<Object> get props => [propertyId];
}

// States
abstract class PropertyDetailsState extends Equatable {
  const PropertyDetailsState();

  @override
  List<Object?> get props => [];
}

class PropertyDetailsInitial extends PropertyDetailsState {}

class PropertyDetailsLoading extends PropertyDetailsState {
  final String propertyId;

  const PropertyDetailsLoading(this.propertyId);

  @override
  List<Object> get props => [propertyId];
}

class PropertyDetailsLoaded extends PropertyDetailsState {
  final PropertyDetails propertyDetails;

  const PropertyDetailsLoaded(this.propertyDetails);

  @override
  List<Object> get props => [propertyDetails];
}

class PropertyDetailsError extends PropertyDetailsState {
  final String message;
  final String propertyId;

  const PropertyDetailsError({required this.message, required this.propertyId});

  @override
  List<Object> get props => [message, propertyId];
}

// BLoC
class PropertyDetailsBloc
    extends Bloc<PropertyDetailsEvent, PropertyDetailsState> {
  final PropertyRepository propertyRepository;

  // Cache for loaded property details
  final Map<String, PropertyDetails> _propertyCache = {};

  PropertyDetailsBloc({required this.propertyRepository})
      : super(PropertyDetailsInitial()) {
    on<LoadPropertyDetails>(_onLoadPropertyDetails);
    on<RefreshPropertyDetails>(_onRefreshPropertyDetails);
  }

  Future<void> _onLoadPropertyDetails(
    LoadPropertyDetails event,
    Emitter<PropertyDetailsState> emit,
  ) async {
    // If this property is already loaded, return it from cache
    if (_propertyCache.containsKey(event.propertyId)) {
      emit(PropertyDetailsLoaded(_propertyCache[event.propertyId]!));
      return;
    }

    // Otherwise load it
    emit(PropertyDetailsLoading(event.propertyId));
    try {
      // Avoid using compute/isolate which can cause issues
      final propertyDetails =
          await propertyRepository.getPropertyDetails(event.propertyId);

      // Cache the result
      _propertyCache[event.propertyId] = propertyDetails;

      emit(PropertyDetailsLoaded(propertyDetails));
    } catch (e) {
      debugPrint('Error loading property details: $e');
      emit(PropertyDetailsError(
          message: 'Failed to load property details: ${e.toString()}',
          propertyId: event.propertyId));
    }
  }

  Future<void> _onRefreshPropertyDetails(
    RefreshPropertyDetails event,
    Emitter<PropertyDetailsState> emit,
  ) async {
    emit(PropertyDetailsLoading(event.propertyId));
    try {
      // Remove from cache to force refresh
      _propertyCache.remove(event.propertyId);

      // Load fresh data
      final propertyDetails =
          await propertyRepository.getPropertyDetails(event.propertyId);

      // Cache the new result
      _propertyCache[event.propertyId] = propertyDetails;

      emit(PropertyDetailsLoaded(propertyDetails));
    } catch (e) {
      debugPrint('Error refreshing property details: $e');
      emit(PropertyDetailsError(
          message: 'Failed to refresh property details: ${e.toString()}',
          propertyId: event.propertyId));
    }
  }
}
