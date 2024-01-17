import 'package:flutter/cupertino.dart';

import '../models/concept.dart';

class ConceptWidget extends StatelessWidget {
  final Concept? concept;

  const ConceptWidget({super.key, required this.concept});

  @override
  Widget build(BuildContext context) {
    return Text(concept?.description ?? "None");
  }
}
