import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/property_details.dart';
import '../../domain/repositories/property_repository.dart';

// Events
abstract class PropertyDetailsEvent extends Equatable {
  const PropertyDetailsEvent();

  @override
  List<Object> get props => [];
}

class LoadPropertyDetails extends PropertyDetailsEvent {
  final String propertyId;

  const LoadPropertyDetails(this.propertyId);

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

class PropertyDetailsLoading extends PropertyDetailsState {}

class PropertyDetailsLoaded extends PropertyDetailsState {
  final PropertyDetails property;

  const PropertyDetailsLoaded(this.property);

  @override
  List<Object?> get props => [property];
}

class PropertyDetailsError extends PropertyDetailsState {
  final String message;

  const PropertyDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}

// Bloc
class PropertyDetailsBloc extends Bloc<PropertyDetailsEvent, PropertyDetailsState> {
  final PropertyRepository propertyRepository;

  PropertyDetailsBloc({required this.propertyRepository})
      : super(PropertyDetailsInitial()) {
    on<LoadPropertyDetails>(_onLoadPropertyDetails);
  }

  Future<void> _onLoadPropertyDetails(
    LoadPropertyDetails event,
    Emitter<PropertyDetailsState> emit,
  ) async {
    emit(PropertyDetailsLoading());
    try {
      final property = await propertyRepository.getPropertyDetails(event.propertyId);
      emit(PropertyDetailsLoaded(property));
    } catch (e) {
      emit(PropertyDetailsError(e.toString()));
    }
  }
} 