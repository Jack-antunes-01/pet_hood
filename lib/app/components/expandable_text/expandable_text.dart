import 'package:flutter/material.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/app/theme/colors.dart';

class ExpandableText extends StatefulWidget {
  const ExpandableText({
    Key? key,
    required this.text,
    this.trimLines = 2,
  }) : super(key: key);

  final String text;
  final int trimLines;

  @override
  State<ExpandableText> createState() => ExpandableTextState();
}

class ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;

  toggleText() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final span = TextSpan(text: widget.text);
    final textPainter = TextPainter(
        text: span,
        maxLines: widget.trimLines,
        textDirection: TextDirection.ltr);
    textPainter.layout(maxWidth: MediaQuery.of(context).size.width - 40);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: widget.text.trim(),
          color: grey600,
          maxLines: isExpanded ? 200 : widget.trimLines,
          textOverflow: TextOverflow.ellipsis,
        ),
        textPainter.didExceedMaxLines
            ? GestureDetector(
                onTap: () => toggleText(),
                child: CustomText(
                  text: isExpanded ? "Ver menos" : "Ver mais",
                  color: primary,
                  fontWeight: FontWeight.bold,
                ),
              )
            : const SizedBox.shrink()
      ],
    );
  }
}
