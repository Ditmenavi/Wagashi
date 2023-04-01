import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoginInput extends StatefulWidget {
  String hintText = '';
  bool obscureText = false;
  FocusNode? focusNode = FocusNode();
  void Function(String)? onSubmitted;
  // ignore: prefer_typing_uninitialized_variables
  var controller;
  LoginInput(
      {super.key,
      this.hintText = '',
      this.obscureText = false,
      required this.controller,
      this.focusNode,
      this.onSubmitted});

  @override
  State<LoginInput> createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        final colorScheme = Theme.of(context).colorScheme;
        late Color borderColor = colorScheme.outline;
        return Focus(
          onFocusChange: (hasFocus) {
            if (hasFocus) {
              borderColor = colorScheme.primary;
              FocusScope.of(context).requestFocus(widget.focusNode);
            } else {
              borderColor = colorScheme.outline;
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            curve: Curves.ease,
            decoration: BoxDecoration(
              border: Border.all(color: borderColor.withOpacity(0.8), width: 1.5),
              borderRadius: BorderRadius.circular(16),
              color: Colors.transparent,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                onSubmitted: widget.onSubmitted,
                focusNode: widget.focusNode,
                controller: widget.controller,
                obscureText: widget.obscureText,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: TextStyle(color: borderColor.withOpacity(0.6)),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
