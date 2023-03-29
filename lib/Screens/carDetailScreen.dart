import 'package:flutter/material.dart';
import 'package:wheelie/main.dart';

class CarDetailScreen extends StatelessWidget {
  const CarDetailScreen(
      {Key? key,
      required this.imagePath,
      required this.name,
      required this.logoPath,
      required this.price})
      : super(key: key);
  final imagePath, name, logoPath, price;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Color(0xFF1d1f20),
        elevation: 0.0,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_horiz,
                size: 30,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Hero(
              tag: imagePath,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Color(0xFFffd934),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text("4.8",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20))
                        ],
                      )
                    ],
                  ),
                ),
                height: MediaQuery.of(context).size.height * 0.4,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF1d1f20),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(28.0),
                    bottomRight: Radius.circular(28.0),
                  ),
                  image: DecorationImage(
                      alignment: Alignment.center,
                      image: AssetImage(imagePath),
                      fit: BoxFit.contain),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 20.0),
              child: Text(
                "Specifications",
                style: TextStyle(fontSize: 25),
              ),
            ),
            Container(
              height: 120,
              child: ListView(
                padding: EdgeInsets.only(left: 10, right: 18),
                scrollDirection: Axis.horizontal,
                children: [
                  SpecificationTile(
                    icon: Icons.speed_outlined,
                    title: '300 ',
                    speedMeasure: 'km/h',
                  ),
                  SpecificationTile(
                    icon: Icons.directions_car,
                    title: 'Liftback ',
                  ),
                  SpecificationTile(
                    icon: Icons.groups,
                    title: '4 Capacity ',
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15, bottom: 15, left: 20),
              child: Text(
                "Location",
                style: TextStyle(fontSize: 25),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0)),
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.location_pin,
                            size: 18,
                            color: Color(0xFF0f5ef5),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            prefs.getString('location').toString() + ",Kenya",
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      RichText(
                          text: TextSpan(children: [
                        WidgetSpan(
                          child: Icon(
                            Icons.directions_walk,
                            color: Colors.grey[400],
                            size: 20,
                          ),
                        ),
                        TextSpan(
                            text: ' 344km',
                            style: TextStyle(
                                color: Colors.grey[400], fontSize: 15)),
                      ]))
                    ]),
              ),
            ),
            SizedBox(
              height: 15.0,
            )
          ],
        ),
      ),
      floatingActionButton: Container(
        child: Row(
          children: [
            Flexible(
                flex: 1,
                child: Container(
                  child: Center(
                    child: RichText(
                        text: TextSpan(
                            text: price,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                            children: [
                          TextSpan(
                              text: "/day",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15))
                        ])),
                  ),
                )),
            Flexible(
                flex: 1,
                child: Container(
                  child: Center(
                      child: Text(
                    "Book now",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  )),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15.0),
                        topLeft: Radius.circular(15),
                      )),
                ))
          ],
        ),
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class SpecificationTile extends StatelessWidget {
  const SpecificationTile({
    Key? key,
    required this.icon,
    required this.title,
    this.speedMeasure = '',
  }) : super(key: key);
  final IconData icon;
  final String title;
  final String speedMeasure;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 32,
                ),
                RichText(
                  text: TextSpan(
                      text: title,
                      style: TextStyle(color: Colors.white, fontSize: 15),
                      children: [
                        TextSpan(
                          text: speedMeasure,
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      ]),
                ),
              ]),
          height: 100,
          width: 150,
          decoration: BoxDecoration(
              color: Color(0xFF1d1f20),
              borderRadius: BorderRadius.circular(20.0))),
    );
  }
}
