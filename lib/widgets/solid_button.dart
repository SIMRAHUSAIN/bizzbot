import 'package:flutter/material.dart';
import 'package:mim_whatsup/utils/colors.dart';

class SoliButton extends StatefulWidget {

  final String text;
  final VoidCallback? onPressed;
  final Color textColor;
  final Color? backgroundColor;
  final double verticalSpacing;
  final double horizontalSpacing;
  final double borderRadius;
  final TextStyle? textStyle;
  final double? height;

  SoliButton({
    Key? key,
    required this.text,
    this.backgroundColor,
    this.borderRadius = 8.0,
    this.height,
    this.horizontalSpacing = 0.0,
    required this.onPressed,
    this.textColor = cFFFFFF,
    this.textStyle,
    this.verticalSpacing = 10.0
  }) : super(key: key);

  @override
  State<SoliButton> createState() => _SoliButtonState();
}

class _SoliButtonState extends State<SoliButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: widget.height,
            // ignore: deprecated_member_use
            child: RaisedButton(
              onPressed: widget.onPressed,
              textColor: widget.textColor,
              color: widget.backgroundColor,
              disabledTextColor: cFFFFFF,
              padding: EdgeInsets.symmetric(
                  vertical: widget.verticalSpacing,
                  horizontal: widget.horizontalSpacing),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
              child: Text(
                widget.text,
                style: widget.textStyle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}