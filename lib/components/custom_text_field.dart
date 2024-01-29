import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

@immutable
final class CustomTextFormField extends HookWidget {
  const CustomTextFormField({
    super.key,
    this.controller,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.onChanged,
    this.textAlignVertical = TextAlignVertical.center,
    this.textAlign = TextAlign.start,
    this.obscureText = false,
    this.onSuffixTap,
    this.suffix,
    this.prefix,
    this.textInputAction,
    this.readOnly = false,
    this.validator,
  });

  final String? hintText;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final Widget? suffix;
  final Widget? prefix;
  final bool obscureText;
  final VoidCallback? onSuffixTap;
  final TextAlign textAlign;
  final TextAlignVertical textAlignVertical;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final bool readOnly;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    final focusNode = useFocusNode();
    final tController = controller ?? useTextEditingController();

    return TextFormField(
      readOnly: readOnly,
      validator: validator,
      focusNode: focusNode,
      controller: tController,
      onTap: focusNode.requestFocus,
      onTapOutside: (_) => focusNode.unfocus(),
      onChanged: onChanged,
      autocorrect: false,
      textAlign: textAlign,
      textAlignVertical: textAlignVertical,
      inputFormatters: inputFormatters,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      style: const TextStyle(
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        hintText: hintText,
        hintStyle:
            const TextStyle(fontWeight: FontWeight.w400, color: Colors.grey),
        prefixIcon: prefix,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 15, top: 15, bottom: 15),
          child: suffix,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blue),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
