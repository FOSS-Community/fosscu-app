import 'package:flutter/material.dart';
import 'package:fosscu_app/screens/learn_page_screens/what_is_github_pages/page1.dart';
import 'package:fosscu_app/screens/learn_page_screens/what_is_github_pages/page2.dart';
import 'package:fosscu_app/screens/learn_page_screens/what_is_github_pages/page3.dart';
import 'package:fosscu_app/screens/learn_page_screens/what_is_github_pages/page4.dart';
import 'package:fosscu_app/screens/learn_page_screens/what_is_github_pages/page5.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WhatIsGithub extends StatefulWidget {
  const WhatIsGithub({super.key});

  @override
  State<WhatIsGithub> createState() => _WhatIsGithubState();
}

class _WhatIsGithubState extends State<WhatIsGithub> {
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
                onLastPage = (index == 4);

                /// 2 is subject to change
              });
            },
            controller: _controller,
            children: const [
              WhatIsGithubPage1(),
              WhatIsGithubPage2(),
              WhatIsGithubPage3(),
              WhatIsGithubPage4(),
              WhatIsGithubPage5()
            ],
          ),
          Container(
            alignment: const AlignmentDirectional(0, 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SmoothPageIndicator(
                  controller: _controller,
                  count: 5,
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
