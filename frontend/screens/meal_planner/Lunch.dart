import 'package:gofit/common/colo_extension.dart';
import 'package:flutter/material.dart';


class Lunch extends StatefulWidget {
  const Lunch({super.key});

  @override
  State<Lunch> createState() => _WorkoutDetailViewState();
}

class _WorkoutDetailViewState extends State<Lunch> {
  List yourDataList = [
//  غدا
//  f8.jpg
//  f11.jpg
//  f13.jpg
    {
      "imagePath": "assets/img/F27.jpg",
      "title": "Grilled salmon.",
      "description":"Salmon ,Olive oil ,Garlic ,Lemon ,Basil ,Parsley ,Salt."
    },


     {
      "imagePath": "assets/img/f17.jpg",
      "title": "Grilled fillet fish with herbs",
      "description":"Fillet, Dried herbs, Lemon , Salt, Parsley, Butter, Garlic"
    },  {
      "imagePath": "assets/img/f18.jpg",
      "title": "Kebab sandwich",
      "description":"Minced meat, onions, garlic, lemon, oil, honey, ginger, brown bread."
    },
    {
      "imagePath": "assets/img/f11.jpg",
      "title": "Healthy eggplant with bulgur",
      "description":"Eggplant, Bulgur, Mint, Tomato, Pomegranate molasses,Mixed spices."
    },


//  f16.jpg

    {
      "imagePath": "assets/img/f16.jpg",
      "title": "Vegetable soup",
      "description":"Onion, Potatoes, Carrots, Peas, Salt, Black pepper, Rosemary."
    },
    {
      "imagePath": "assets/img/f26.jpg",
      "title": "Air-fried zucchini chips",
      "description":"Zucchini, Cooking spray, Parmesan cheese, Salt, Black pepper: to taste."
    },

    {
      "imagePath": "assets/img/f13.jpg",
      "title": "Grilled eggplant ",
      "description":"Eggplant, oil, Garlic, Tomatoes, Green pepper, Cilantro, Lemon."
    },
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(gradient: LinearGradient(colors: TColor.primaryG)),
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              elevation: 0,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  margin: const EdgeInsets.all(8),
                  height: 40,
                  width: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: TColor.lightGray,
                      borderRadius: BorderRadius.circular(10)),
                  child: Image.asset(
                    "assets/img/black_btn.png",
                    width: 15,
                    height: 15,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            SliverAppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              elevation: 0,
              leadingWidth: 0,
              leading: Container(),
              expandedHeight: media.width * 0.5,
              flexibleSpace: Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/img/foo2.png", // Add your image path here
                  width: media.width * 0.75,
                  height: media.width * 0.8,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ];
        },
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              color: TColor.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25))),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: media.width * 0.05,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Lunch Meals ",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: media.width * 0.05,
                  ),
                  const Row(
                    children: [
                      Text(
    "Crafting Customized Lunch plans designed\nto cater to every tastes is truly captivating to\nwitness.",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: media.width * 0.05,
                  ),



                  //______________________________________________________________________________________________


                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 7,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        child: Row(
                          children: [
                            // الصورة
                            Image.asset(
                              yourDataList[index]['imagePath'],
                              width: media.width * 0.3,
                              height: media.width * 0.3,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(width: 10), // مسافة بين الصورة والنص
                            // العنوان والوصف
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    yourDataList[index]['title'], // استبدل هذا بالعنوان
                                    style: const TextStyle(
                                      color: Colors.black87,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    yourDataList[index]['description'], // استبدل هذا بالوصف
                                    style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),



                  SizedBox(
                    height: media.width * 0.05,
                  ),

                  //______________________________________________________________________________________________
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
