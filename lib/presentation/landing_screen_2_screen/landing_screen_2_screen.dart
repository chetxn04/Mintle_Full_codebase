import 'package:flutter/material.dart';
import 'package:harsh_app/core/app_export.dart';
import 'package:harsh_app/widgets/custom_elevated_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class LandingScreen2Screen extends StatelessWidget {
  LandingScreen2Screen({Key? key})
      : super(
          key: key,
        );

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: Container(
          width: SizeUtils.width,
          height: SizeUtils.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.21, 1),
              end: Alignment(0.2, 0),
              colors: [
                theme.colorScheme.onPrimaryContainer,
                appTheme.black900,
              ],
            ),
          ),
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(vertical: 51.v),
            child: Column(
              children: [
                SizedBox(
                  height: 480.v,
                  child: PageView(
                    controller: pageController,
                    scrollDirection: Axis.horizontal,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 382.v,
                            width: double.maxFinite,
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                CustomImageView(
                                  imagePath: ImageConstant.img3dPositiveBus,
                                  height: 378.v,
                                  width: 360.h,
                                  alignment: Alignment.center,
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    "Planning ahead",
                                    style: theme.textTheme.headlineLarge,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 278.h,
                            margin: EdgeInsets.only(
                              left: 48.h,
                              top: 39.v,
                              right: 34.h,
                            ),
                            child: Text(
                              "Setup your budget for each category\nso you in control",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.titleMedium,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 408.v,
                            width: double.maxFinite,
                            child: Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: SizedBox(
                                    width: 269.h,
                                    child: Text(
                                      "Gain total control \nof your money",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: theme.textTheme.headlineLarge!
                                          .copyWith(
                                        height: 1.22,
                                      ),
                                    ),
                                  ),
                                ),
                                CustomImageView(
                                  imagePath: ImageConstant.imgIndianRupeeCu,
                                  height: 346.v,
                                  width: 360.h,
                                  alignment: Alignment.topCenter,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 261.h,
                            margin: EdgeInsets.only(
                              left: 51.h,
                              top: 9.v,
                              right: 46.h,
                            ),
                            child: Text(
                              "Become your own money manager and make every cent count",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.titleMedium,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 408.v,
                            width: double.maxFinite,
                            child: Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: SizedBox(
                                        width: 269.h,
                                        child: Text(
                                          "Know where your \nmoney goes",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          style: theme.textTheme.headlineLarge!
                                              .copyWith(
                                            height: 1.22,
                                          ),
                                        ),
                                      ),
                                ),

                                CustomImageView(
                                  imagePath: ImageConstant.imgIstockphoto117,
                                  height: 360.adaptSize,
                                  width: 360.adaptSize,
                                  alignment: Alignment.topCenter,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 261.h,
                            margin: EdgeInsets.only(
                              left: 51.h,
                              top: 9.v,
                              right: 46.h,
                            ),
                            child: Text(
                              "Track your transaction easily,with categories",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.titleMedium,
                            ),
                          ),
                        ],
                      ),


                    ],
                  ),
                ),
                SmoothPageIndicator(
                  controller: pageController,
                  count: 3,
                  axisDirection: Axis.horizontal,
                  effect: ScrollingDotsEffect(
                    spacing: 16,
                    activeDotColor: appTheme.indigoA700,
                    dotColor: appTheme.deepPurple50,
                    activeDotScale: 2.0,
                    dotHeight: 8.v,
                    dotWidth: 8.h,
                  ),
                  onDotClicked: (value) {
                    pageController.jumpToPage(value);
                  },
                ),
                SizedBox(height: 24.v),
                CustomElevatedButton(
                  text: "Sign Up",
                  margin: EdgeInsets.only(
                    left: 29.h,
                    right: 34.h,
                  ),
                ),
                SizedBox(height: 20.v),
                CustomElevatedButton(
                  text: "Login",
                  margin: EdgeInsets.only(
                    left: 29.h,
                    right: 32.h,
                  ),
                  buttonStyle: CustomButtonStyles.fillPrimary,
                  buttonTextStyle:
                      CustomTextStyles.titleMediumInterPrimaryContainer,
                ),
                SizedBox(height: 5.v),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
