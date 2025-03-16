
// States
import '../../../../core/utils/utils.dart';
import '../../data/models/property_details.dart';

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
