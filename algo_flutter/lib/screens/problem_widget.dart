import 'package:flutter/cupertino.dart';

import '../models/problem.dart';


class ProblemWidget extends StatelessWidget {
  final Problem? problem;

  const ProblemWidget({super.key, required this.problem});

  @override
  Widget build(BuildContext context) {
    return Text(problem?.name ?? "null");
  }
}
