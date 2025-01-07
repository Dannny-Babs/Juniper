import 'package:flutter/material.dart';
import 'package:juniper/core/utils/utils.dart';

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
    if (_currentStage == ProfileSetupStage.finalTouches) {
      // Handle completion
      context.go('/home');
      return;
    }

    setState(() {
      _currentStage = ProfileSetupStage
          .values[ProfileSetupStage.values.indexOf(_currentStage) + 1];
    });
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
