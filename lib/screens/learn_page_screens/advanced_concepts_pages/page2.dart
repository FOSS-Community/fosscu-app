import 'package:flutter/material.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/body_text.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/code_snippet.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/heading.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/sub_heading.dart';

class AdvancedConceptsPage2 extends StatelessWidget {
  const AdvancedConceptsPage2({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: blackColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: screenHeight * 0.03,
              ),
              Column(
                children: const [
                  LearnPageHeading(
                    color: greenColor,
                    text: 'The Rebase Command',
                    size: 0.04,
                  ),
                  LearnPageBodyText(
                    color: Colors.white,
                    text:
                        "Imagine you are writing a book collaboratively with a friend. You both start with the same initial draft, but you work on different chapters independently. As time goes on, your friend completes their chapters and makes improvements, while you continue to work on your own sections. Now, when it's time to integrate your changes and finalize the book, you can use the git rebase command to rebase your changes onto the updated version of your friend's work. To understand this concept, think of the rebase command as rewriting your chapters to fit seamlessly into your friend's improved version of the book. It's like taking your chapters and reorganizing them, updating them, and incorporating any changes your friend has made. The result is a cohesive and up-to-date final version.",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
