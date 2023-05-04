import 'package:flutter/material.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:fosscu_app/constants/svg.dart';
import 'package:fosscu_app/widgets/contributor_page_tile.dart';

class ContributorPage extends StatefulWidget {
  const ContributorPage({super.key});

  @override
  State<ContributorPage> createState() => _ContributorPageState();
}

class _ContributorPageState extends State<ContributorPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: blackColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: screenWidth * 0.1,
              ),
              Container(
                alignment: const AlignmentDirectional(-1, 0),
                margin: EdgeInsets.only(left: screenWidth * 0.07),
                child: Text(
                  'Contributors',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                alignment: const AlignmentDirectional(-1, 0),
                margin: EdgeInsets.only(left: screenWidth * 0.077),
                child: Text(
                  'FOSS-Community',
                  style: TextStyle(
                    color: greenColor,
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.033,
              ),
               SizedBox(height: screenHeight * 0.3,),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: screenHeight * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        ContributionTile(picture: openPr, text: 'Raised PRs'),
                        ContributionTile(picture: mergedPr, text: 'Merged PRs')
                      ],
                    ),
                  ),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      ContributionTile(picture: gitIcon, text: "Contributors\n        Profile"),
                      ContributionTile(picture: glasses, text: "         Top 5\nContributors")
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
