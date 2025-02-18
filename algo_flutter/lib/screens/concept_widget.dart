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
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Constants.CARD_BACKGROUND_COLOR,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(2, 2))],
      ),
      child: Column(
        children: [
          const Text(
            "Concept:",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Constants.DARK_GREEN, fontFamily: "Georgia"),
          ),
          const SizedBox(height: 5),
          Text(
            concept?.description ?? "",
            softWrap: true,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, fontFamily: "Georgia", color: Constants.DARK_GREEN),
          ),
        ],
      ),
    );
  }
}
