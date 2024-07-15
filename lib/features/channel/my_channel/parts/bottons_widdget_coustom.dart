import 'package:flutter/material.dart';
import 'package:flutter_application_1/cores/colors.dart';
import 'package:flutter_application_1/cores/widgets/image_button.dart';

class ButtonsWidgetCustom extends StatelessWidget {
  const ButtonsWidgetCustom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.only(left: 8),
              height: 41,
              decoration: BoxDecoration(
                color: softBlueGreyBackGround,
                borderRadius: BorderRadius.circular(9),
              ),
              child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Mange Videos",
                    style: TextStyle(color: Colors.black),
                  )),
            ),
          ),
          Expanded(
            child: ImageButton(
                onPressed: () {},
                image: "pen.png",
                haveColor: true),
          ),
          Expanded(
            child: ImageButton(
                onPressed: () {}, //assets/icons/
                image: "time-watched.png",
                haveColor: true),
          ),
        ],
      ),
    );
  }
}
