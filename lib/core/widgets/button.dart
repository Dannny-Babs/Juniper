import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:juniper/core/utils/colors.dart';
import 'package:juniper/core/utils/packages.dart';

enum ButtonVariant { primary, secondary, outline, error, success }

enum ButtonSize { small, medium, large }

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final ButtonSize size;
  final bool isLoading;
  final bool isDisabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final bool enableHaptics;
  final Duration animationDuration;
  final BorderRadius? borderRadius;
  final Color? textColor;
  final Color? backgroundColor;
  final bool noShadow;
  

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
    this.isLoading = false,
    this.isDisabled = false,
    this.prefixIcon,
    this.suffixIcon,
    this.width,
    this.height,
    this.padding,
    this.enableHaptics = true,
    this.animationDuration = const Duration(milliseconds: 200),
    this.borderRadius,
    this.textColor,
    this.backgroundColor,
    this.noShadow = false
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (!widget.isDisabled && !widget.isLoading) {
      if (widget.enableHaptics) {
        HapticFeedback.lightImpact();
      }
      _controller.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (!widget.isDisabled && !widget.isLoading) {
      _controller.reverse();
    }
  }

  void _handleTapCancel() {
    if (!widget.isDisabled && !widget.isLoading) {
      _controller.reverse();
    }
  }

  Size _getButtonSize() {
    switch (widget.size) {
      case ButtonSize.small:
        return Size(widget.width ?? double.infinity, widget.height ?? 40);
      case ButtonSize.medium:
        return Size(widget.width ?? double.infinity, widget.height ?? 52);
      case ButtonSize.large:
        return Size(widget.width ?? double.infinity, widget.height ?? 64);
    }
  }

  TextStyle _getTextStyle(BuildContext context) {
    final baseStyle = Theme.of(context).textTheme.bodyMedium!;
    switch (widget.size) {
      case ButtonSize.small:
        return baseStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w500);
      case ButtonSize.medium:
        return baseStyle.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: -0.1,
        );
      case ButtonSize.large:
        return baseStyle.copyWith(fontSize: 18.sp, fontWeight: FontWeight.w500);
    }
  }

  Color _getBackgroundColor(BuildContext context) {
    if (widget.backgroundColor != null) {
      return widget.backgroundColor!;
    }

    final theme = Theme.of(context);
    if (widget.isDisabled) {
      return theme.colorScheme.surface.withAlpha(102);
    }

    switch (widget.variant) {
      case ButtonVariant.primary:
        return _isHovered
            ? theme.colorScheme.primary.withAlpha((0.9 * 255).round())
            : theme.colorScheme.primary;
      case ButtonVariant.secondary:
        return _isHovered
            ? theme.colorScheme.secondaryContainer
                .withAlpha((0.9 * 255).round())
            : theme.colorScheme.secondaryContainer;
      case ButtonVariant.outline:
        return _isHovered
            ? theme.colorScheme.surface.withAlpha((0.1 * 255).round())
            : Colors.transparent;
      case ButtonVariant.error:
        return _isHovered
            ? theme.colorScheme.error.withAlpha((0.9 * 255).round())
            : theme.colorScheme.error;
      case ButtonVariant.success:
        return _isHovered
            ? Colors.green.withAlpha((0.9 * 255).round())
            : Colors.green;
    }
  }

  Color _getTextColor(BuildContext context) {
    if (widget.textColor != null) {
      return widget.textColor!;
    }

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (widget.isDisabled) {
      return theme.colorScheme.onSurface.withAlpha(102);
    }

    switch (widget.variant) {
      case ButtonVariant.primary:
        return theme.colorScheme.onPrimary;
      case ButtonVariant.secondary:
        return theme.colorScheme.onSecondaryContainer;
      case ButtonVariant.outline:
        return isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
      case ButtonVariant.error:
        return theme.colorScheme.onError;
      case ButtonVariant.success:
        return Colors.white;
    }
  }

  Border _borderstyle(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return widget.variant == ButtonVariant.outline
        ? Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight)
        : const Border();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final buttonSize = _getButtonSize();

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: GestureDetector(
          onTapDown: _handleTapDown,
          onTapUp: _handleTapUp,
          onTapCancel: _handleTapCancel,
          child: Container(
            width: buttonSize.width,
            height: buttonSize.height,

            decoration: BoxDecoration(
              color: _getBackgroundColor(context),
              borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
              border: _borderstyle(context),
              boxShadow: widget.isDisabled || widget.isLoading || widget.noShadow
                  ? []
                  : [
                      BoxShadow(
                        color: theme.shadowColor.withAlpha((0.2 * 255).round()),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
            ),
            child: MaterialButton(
              onPressed: widget.isDisabled || widget.isLoading
                  ? null
                  : widget.onPressed,
              shape: RoundedRectangleBorder(
                borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
              ),
              padding: widget.padding ??
                  EdgeInsets.symmetric(
                    horizontal: widget.size == ButtonSize.small ? 16 : 24,
                  ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.prefixIcon != null) ...[
                    widget.prefixIcon!,
                    SizedBox(width: 8)
                  ],
                  if (widget.isLoading)
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          _getTextColor(context),
                        ),
                      ),
                    )
                  else
                    Text(
                      widget.text,
                      style: _getTextStyle(context).copyWith(
                        color: _getTextColor(context),
                      ),
                    ),
                  if (widget.suffixIcon != null) ...[
                    SizedBox(width: 8),
                    widget.suffixIcon!
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
