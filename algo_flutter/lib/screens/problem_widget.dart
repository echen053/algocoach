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
        padding: EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
          color: Constants.CARD_BACKGROUND_COLOR,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Column(
          children: [
            const Text(
              "Problems:\n",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (Problem problem in problems)
                  Center(
                    child: GestureDetector(
                      onTap: () => _launchURL(problem.url),
                      child: Text(
                        problem.name,
                        style: const TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.blue,
                        ),
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
