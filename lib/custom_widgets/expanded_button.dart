import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ExpandedButton extends StatefulWidget {
  String text = '';
  FocusNode? focusNode = FocusNode();
  Function()? onTap;
  ExpandedButton({super.key, this.text = '', required this.onTap, this.focusNode});

  @override
  State<ExpandedButton> createState() => _ExpandedButtonState();
}

class _ExpandedButtonState extends State<ExpandedButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.primaryContainer,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        focusNode: widget.focusNode,
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(16),
        splashColor: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.transparent),
          child: Center(
            child: Text(
              widget.text,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
