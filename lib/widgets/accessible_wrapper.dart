import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

/// A wrapper widget that adds TTS accessibility to any child widget
///
/// Features:
/// - Single tap: Plays audio description
/// - Double tap: Executes the provided action (optional)
/// - Can wrap any widget to make it accessible
/// - Customizable TTS settings
///
/// Example:
/// ```dart
/// AccessibleWrapper(
///   audioDescription: '학습 시작 버튼입니다',
///   onDoubleTap: () => Navigator.push(...),
///   child: YourCustomWidget(),
/// )
/// ```
class AccessibleWrapper extends StatefulWidget {
  /// The child widget to wrap with accessibility features
  final Widget child;

  /// Audio description to play on single tap
  final String audioDescription;

  /// Optional callback for double tap action
  final VoidCallback? onDoubleTap;

  /// Optional callback for single tap (called after TTS starts)
  final VoidCallback? onTap;

  /// TTS language (defaults to 'ko-KR')
  final String? language;

  /// TTS speech rate (defaults to 0.5)
  final double? speechRate;

  /// TTS pitch (defaults to 1.0)
  final double? pitch;

  /// TTS volume (defaults to 1.0)
  final double? volume;

  /// Whether the wrapper is enabled (defaults to true)
  final bool enabled;

  /// Whether to show a visual indicator when speaking (defaults to true)
  final bool showSpeakingIndicator;

  /// Position of the speaking indicator
  final Alignment? indicatorAlignment;

  /// Custom speaking indicator widget
  final Widget? customIndicator;

  const AccessibleWrapper({
    super.key,
    required this.child,
    required this.audioDescription,
    this.onDoubleTap,
    this.onTap,
    this.language,
    this.speechRate,
    this.pitch,
    this.volume,
    this.enabled = true,
    this.showSpeakingIndicator = false,
    this.indicatorAlignment,
    this.customIndicator,
  });

  @override
  State<AccessibleWrapper> createState() => _AccessibleWrapperState();
}

class _AccessibleWrapperState extends State<AccessibleWrapper> {
  final FlutterTts _tts = FlutterTts();
  bool _isSpeaking = false;

  @override
  void initState() {
    super.initState();
    _initializeTts();
  }

  Future<void> _initializeTts() async {
    try {
      await _tts.setLanguage(widget.language ?? 'ko-KR');
      await _tts.setSpeechRate(widget.speechRate ?? 0.5);
      await _tts.setPitch(widget.pitch ?? 1.0);
      await _tts.setVolume(widget.volume ?? 1.0);
    } catch (e) {
      debugPrint('TTS initialization error: $e');
    }
  }

  Future<void> _speakDescription() async {
    if (_isSpeaking || !widget.enabled) return;

    setState(() => _isSpeaking = true);

    try {
      await _tts.stop();
      await _tts.speak(widget.audioDescription);

      // Call onTap callback if provided
      widget.onTap?.call();
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
    widget.onDoubleTap?.call();
  }

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = widget.child;

    // Add speaking indicator if enabled
    if (widget.showSpeakingIndicator && _isSpeaking) {
      final indicator = widget.customIndicator ??
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.volume_up,
                  color: Colors.white,
                  size: 20,
                ),
              ],
            ),
          );

      content = Stack(
        children: [
          widget.child,
          Positioned.fill(
            child: Align(
              alignment: widget.indicatorAlignment ?? Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: indicator,
              ),
            ),
          ),
        ],
      );
    }

    return GestureDetector(
      onTap: _handleTap,
      onDoubleTap: widget.onDoubleTap != null ? _handleDoubleTap : null,
      behavior: HitTestBehavior.opaque,
      child: content,
    );
  }
}
