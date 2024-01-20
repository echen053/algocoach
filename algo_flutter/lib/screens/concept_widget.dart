import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/concept.dart';
import 'constants.dart';

class ConceptWidget extends StatelessWidget {
  final Concept? concept;

  const ConceptWidget({super.key, required this.concept});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Constants.CARD_BACKGROUND_COLOR,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Center(child: Text(concept?.description ?? "None"))),
    );
  }
}
