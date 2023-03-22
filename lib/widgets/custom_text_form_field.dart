import 'package:daily_task_manager/values/values.dart';
import 'package:daily_task_manager/widgets/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CustomTextFormField extends StatelessWidget {
  final TextStyle? textStyle;
  final TextStyle? hintTextStyle;
  final TextStyle? labelStyle;
  final TextStyle? titleStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final String? labelText;
  final String? title;
  final bool obscured;
  final bool hasPrefixIcon;
  final bool hasSuffixIcon;
  final bool hasTitle;
  final bool hasTitleIcon;
  final Widget? titleIcon;
  final TextInputType? textInputType;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final InputBorder border;
  final InputBorder enabledBorder;
  final InputBorder focusedBorder;
  final InputBorder errorBorder;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? textFormFieldMargin;
  final void Function()? onTap;
  final bool readonly;
  final BorderRadiusGeometry? borderRadius;
  final int? maxLines;
  final bool isCircular;

  CustomTextFormField({
    this.prefixIcon,
    this.suffixIcon,
    this.textStyle,
    this.hintTextStyle,
    this.labelStyle,
    this.titleStyle,
    this.titleIcon,
    this.hasTitleIcon = false,
    this.title,
    this.contentPadding,
    this.textFormFieldMargin,
    this.hasTitle = false,
    this.border = Borders.primaryInputBorder,
    this.focusedBorder = Borders.focusedBorder,
    this.enabledBorder = Borders.enabledBorder,
    this.errorBorder = Borders.errorBorder,
    this.hintText,
    this.labelText,
    this.hasPrefixIcon = false,
    this.hasSuffixIcon = false,
    this.obscured = false,
    this.textInputType,
    this.onChanged,
    this.validator,
    this.inputFormatters,
    this.width,
    this.height,
    this.onTap,
    this.readonly = false,
    this.borderRadius,
    this.maxLines,
    this.isCircular = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            hasTitleIcon ? titleIcon! : Container(),
            hasTitle
                ? Padding(
                    padding: EdgeInsets.only(
                        left: (isCircular) ? Sizes.PADDING_18 : 0),
                    child: Text(title!, style: titleStyle))
                : Container(),
          ],
        ),
        hasTitle ? SpaceH4() : Container(),
        Container(
          margin: textFormFieldMargin,
          child: SizedBox(
            width: width,
            height: height,
            child: TextFormField(
              onTap: onTap,
              style: textStyle,
              keyboardType: textInputType,
              onChanged: onChanged,
              validator: validator,
              inputFormatters: inputFormatters,
              decoration: InputDecoration(
                contentPadding: contentPadding,
                labelText: labelText,
                labelStyle: labelStyle,
                border: border,
                enabledBorder: enabledBorder,
                focusedBorder: focusedBorder,
                errorBorder:
                    (isCircular) ? Borders.outlineErrorBorder : errorBorder,
                prefixIcon: hasPrefixIcon ? prefixIcon : null,
                suffixIcon: hasSuffixIcon ? suffixIcon : null,
                hintText: hintText,
                hintStyle: hintTextStyle,
              ),
              obscureText: obscured,
              readOnly: readonly,
              maxLines: maxLines,
            ),
          ),
        ),
      ],
    );
  }
}
