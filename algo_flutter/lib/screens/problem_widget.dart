import 'package:flutter/cupertino.dart';

import '../models/problem.dart';
import 'constants.dart';

class ProblemWidget extends StatelessWidget {
  final Problem? problem;

  const ProblemWidget({super.key, required this.problem});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Constants.CARD_BACKGROUND_COLOR,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Center(child: Text(problem?.name ?? "null"))));
  }
}
