import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';

import '../constant/style.dart';

class CustomTextField extends TextFormField {
  CustomTextField(
      {Key? key,
      TextEditingController? controller,
      required BuildContext ctx,
      TextInputType? inputType,
      FormFieldValidator? validator,
      Widget? leading,
      bool? readOnly,
      Widget? trailing,
      List<TextInputFormatter>? formatters,
      Function(String?)? onChange,
      String? hint})
      : super(
          key: key,
          inputFormatters: formatters,
          controller: controller,
          onChanged: onChange,
          readOnly: readOnly ?? false,
          validator: validator,
          keyboardType: inputType,
          style: Theme.of(ctx).textTheme.bodyMedium,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            prefixIcon: leading,
            suffixIcon: trailing,
            fillColor: KGrey.withOpacity(0.1),
            isDense: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          ),
        );
}

class CustomTextFieldO extends TextField {
  CustomTextFieldO({
    Key? key,
    TextEditingController? controller,
    required BuildContext ctx,
    Widget? leading,
  }) : super(
          key: key,
          controller: controller,
          style: Theme.of(ctx).textTheme.headlineSmall,
          decoration: InputDecoration(
            prefixIcon: leading,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(width: 1, color: KGrey),
            ),
          ),
        );
}

PickerDialogStyle phonestyle = PickerDialogStyle(
    backgroundColor: KWhite,
    countryCodeStyle: const TextStyle(fontSize: 13),
    listTilePadding: EdgeInsets.zero,
    listTileDivider: const Divider(height: 1),
    countryNameStyle: const TextStyle(fontSize: 14));
