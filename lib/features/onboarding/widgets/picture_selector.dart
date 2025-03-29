import 'dart:io';

import 'package:flutter/material.dart';

import '../../../core/utils/utils.dart';

class ProfilePictureSelector extends StatefulWidget {
  final String? initialImage;
  final Function(String) onImageSelected;
  final double size;

  const ProfilePictureSelector({
    super.key,
    this.initialImage,
    required this.onImageSelected,
    this.size = 100,
  });

  @override
  State<ProfilePictureSelector> createState() => _ProfilePictureSelectorState();
}

class _ProfilePictureSelectorState extends State<ProfilePictureSelector> {
  bool _isPickerActive = false;
  String? _selectedImage;

  @override
  void initState() {
    super.initState();
    _selectedImage = widget.initialImage;
  }

  Future<void> _pickImage(ImageSource source) async {
    if (_isPickerActive) {
      _showMessage('Please wait for the current operation to complete');
      return;
    }

    try {
      setState(() => _isPickerActive = true);

      final image = await ImagePicker().pickImage(
        source: source,
        imageQuality: 80, // Added image compression
        maxWidth: 1000, // Limit image dimensions
        maxHeight: 1000,
      );

      if (image != null) {
        setState(() => _selectedImage = image.path);
        widget.onImageSelected(image.path);
      }
    } catch (e) {
      _showMessage('Failed to pick image: ${e.toString()}');
    } finally {
      if (mounted) {
        setState(() => _isPickerActive = false);
      }
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _showImageSourceSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ImageSourceOption(
              icon: Icons.photo_library,
              title: 'Choose from Gallery',
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            _ImageSourceOption(
              icon: Icons.camera_alt,
              title: 'Take a Photo',
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = widget.size.sp;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: _showImageSourceSheet,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isDark ? Colors.grey[800] : Colors.grey[200],
                    image: _selectedImage != null
                        ? DecorationImage(
                            image: FileImage(File(_selectedImage!)),
                            fit: BoxFit.cover,
                          )
                        : null,
                    border: Border.all(
                      color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
                      width: 2,
                    ),
                  ),
                  child: _selectedImage == null
                      ? Icon(
                          Icons.add_a_photo,
                          size: size * 0.32,
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                        )
                      : null,
                ),
                if (_isPickerActive)
                  Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withAlpha((0.5 * 255).round()),
                    ),
                    child: const CircularProgressIndicator(),
                  ),
              ],
            ),
          ),
          SizedBox(height: 8.sp),
          Text(
            'Add Profile Picture',
            style: TextStyle(
              fontSize: 14.sp,
              color: isDark ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

// Extracted widget for image source options
class _ImageSourceOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ImageSourceOption({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}
