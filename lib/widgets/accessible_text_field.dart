import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

/// Accessible text field widget with TTS feedback and double-tap to focus
///
/// Features:
/// - Single tap: Reads description of what the field is for
/// - Double tap: Focuses the field for input
/// - Supports native screen readers (TalkBack/VoiceOver) for reading input
/// - Customizable appearance matching the app design
class AccessibleTextField extends StatefulWidget {
  /// Controller for the text field
  final TextEditingController controller;

  /// Label text shown above the field
  final String labelText;

  /// Audio description played on single tap
  final String audioDescription;

  /// Hint text shown inside the field
  final String? hintText;

  /// Validator function for form validation
  final String? Function(String?)? validator;

  /// Whether the field is for password input
  final bool obscureText;

  /// Keyboard type
  final TextInputType? keyboardType;

  /// Suffix icon widget (e.g., visibility toggle)
  final Widget? suffixIcon;

  /// Whether the field can be toggled (for password visibility)
  final bool canToggleVisibility;

  /// Callback when visibility is toggled
  final VoidCallback? onToggleVisibility;

  const AccessibleTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.audioDescription,
    this.hintText,
    this.validator,
    this.obscureText = false,
    this.keyboardType,
    this.suffixIcon,
    this.canToggleVisibility = false,
    this.onToggleVisibility,
  });

  @override
  State<AccessibleTextField> createState() => _AccessibleTextFieldState();
}

class _AccessibleTextFieldState extends State<AccessibleTextField> {
  final FlutterTts _tts = FlutterTts();
  late FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _initTts();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  Future<void> _initTts() async {
    await _tts.setLanguage('ko-KR');
    await _tts.setSpeechRate(0.5);
    await _tts.setVolume(1.0);
    await _tts.setPitch(1.0);
  }

  @override
  void dispose() {
    _tts.stop();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _handleTap() async {
    // Single tap: Read description
    await _tts.speak(widget.audioDescription);
  }

  Future<void> _handleDoubleTap() async {
    // Double tap: Focus the field
    _focusNode.requestFocus();
    await _tts.speak('입력 시작');
  }

  void _onFocusChange() async {
    if (_focusNode.hasFocus) {
      await _tts.speak(widget.audioDescription);
      // Perform actions when focused
    } else {
      await _tts.stop();
      // Perform actions when unfocused
    }
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.audioDescription,
      hint: '두 번 탭하여 입력하세요',
      textField: true,
      child: GestureDetector(
        onTap: _handleTap,
        onDoubleTap: _handleDoubleTap,
        child: TextFormField(
          controller: widget.controller,
          focusNode: _focusNode,
          obscureText: widget.obscureText,
          keyboardType: widget.keyboardType,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
          decoration: InputDecoration(
            labelText: widget.labelText,
            labelStyle: TextStyle(
              color: Colors.grey[400],
              fontSize: 18,
            ),
            hintText: widget.hintText,
            hintStyle: TextStyle(color: Colors.grey[600]),
            filled: true,
            fillColor: Colors.grey[900],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[800]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFF75B7B3),
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            suffixIcon: widget.suffixIcon,
          ),
          validator: (value) {
            if (widget.validator == null) {
              return null;
            }
            final result = widget.validator!(value);
            if (result != null) {
              _tts.speak(result);
            }
            return result;
          },
        ),
      ),
    );
  }
}
