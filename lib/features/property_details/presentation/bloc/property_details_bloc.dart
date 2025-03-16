import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/property_repository.dart';
import 'property_details_event.dart';
import 'property_details_state.dart';

// Events

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