import 'package:flutter/material.dart';

import 'package:gofit/screens/main_tab/main_tab_view.dart';
import '../../common/colo_extension.dart';
import '../../common_widget/round_button.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  PageController? controller = PageController();
  int selectPage = 0;

  List pageArr = [
    {
      "title": "Have a good health",
      "subtitle":
          "Being healthy is all, no health is nothing.\nSo why do not we",
      "image": "assets/img/on_board_1.png",
    },
    {
      "title": "Be stronger",
      "subtitle":
          " Take 30 minutes of bodybuilding every\nday to get physically fit and healthy.",
      "image": "assets/img/on_board_2.png",
    },
    {
      "title": "Have nice body",
      "subtitle":
          "Bad body shape, poor sleep, lack of strength,easily traumatized\npoor metabolism.",
      "image": "assets/img/on_board_3.png",
    }
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller?.addListener(() {
      selectPage = controller?.page?.round() ?? 0;

      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: TColor.white,
      body: Stack(children: [
        Image.asset(
          "assets/img/on_board_bg.png",
          width: media.width,
          height: media.height,
          fit: BoxFit.cover,
        ),

        SafeArea(
          child: PageView.builder(
              controller: controller,
              itemCount: pageArr.length,
              itemBuilder: (context, index) {
                var pObj = pageArr[index] as Map? ?? {};

                return Column(

                  children: [
                    const SizedBox(height: 50),
                    Text(

                      pObj["title"].toString(),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 26,
                          fontWeight: FontWeight.w600
                      ),
                    ),

                   SizedBox(height: 51, ),
                    Image.asset(
                      pObj["image"].toString(),
                      width: media.width ,
                      height: media.width *0.9,
                      fit: BoxFit.contain,
                    ),

                    SizedBox(
                      height: 85,
                    ),

                     Text(
                      pObj["subtitle"].toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: TColor.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ],
                );
              }),
        )

        , 
        SafeArea(
          child: Column(
            
            children: [
              const Spacer(),

              const SizedBox(height: 18,),
              GestureDetector(
                onTap: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const
                  MainTabView() ));
                },
                child: Container(
                  height: 55,
                  width: 260,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                    gradient: const LinearGradient(
                      colors: [
                        // Color(0xff000207),
                        // // Color(0xff000207),
                        // Colors.deepOrange,
                        // Colors.deepOrange,
                        Color(0xff000207),
                        // Color(0xffff7300),
                        Color(0xffff6200),
                      ],
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Start',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 19,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: pageArr.map((pObj) {
                    var index = pageArr.indexOf(pObj);
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color:  selectPage == index ?
                      Colors.white:
                      Colors.black26,
                      // TColor.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(6)
                    ),
                  );

                } ).toList() ,
              ),
              const SizedBox(height: 19,),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              //   child: RoundButton(title: "Start", type: RoundButtonType.primaryText
              //     , onPressed: (){
              //
              //
              //     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const MainTabView()), (route) => false);
              //
              //   },),
              // ),

              
          ],),
        )
        
      ]),
    );
  }
}
