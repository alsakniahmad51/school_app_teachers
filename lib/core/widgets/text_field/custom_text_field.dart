import 'package:flutter/material.dart';
import 'package:teachers_app/core/widgets/text_field/field_validators.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CustomTextField extends StatefulWidget {
  final FieldType fieldType;
  final String? label;
  final String? hint;
  final double radius;
  final Widget? prefix;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? contentPadding;
  final bool obscureOverride;
  final FocusNode? focusNode;
  final String? Function(String?)? customValidator;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;
  final bool? enabled;
  final dynamic extraValidationData;

  // Colors can be configured here or overridden when creating the widget.
  final Color primaryColor;
  final Color secondaryBorderColor;
  final Color disabledBorderColor;
  final Color negativeColor;
  final Color iconColor;
  const CustomTextField({
    super.key,
    required this.fieldType,
    this.label,
    this.hint,
    required this.radius,
    this.prefix,
    this.suffix,
    required this.controller,
    this.width,
    this.height,
    this.contentPadding,
    this.obscureOverride = false,
    this.keyboardType,
    this.focusNode,
    this.customValidator,
    this.onFieldSubmitted,
    this.onChanged,
    this.enabled,
    this.extraValidationData,
    this.primaryColor = Colors.blue,
    this.secondaryBorderColor = Colors.grey,
    this.disabledBorderColor = Colors.grey,
    this.negativeColor = Colors.red,
    this.iconColor = Colors.black87,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText =
        widget.fieldType == FieldType.password || widget.obscureOverride;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: TextFormField(
        enabled: widget.enabled,
        onChanged: widget.onChanged,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        // onChanged: widget.onChanged,
        onFieldSubmitted: widget.onFieldSubmitted,
        focusNode: widget.focusNode,
        expands: false,
        textAlign:
            widget.fieldType == FieldType.phoneNumber ||
                widget.fieldType == FieldType.email ||
                widget.fieldType == FieldType.activationCode
            ? TextAlign.left
            : TextAlign.right,
        textDirection:
            widget.fieldType == FieldType.phoneNumber ||
                widget.fieldType == FieldType.email ||
                widget.fieldType == FieldType.activationCode
            ? TextDirection.ltr
            : TextDirection.rtl,
        keyboardType: widget.keyboardType,
        cursorColor: widget.primaryColor,
        controller: widget.controller,
        validator:
            widget.customValidator ??
            (value) => validateField(
              widget.fieldType,
              value,
              widget.extraValidationData,
            ),
        obscureText: widget.fieldType == FieldType.password
            ? _obscureText
            : widget.obscureOverride,
        // style: styles.xLabelLarge,
        decoration: InputDecoration(
          errorMaxLines: 2,
          // isDense: false,
          helperText: '',

          // helperStyle: context.xParagraphSmall,
          errorStyle: TextStyle(fontSize: 10),

          //  context.xParagraphSmall
          //     .copyWith(color: widget.negativeColor, fontSize: 10),
          contentPadding:
              widget.contentPadding ??
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          labelText: widget.label,
          labelStyle: TextStyle(fontSize: 10),
          //  styles.xLabelSmall.copyWith(fontSize: 10),
          hintText: widget.hint,
          hintTextDirection: TextDirection.rtl,
          // hintStyle: styles.xParagraphLargeNormal,
          prefixIcon: widget.prefix,

          suffixIcon: widget.enabled == false
              ? null
              : widget.fieldType == FieldType.password
              ? IconButton(
                  icon: Icon(
                    _obscureText
                        ? PhosphorIcons.eyeSlash()
                        : PhosphorIcons.eye(),
                    color: widget.iconColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : widget.suffix,
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius),
            borderSide: BorderSide(
              color: widget.enabled == false
                  ? widget.disabledBorderColor
                  : widget.secondaryBorderColor,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius),
            borderSide: BorderSide(color: widget.primaryColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius),
            borderSide: BorderSide(color: widget.negativeColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius),
            borderSide: BorderSide(
              color: widget.enabled == false
                  ? widget.disabledBorderColor
                  : widget.secondaryBorderColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius),
            borderSide: BorderSide(color: widget.primaryColor, width: 2),
          ),
        ),
      ),
    );
  }
}
