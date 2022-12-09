import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:splitify/navigation-utils/size_utils.dart';

class CustomTextField extends StatelessWidget {
  final bool readOnly;
  final TextEditingController controller;
  final int maxLine;
  final Function(String)? onChanged;
  final TextInputType keyboardType;
  final Color? textColor;
  final double? fontSize;
  final int? maxLength;
  final double? radius;
  final bool enabled;
  final bool isPassword;
  final FocusNode? focusNode;
  final String? hintText;
  final Color? hintTextColor;
  final double? hintFontSize;
  final FontWeight? hintTextWeight;
  final TextAlign? textAlign;
  final TextAlignVertical? textAlignVertical;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? fillColor;
  final Offset? offset;
  final double? spreadRadius;
  final VoidCallback? onTap;
  final Color? enableColor;
  final Color? disabledColor;
  final Color? focusedColor;
  final Color? cursorColor;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefixWidget;
  final FormFieldValidator<String>? validator;
  final double? height;
  final double? width;
  final Color? color;
  final String? labelText;
  final Color? colors;
  final Gradient? gradient;
  final BorderRadiusGeometry? borderRadius;
  final List<TextInputFormatter>? inputFormatters;
  final AlignmentGeometry? alignment;

  final Widget? suffix;

  CustomTextField({
    Key? key,
    this.validator,
    this.spreadRadius,
    this.offset,
    this.onChanged,
    this.disabledColor,
    this.maxLine = 1,
    this.maxLength,
    this.radius,
    this.fontSize,
    this.fillColor,
    this.textColor,
    this.isPassword = false,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
    this.focusNode,
    this.hintText,
    this.hintTextColor,
    this.hintFontSize,
    this.hintTextWeight,
    this.textAlign,
    this.textAlignVertical,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.enableColor,
    this.focusedColor,
    this.cursorColor,
    required this.controller,
    this.contentPadding,
    this.prefixWidget,
    this.readOnly = false,
    this.height,
    this.width,
    this.color,
    this.colors,
    this.gradient,
    this.borderRadius,
    this.inputFormatters,
    this.labelText, this.suffix, this.alignment,
  }) : super(key: key);

  final ValueNotifier<bool> _isObscure = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(radius ?? 10),
      child: ValueListenableBuilder(
          valueListenable: _isObscure,
          builder: (context, bool isObscure, _) {
            if (!isPassword) {
              isObscure = false;
            }
            return IntrinsicHeight(
              child: Container
                (alignment: alignment,
                height: SizeUtils.verticalBlockSize * 5,
                width: width,
                // color: Colors.indigo.shade200,
                decoration: BoxDecoration(
                  color: Color(0xFFB3E5FC),
                  gradient: gradient,
                  borderRadius: borderRadius,
                ),
                child: TextFormField(
                  readOnly: readOnly,
                  validator: validator,
                  // style: TextStyle(
                  //   color: textColor ?? AppColors.black,
                  //   fontSize: fontSize ?? SizeUtils.fSize_14(),
                  //   fontWeight: FontWeight.w400,
                  // ),
                  onTap: onTap,
                  obscureText: isObscure,
                  obscuringCharacter: '*',
                  onChanged: onChanged,
                  controller: controller,
                  maxLines: maxLine,
                  maxLength: maxLength,
                  keyboardType: keyboardType,
                  inputFormatters: inputFormatters,
                  focusNode: focusNode,
                  textAlignVertical: textAlignVertical,
                  // cursorColor: cursorColor ?? AppColors.black,
                  textAlign: textAlign ?? TextAlign.start,
                  enabled: enabled,
                  decoration: InputDecoration(

                    labelText: labelText,
                    hintText: hintText,
                    border: InputBorder.none,
                    contentPadding: contentPadding,
                    suffix: suffix,
                    suffixIcon: suffixIcon,
                  ),

                  /* decoration: InputDecoration(
                    prefix: prefixWidget,
                    contentPadding: contentPadding ??
                        EdgeInsets.symmetric(
                            horizontal: SizeUtils.horizontalBlockSize * 6,
                            vertical: SizeUtils.verticalBlockSize * 2),
                    isDense: true,
                    prefixIcon: prefixIcon,
                    suffixIcon: suffixIcon == null && isPassword
                        ? IconButton(
                            icon: Icon(
                              isObscure
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.grey,
                              size: SizeUtils.verticalBlockSize * 2.6,
                            ),
                            onPressed: () {
                              _isObscure.value = !isObscure;
                            },
                          )
                        : suffixIcon,
                    counterText: "",
                    // contentPadding: const EdgeInsets.all(12),
                    hintText: hintText,
                    // hintStyle: TextStyle(
                    //   fontFamily: AssetsPath.robotoFonts,
                    //   color: hintTextColor ?? AppColors.textColor,
                    //   fontSize: hintFontSize ?? SizeUtils.fSize_14(),
                    //   fontWeight: hintTextWeight ?? FontWeight.w400,
                    // ),
                    filled: true,
                    // fillColor: fillColor ?? AppColors.white,
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(radius ?? 10),
                      ),
                      borderSide: BorderSide(
                        color: disabledColor ?? Colors.transparent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(radius ?? 10),
                      ),
                      borderSide: BorderSide(
                        color: enableColor ?? Colors.transparent,
                      ),
                    ),
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.all(
                    //     Radius.circular(radius ?? 10),
                    //   ),
                    //   borderSide: BorderSide(
                    //     color: focusedColor ?? Colors.transparent,
                    //   ),
                    // ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          radius ?? 10,
                        ),
                      ),
                      borderSide: BorderSide(
                        color: focusedColor ?? Colors.transparent,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          radius ?? 10,
                        ),
                      ),
                      borderSide: const BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          radius ?? 10,
                        ),
                      ),
                      borderSide: const BorderSide(
                        color: Colors.red,
                      ),
                    ),
                  ),*/
                ),
              ),
            );
          }),
    );
  }
}
