import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentora_app/core/colors_manager.dart';

class CustomDropDownMenu extends StatelessWidget {
  const CustomDropDownMenu({
    super.key,
    required this.hintText,
    this.onChange,
    this.onValidator,
    required this.dropDownList,
    required this.value,
  });

  final String hintText;
  final void Function(String?)? onChange;
  final String? Function(String?)? onValidator;
  final List<String> dropDownList;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      dropdownColor: Theme.of(context).scaffoldBackgroundColor,
      isExpanded: true,
      validator: onValidator,
      items:
          dropDownList.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item, style: Theme.of(context).textTheme.bodySmall),
            );
          }).toList(),
      value: value,
      onChanged: onChange,
      hint: Text(hintText, style: Theme.of(context).textTheme.bodySmall),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.r),
          borderSide: BorderSide(color: ColorsManager.black),
        ),
      ),
    );
  }
}
