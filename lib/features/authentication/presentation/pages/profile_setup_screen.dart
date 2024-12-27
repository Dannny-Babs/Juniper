import 'package:flutter/material.dart';

import '../widgets/preferences_setup.dart';
import '../widgets/profile_setup.dart';
import '../widgets/profile_stepper.dart';

class ProfileSetupPage extends StatefulWidget {
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
      default:
        return const SizedBox();
    }
  }

  void _handleNext() {
    if (_currentStage == ProfileSetupStage.finalTouches) {
      // Handle completion
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
