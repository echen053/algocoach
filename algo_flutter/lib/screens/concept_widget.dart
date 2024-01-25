import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/concept.dart';
import 'constants.dart';

class ConceptWidget extends StatelessWidget {
  final Concept? concept;

  const ConceptWidget({super.key, required this.concept});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      padding: EdgeInsets.all(10.0),
      decoration: const BoxDecoration(
        color: Constants.CARD_BACKGROUND_COLOR,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              const Text(
                "Concept:\n",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Text(concept?.description ?? "", softWrap: true),
            ],
          )),
    );
  }
}
