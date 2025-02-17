import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:juniper/core/utils/utils.dart';

import '../../navigation/presentation/bloc/navigation_bloc.dart';
import 'final_setup.dart';
import 'third_setup.dart';
import 'second_setup.dart';
import 'first_setup.dart';
import '../widgets/profile_stepper.dart';

class ProfileSetupPage extends StatefulWidget {
  const ProfileSetupPage({super.key});

  @override
  State<ProfileSetupPage> createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends State<ProfileSetupPage> {
  ProfileSetupStage _currentStage = ProfileSetupStage.personal;
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  DateTime? _dateOfBirth;
  List<String> _selectedHousingTypes = [
    'Apartment',
  ];
  double? _budget;
  List<String> _selectedLocations = [
    'Toronto',
    'Vancouver',
    'Calgary',
    'Montreal',
  ];
  List<String> _selectedAmenities = [];
  List<String> _selectedCommunityFeatures = [];
  String? _furnishingPreference;
  String? _otherRequirements;
  String _moveInTimeline = "Within 1 month"; // Default value
  String? _profilePictureUrl;
  String? _additionalPreferences;

  Widget _getCurrentStep() {
    switch (_currentStage) {
      case ProfileSetupStage.personal:
        return PersonalInfoStep(
          firstNameController: _firstNameController,
          lastNameController: _lastNameController,
          dateOfBirth: _dateOfBirth,
          onDateSelected: (date) => setState(() => _dateOfBirth = date),
        );
      // Add other cases for remaining steps
      case ProfileSetupStage.preferences:
        return PreferencesStep(
          selectedHousingTypes: _selectedHousingTypes,
          budget: _budget,
          selectedLocations: _selectedLocations,
          onHousingTypesChanged: (types) => setState(() {
            _selectedHousingTypes = types;
          }),
          onBudgetChanged: (value) => setState(() {
            _budget = value;
          }),
          onLocationsChanged: (locations) => setState(() {
            _selectedLocations = locations;
          }),
        );
      case ProfileSetupStage.lifestyle:
        return LifestyleStep(
          selectedAmenities: _selectedAmenities,
          selectedCommunityFeatures: _selectedCommunityFeatures,
          furnishingPreference: _furnishingPreference,
          otherRequirements: _otherRequirements,
          onAmenitiesChanged: (amenities) => setState(() {
            _selectedAmenities = amenities;
          }),
          onCommunityFeaturesChanged: (features) => setState(() {
            _selectedCommunityFeatures = features;
          }),
          onFurnishingChanged: (preference) => setState(() {
            _furnishingPreference = preference;
          }),
          onRequirementsChanged: (requirements) => setState(() {
            _otherRequirements = requirements;
          }),
        );
      case ProfileSetupStage.finalTouches:
        return FinalTouchesStep(
          profilePictureUrl: _profilePictureUrl,
          additionalPreferences: _additionalPreferences,
          moveInTimeline: _moveInTimeline,
          onProfilePictureChanged: (url) => setState(() {
            _profilePictureUrl = url;
          }),
          onAdditionalPreferencesChanged: (prefs) => setState(() {
            _additionalPreferences = prefs;
          }),
          onMoveInTimelineChanged: (timeline) => setState(() {
            _moveInTimeline = timeline;
          }),
        );
    }
  }

  void _handleNext() {
    if (!_validateCurrentStep()) return;

    if (_currentStage == ProfileSetupStage.finalTouches) {
      _completeProfileSetup();
      return;
    }

    setState(() {
      _currentStage = ProfileSetupStage
          .values[ProfileSetupStage.values.indexOf(_currentStage) + 1];
    });
  }

  bool _validateCurrentStep() {
    switch (_currentStage) {
      case ProfileSetupStage.personal:
        return _firstNameController.text.isNotEmpty &&
            _lastNameController.text.isNotEmpty;
      case ProfileSetupStage.preferences:
        return _selectedHousingTypes.isNotEmpty &&
            _selectedLocations.isNotEmpty;
      case ProfileSetupStage.lifestyle:
        return true; // Optional step
      case ProfileSetupStage.finalTouches:
        return _moveInTimeline.isNotEmpty;
    }
  }

  void _completeProfileSetup() {
    final navigationBloc = context.read<NavigationBloc>();

    // Save profile data
    final profileData = {
      'firstName': _firstNameController.text,
      'lastName': _lastNameController.text,
      'dateOfBirth': _dateOfBirth?.toIso8601String(),
      'housingTypes': _selectedHousingTypes,
      'budget': _budget,
      'locations': _selectedLocations,
      'amenities': _selectedAmenities,
      'communityFeatures': _selectedCommunityFeatures,
      'furnishingPreference': _furnishingPreference,
      'otherRequirements': _otherRequirements,
      'moveInTimeline': _moveInTimeline,
      'profilePictureUrl': _profilePictureUrl,
      'additionalPreferences': _additionalPreferences,
    };

    // Update navigation state
    navigationBloc.add(ProfileSetupCompleted());

    // Navigate to home
    context.go('/home');

    if (kDebugMode) {
      print(profileData);
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProfileStepper(
      currentStage: _currentStage,
      onNext: _handleNext,
      onBack: _currentStage == ProfileSetupStage.personal
          ? null
          : () => setState(() {
                _currentStage = ProfileSetupStage.values[
                    ProfileSetupStage.values.indexOf(_currentStage) - 1];
              }),
      isLastStep: _currentStage == ProfileSetupStage.finalTouches,
      child: _getCurrentStep(),
    );
  }
}
