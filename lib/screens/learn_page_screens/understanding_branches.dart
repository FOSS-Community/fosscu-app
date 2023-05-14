import 'package:flutter/material.dart';
import 'package:fosscu_app/screens/learn_page_screens/understanding_branches_pages/page1.dart';
import 'package:fosscu_app/screens/learn_page_screens/understanding_branches_pages/page2.dart';
import 'package:fosscu_app/screens/learn_page_screens/understanding_branches_pages/page3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class UnderstandingBranches extends StatefulWidget {
  const UnderstandingBranches({super.key});

  @override
  State<UnderstandingBranches> createState() => _UnderstandingBranchesState();
}

class _UnderstandingBranchesState extends State<UnderstandingBranches> {
  final PageController _controller = PageController();
  bool onLastPage = false;
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);

                /// 2 is subject to change
              });
            },
            controller: _controller,
            children: const [
              UnderstandingBranchesPage1(),
              UnderstandingBranchesPage2(),
              UnderstandingBranchesPage3(),
            ],
          ),
          Container(
            alignment: const AlignmentDirectional(0, 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.white,
                    dotWidth: screenWidth * 0.033,
                    dotHeight: screenWidth * 0.013,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: screenWidth * 0.02),
            alignment: const AlignmentDirectional(1, 1),
            child: onLastPage
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(screenWidth * 0.03).copyWith(
                          left: screenWidth * 0.05, right: screenWidth * 0.05),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.done_outline_rounded))
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(screenWidth * 0.03).copyWith(
                          left: screenWidth * 0.05, right: screenWidth * 0.05),
                    ),
                    onPressed: () {
                      _controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn);
                    },
                    child: const Icon(Icons.arrow_right_alt_rounded)),
          )
        ],
      ),
    );
  }
}
