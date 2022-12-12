import 'package:flutter/material.dart';

import '../theme.dart';

class InputField extends StatelessWidget {
  final String title;
  final String placeholder;
  final TextEditingController? controller;
  final Widget? widget;

  const InputField(
      {Key? key,
      required this.title,
      required this.placeholder,
      this.controller,
      this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Themes.inputTitle,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: TextFormField(
              readOnly: (widget == null) ? false : true,
              cursorColor: actionBgClr,
              controller: controller,
              style: const TextStyle(color: primaryTxtClr, fontSize: 14.0),
              validator: (text) {
                if (widget != null) return null;
                if (text == null || text.isEmpty) {
                  return 'Required field is missing';
                }
                return null;
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 16.0),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: actionBgClr, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: borderClr, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
                hintText: placeholder,
                hintStyle:
                    (widget == null) ? Themes.mutedTxt : const TextStyle(),
                suffixIcon: (widget != null) ? widget : const SizedBox(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
