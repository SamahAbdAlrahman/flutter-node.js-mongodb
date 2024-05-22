import 'package:gofit/common/colo_extension.dart';
import 'package:flutter/material.dart';


class Snacks extends StatefulWidget {
  const Snacks({super.key});

  @override
  State<Snacks> createState() => _WorkoutDetailViewState();
}

class _WorkoutDetailViewState extends State<Snacks> {
  List yourDataList = [


    {
      "imagePath": "assets/img/f29.jpg",
      "title": "Low-Fat Milk Rice Pudding",
      "description":"Basmati rice, water, sweetened condensed milk, cardamom, cashews"
    },

    {
      "imagePath": "assets/img/f30.jpg",
      "title": "Keto Mahalabiya",
      "description":"cardamom, raisins, Basmati rice, water,milk, cashews"
    },

    {
      "imagePath": "assets/img/f23.jpg",
      "title": "Celery and Parsley Juice",
      "description":"Celery, parsley, lemon juice, water, ice cubes"
    },

    {
      "imagePath": "assets/img/f6.jpg",
      "title": "Diet-friendly Uthmaniya Dessert",
      "description":"Semolina, Low-fat milk, stevia, Rosewater,Ground ,cardamom, coconut"
    },
    {
      "imagePath": "assets/img/f31.jpg",
      "title":"Cold Pineapple Juice",
      "description":"Kiwi, pineapple, agave syrup ."
    },
    {
      "imagePath": "assets/img/f12.jpeg",
      "title":"Popcorn",
      "description":"Popcorn , Salt, a spoon of oil."
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
                  // "assets/img/QXBjSJ-food-decorations-clipart-photo.jpg",
                   "assets/img/foo2.png",
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
                              " Snacks",
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
                  "Experience a world of delicious delights in\nevery bite with our scrumptious snacks.",
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
                    itemCount: 6,
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
