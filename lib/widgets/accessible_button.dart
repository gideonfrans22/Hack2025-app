import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

/// Accessible button widget with TTS soundover and double-tap functionality
///
/// Features:
/// - Single tap: Plays audio description of button action
/// - Double tap: Executes the button action
/// - Large default size for better accessibility
/// - Customizable appearance and behavior
class AccessibleButton extends StatefulWidget {
  /// Text displayed on the button
  final String label;

  /// Audio description played on single tap (if null, uses label)
  final String? audioDescription;

  /// Function to execute on double tap
  final VoidCallback onDoubleTap;

  /// Button background color
  final Color? backgroundColor;

  /// Text color
  final Color? textColor;

  /// Button width (defaults to 300)
  final double? width;

  /// Button height (defaults to 90)
  final double? height;

  /// Text size (defaults to 24)
  final double? fontSize;

  /// Border radius (defaults to 15)
  final double? borderRadius;

  /// Icon to display before text (optional)
  final IconData? icon;

  /// Icon size (defaults to 32)
  final double? iconSize;

  /// Whether the button is enabled
  final bool enabled;

  /// Custom padding
  final EdgeInsets? padding;

  const AccessibleButton({
    super.key,
    required this.label,
    required this.onDoubleTap,
    this.audioDescription,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.fontSize,
    this.borderRadius,
    this.icon,
    this.iconSize,
    this.enabled = true,
    this.padding,
  });

  @override
  State<AccessibleButton> createState() => _AccessibleButtonState();
}

class _AccessibleButtonState extends State<AccessibleButton> {
  final FlutterTts _tts = FlutterTts();
  bool _isSpeaking = false;

  @override
  void initState() {
    super.initState();
    _initializeTts();
  }

  Future<void> _initializeTts() async {
    try {
      await _tts.setLanguage('ko-KR');
      await _tts.setSpeechRate(0.5);
      await _tts.setPitch(1.0);
      await _tts.setVolume(1.0);
    } catch (e) {
      debugPrint('TTS initialization error: $e');
    }
  }

  Future<void> _speakDescription() async {
    if (_isSpeaking || !widget.enabled) return;

    setState(() => _isSpeaking = true);

    try {
      await _tts.stop();
      final description = widget.audioDescription ?? widget.label;
      await _tts.speak(description);
    } catch (e) {
      debugPrint('TTS speak error: $e');
    } finally {
      // Reset speaking state after a delay
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() => _isSpeaking = false);
        }
      });
    }
  }

  void _handleTap() {
    if (!widget.enabled) return;
    _speakDescription();
  }

  void _handleDoubleTap() {
    if (!widget.enabled) return;
    _tts.stop(); // Stop any playing audio
    widget.onDoubleTap();
  }

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultBackgroundColor =
        widget.backgroundColor ?? const Color(0xFF75B7B3);
    final defaultTextColor = widget.textColor ?? Colors.black;
    final effectiveWidth = widget.width ?? 300.0;
    final effectiveHeight = widget.height ?? 90.0;
    final effectiveFontSize = widget.fontSize ?? 24.0;
    final effectiveBorderRadius = widget.borderRadius ?? 15.0;
    final effectiveIconSize = widget.iconSize ?? 32.0;

    return GestureDetector(
      onTap: _handleTap,
      onDoubleTap: _handleDoubleTap,
      child: Container(
        width: effectiveWidth,
        height: effectiveHeight,
        padding: widget.padding ??
            const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
        decoration: BoxDecoration(
          color: widget.enabled
              ? defaultBackgroundColor
              : defaultBackgroundColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(effectiveBorderRadius),
          boxShadow: widget.enabled
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.icon != null) ...[
              Icon(
                widget.icon,
                size: effectiveIconSize,
                color: defaultTextColor,
              ),
              const SizedBox(width: 12),
            ],
            Flexible(
              child: Text(
                widget.label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: defaultTextColor,
                  fontSize: effectiveFontSize,
                  fontWeight: FontWeight.w700,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            if (_isSpeaking) ...[
              const SizedBox(width: 12),
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(defaultTextColor),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
