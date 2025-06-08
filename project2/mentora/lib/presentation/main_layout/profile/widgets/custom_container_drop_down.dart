import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentora_app/core/colors_manager.dart';

class CustomContainerDropDown extends StatelessWidget {
  const CustomContainerDropDown({super.key, required this.title, required this.textView, required this.menuItems, required this.onChange});

  final String title;
  final String textView;
  final List<String> menuItems;
  final void Function(String?) onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        SizedBox(height: 16.h),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(width: 1.w, color: ColorsManager.blue),
          ),
          child: Padding(
            padding: REdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    textView,
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleSmall,
                  ),
                ),
                SizedBox(
                  height: 36.h,
                  child: DropdownButton<String>(
                    dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                    underline: Container(),
                    items:
                    menuItems.map((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: onChange,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}


