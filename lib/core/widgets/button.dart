import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum ButtonVariant {
  primary,
  secondary,
  outline,
  error,
  success
}

enum ButtonSize {
  small,
  medium,
  large
}

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
  final TextStyle? textStyle;

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
    this.animationDuration = const Duration(milliseconds: 150),
    this.borderRadius,
    this.textColor,
    this.backgroundColor,
    this.textStyle,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _shadowAnimation;
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
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      ),
    );

    _shadowAnimation = Tween<double>(
      begin: 1.0,
      end: 0.3,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );
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
    if (widget.textStyle != null) {
      return widget.textStyle!;
    }

    final theme = Theme.of(context);
    final baseStyle = theme.textTheme.bodyMedium!;
    
    switch (widget.size) {
      case ButtonSize.small:
        return baseStyle.copyWith(fontSize: 14);
      case ButtonSize.medium:
        return baseStyle.copyWith(fontSize: 16, fontWeight: FontWeight.normal, letterSpacing: -0.3);
      case ButtonSize.large:
        return baseStyle.copyWith(fontSize: 18);
    }
  }

  Color _getBackgroundColor(BuildContext context) {
    if (widget.backgroundColor != null) {
      return widget.backgroundColor!;
    }

    final theme = Theme.of(context);
    if (widget.isDisabled) {
      return theme.colorScheme.surface.withOpacity(0.12);
    }

    switch (widget.variant) {
      case ButtonVariant.primary:
        return _isHovered 
            ? theme.colorScheme.primary.withOpacity(0.9)
            : theme.colorScheme.primary;
      case ButtonVariant.secondary:
        return _isHovered 
            ? theme.colorScheme.secondaryContainer.withOpacity(0.9)
            : theme.colorScheme.secondaryContainer;
      case ButtonVariant.outline:
        return _isHovered 
            ? theme.colorScheme.surface.withOpacity(0.1)
            : Colors.transparent;
      case ButtonVariant.error:
        return _isHovered 
            ? theme.colorScheme.error.withOpacity(0.9)
            : theme.colorScheme.error;
      case ButtonVariant.success:
        return _isHovered 
            ? Colors.green.withOpacity(0.9)
            : Colors.green;
    }
  }

  Color _getTextColor(BuildContext context) {
    if (widget.textColor != null) {
      return widget.textColor!;
    }

    final theme = Theme.of(context);
    if (widget.isDisabled) {
      return theme.colorScheme.onSurface.withOpacity(0.38);
    }

    switch (widget.variant) {
      case ButtonVariant.primary:
        return theme.colorScheme.onPrimary;
      case ButtonVariant.secondary:
        return theme.colorScheme.onSecondaryContainer;
      case ButtonVariant.outline:
        return theme.colorScheme.primary;
      case ButtonVariant.error:
        return theme.colorScheme.onError;
      case ButtonVariant.success:
        return Colors.white;
    }
  }

  Border? _getBorder(BuildContext context) {
    final theme = Theme.of(context);
    if (widget.variant == ButtonVariant.outline) {
      return Border.all(
        color: widget.isDisabled 
            ? theme.colorScheme.outline.withOpacity(0.12)
            : theme.colorScheme.primary,
        width: 1.5,
      );
    }
    return null;
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
        child: AnimatedBuilder(
          animation: _shadowAnimation,
          builder: (context, child) {
            return GestureDetector(
              onTapDown: _handleTapDown,
              onTapUp: _handleTapUp,
              onTapCancel: _handleTapCancel,
              child: Container(
                width: buttonSize.width,
                height: buttonSize.height,
                decoration: BoxDecoration(
                  color: _getBackgroundColor(context),
                  borderRadius: widget.borderRadius ?? BorderRadius.circular(48),
                  border: _getBorder(context),
                  boxShadow: widget.isDisabled || widget.isLoading
                      ? []
                      : [
                          BoxShadow(
                            color: theme.shadowColor.withOpacity(0.1 * _shadowAnimation.value),
                            blurRadius: 10 * _shadowAnimation.value,
                            offset: Offset(0, 4 * _shadowAnimation.value),
                          ),
                        ],
                ),
                child: MaterialButton(
                  onPressed: widget.isDisabled || widget.isLoading ? null : widget.onPressed,
                  shape: RoundedRectangleBorder(
                    borderRadius: widget.borderRadius ?? BorderRadius.circular(48),
                  ),
                  padding: widget.padding ?? EdgeInsets.symmetric(
                    horizontal: widget.size == ButtonSize.small ? 16 : 24,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.prefixIcon != null) ...[
                        widget.prefixIcon!,
                        SizedBox(width: widget.size == ButtonSize.small ? 6 : 8),
                      ],
                      if (widget.isLoading)
                        SizedBox(
                          width: widget.size == ButtonSize.small ? 16 : 20,
                          height: widget.size == ButtonSize.small ? 16 : 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(_getTextColor(context)),
                          ),
                        )
                      else
                        Text(
                          widget.text,
                          style: _getTextStyle(context).copyWith(
                            color: _getTextColor(context),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      if (widget.suffixIcon != null) ...[
                        SizedBox(width: widget.size == ButtonSize.small ? 6 : 8),
                        widget.suffixIcon!,
                      ],
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}