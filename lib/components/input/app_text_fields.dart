import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final bool readOnly;
  final IconData? prefixIcon;
  final Color? prefixIconColor;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChanged;
  final String? hintText;
  final ValueChanged<String>? onSubmit;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool borderOnlyError;
  final Color? borderColor;
  final Color? color;
  final GestureTapCallback? onTap;

  const AppTextField(
      {Key? key,
      this.readOnly = false,
      this.prefixIcon,
      this.prefixIconColor,
      required this.controller,
      this.validator,
      this.onSaved,
      this.onChanged,
      this.hintText,
      this.onSubmit,
      this.fontSize,
      this.fontWeight = FontWeight.w500,
      this.borderOnlyError = false,
      this.borderColor,
      this.color,
      this.onTap})
      : super(key: key);

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool view = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool _determineReadOnly() {
    if (widget.readOnly) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: TextFormField(
          onTap: widget.readOnly ? widget.onTap : () {},
          onFieldSubmitted: widget.onSubmit,
          keyboardAppearance: Theme.of(context).brightness,
          scrollPhysics: const BouncingScrollPhysics(),
          onChanged: widget.onChanged,
          controller: widget.controller,
          readOnly: _determineReadOnly(),
          validator: widget.validator,
          onSaved: widget.onSaved,
          style: Theme.of(context).textTheme.headline6?.copyWith(
              fontSize: widget.fontSize, fontWeight: widget.fontWeight),
          decoration: InputDecoration(
              counterText: "",
              hintText: widget.hintText,
              hintStyle: TextStyle(
                  fontSize: widget.fontSize,
                  fontWeight: widget.fontWeight,
                  color: Theme.of(context).hintColor),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
              filled: true,
              fillColor: widget.color ?? Theme.of(context).backgroundColor,
              prefixIcon: widget.prefixIcon != null
                  ? Icon(
                      widget.prefixIcon,
                      color: widget.prefixIconColor ??
                          Theme.of(context).primaryColor,
                    )
                  : null,
              errorStyle: TextStyle(
                  fontSize: 14.0,
                  fontWeight: widget.fontWeight,
                  height: widget.borderOnlyError ? 0.0 : null),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).errorColor.withOpacity(0.5),
                      width: 1.0),
                  borderRadius: BorderRadius.circular(8.0)),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).errorColor.withOpacity(0.5),
                      width: 1.0),
                  borderRadius: BorderRadius.circular(8.0)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: widget.borderColor ??
                          Theme.of(context).dividerColor.withOpacity(1.0),
                      width: 1.0),
                  borderRadius: BorderRadius.circular(8.0)),
              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: widget.borderColor ??
                          Theme.of(context).dividerColor.withOpacity(1.0),
                      width: 1.0),
                  borderRadius: BorderRadius.circular(8.0)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: widget.borderColor ??
                          Theme.of(context).dividerColor.withOpacity(1.0),
                      width: 1.0),
                  borderRadius: BorderRadius.circular(8.0))),
        ),
      ),
    );
  }
}
