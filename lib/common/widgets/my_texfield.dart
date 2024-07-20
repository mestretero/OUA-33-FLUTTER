import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? name;
  final String hintText;
  final bool isTextArea;
  final bool obscureText;
  final IconData? prefixIcon;
  final TextCapitalization textCapitalization;
  final TextInputType inputType;

  const MyTextField({
    Key? key,
    required this.controller,
    this.name,
    required this.hintText,
    required this.inputType,
    required this.isTextArea,
    this.prefixIcon,
    this.obscureText = false,
    this.textCapitalization = TextCapitalization.none,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (name != "" && name != null)
              Text(
                name!,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              enabled: true,
              controller: controller,
              textCapitalization: textCapitalization,
              maxLength: isTextArea ? 512 : 32,
              maxLines: isTextArea ? 6 : 1,
              obscureText: obscureText,
              keyboardType: inputType,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
              ),
              validator: (value) => validate(context, name!, value),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: prefixIcon == null
                  ? InputDecoration(
                      isDense: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.secondary),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.secondary),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                      ),
                      hintText: hintText,
                      hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 14,
                      ),
                      counterText: "",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.secondary),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.redAccent.shade700),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      alignLabelWithHint: true,
                    )
                  : InputDecoration(
                      prefixIcon: Icon(
                        prefixIcon,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      isDense: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.secondary),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.secondary),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                      ),
                      hintText: hintText,
                      hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 14,
                      ),
                      counterText: "",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.secondary),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.redAccent.shade700),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      alignLabelWithHint: true,
                    ),
            ),
          ],
        ));
  }

  validate(BuildContext context, String name, value) {
    if (name == 'Email') {
      if (value == null || value.isEmpty) {
        return 'Please enter your email';
      } else if (!isEmailValid(value)) {
        return 'Please enter a valid email';
      }
    } else if (name == 'Name') {
      if (value == null || value.isEmpty) {
        return 'Please enter your name';
      }
    } else if (name == 'Password') {
      if (value == null || value.isEmpty) {
        return 'Please enter your password';
      } else if (value.length < 8) {
        return 'Password can\'t be less than 8 characters';
      }
    }
    return null;
  }

  bool isEmailValid(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
}
