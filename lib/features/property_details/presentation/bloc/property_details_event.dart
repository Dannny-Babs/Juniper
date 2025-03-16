import '../../../../core/utils/utils.dart';

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
