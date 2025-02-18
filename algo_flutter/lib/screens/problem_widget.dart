import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/problem.dart';
import 'constants.dart';

class ProblemWidget extends StatelessWidget {
  final List<Problem> problems;

  const ProblemWidget({super.key, required this.problems});

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
              "Problems:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Constants.DARK_GREEN,
                fontFamily: "Georgia",
              ),
            ),
            const SizedBox(height: 5),
            Column(
              children: [
                for (Problem problem in problems)
                  GestureDetector(
                    onTap: () => _launchURL(problem.url),
                    child: Text(
                      problem.name,
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.blue[800],
                        decorationStyle: TextDecorationStyle.solid,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ));
  }
}

_launchURL(String url) async {
  final Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Could not launch $url';
  }
}
