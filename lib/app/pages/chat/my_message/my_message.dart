import 'package:flutter/material.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/app/theme/colors.dart';

class MyMessageCard extends StatelessWidget {
  final String message;
  final String date;

  const MyMessageCard({
    Key? key,
    required this.message,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          color: primary,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 30,
                  top: 5,
                  bottom: 20,
                ),
                child: CustomText(
                  text: message,
                  fontSize: 16,
                  color: base,
                ),
              ),
              Positioned(
                bottom: 4,
                right: 10,
                child: Row(
                  children: [
                    CustomText(
                      text: date,
                      fontSize: 13,
                      color: grey200.withOpacity(0.5),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.done_all,
                      size: 20,
                      color: grey200.withOpacity(0.5),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
