import 'package:flutter/material.dart';

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
      _currentStage = ProfileSetupStage.values[
        ProfileSetupStage.values.indexOf(_currentStage) + 1
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProfileStepper(
      currentStage: _currentStage,
      child: _getCurrentStep(),
      onNext: _handleNext,
      onBack: _currentStage == ProfileSetupStage.personal
          ? null
          : () => setState(() {
                _currentStage = ProfileSetupStage.values[
                  ProfileSetupStage.values.indexOf(_currentStage) - 1
                ];
              }),
      isLastStep: _currentStage == ProfileSetupStage.finalTouches,
    );
  }
}