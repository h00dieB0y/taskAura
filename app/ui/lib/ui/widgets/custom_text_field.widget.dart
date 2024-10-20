import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFieldWidget extends StatelessWidget {
  const CustomTextFieldWidget({
    super.key,
    required this.labelText,
    this.hintText,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false, // Parent controls the obscureText state
    this.errorText,
    this.keyboardType,
    this.textInputAction,
    this.onFieldSubmitted,
    this.autovalidateMode,
    this.focusNode,
    this.helperText,
    this.textStyle,
    this.inputFormatters,
    this.onSuffixIconTap, // Custom action on tapping the suffix icon
    this.enabled = true, // New parameter for controlling the disabled state
    this.errorStyle, // Style for the error text
    this.helperStyle, // Style for the helper text
  });

  final String labelText;
  final String? hintText;
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool obscureText; // Parent manages this now
  final String? errorText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final AutovalidateMode? autovalidateMode;
  final FocusNode? focusNode;
  final String? helperText;
  final TextStyle? textStyle;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onFieldSubmitted;
  final VoidCallback? onSuffixIconTap; // Custom action for suffix icon
  final bool enabled; // Flag to control whether the field is enabled
  final TextStyle? errorStyle; // New field for custom error text style
  final TextStyle? helperStyle; // New field for custom helper text style

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText, // Use the parent's obscureText state
      focusNode: focusNode,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      autovalidateMode: autovalidateMode,
      onFieldSubmitted: onFieldSubmitted,
      inputFormatters: inputFormatters,
      enabled: enabled,
      style: textStyle ??
          TextStyle(color: Theme.of(context).colorScheme.onSurface),
      decoration: _buildInputDecoration(context),
      cursorColor: Theme.of(context).colorScheme.primary,
    );
  }

  InputDecoration _buildInputDecoration(BuildContext context) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
      hintText: hintText,
      hintStyle:
          TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
      enabledBorder: _buildInputBorder(Theme.of(context).colorScheme.outline),
      focusedBorder: _buildInputBorder(Theme.of(context).colorScheme.primary),
      errorBorder: _buildInputBorder(Theme.of(context).colorScheme.error),
      disabledBorder: _buildInputBorder(
          Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
      fillColor: Theme.of(context).colorScheme.surface,
      filled: true,
      prefixIcon: _buildPrefixIcon(context),
      suffixIcon: _buildSuffixIcon(context),
      errorText: errorText,
      errorStyle: errorStyle,
      helperText: helperText,
      helperStyle: helperStyle,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
    );
  }

  OutlineInputBorder _buildInputBorder(Color borderColor) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: BorderSide(color: borderColor),
    );
  }

  Widget? _buildPrefixIcon(BuildContext context) {
    if (prefixIcon == null) return null;
    return Icon(prefixIcon, color: Theme.of(context).colorScheme.primary);
  }

  Widget? _buildSuffixIcon(BuildContext context) {
    if (suffixIcon == null) return null;
    return IconButton(
      icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility,
          color: Theme.of(context).colorScheme.primary),
      onPressed: onSuffixIconTap, // Action passed from parent
    );
  }
}
