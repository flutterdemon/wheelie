import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:wheelie/Utils/themeUtil.dart';
import 'package:wheelie/Widgets/availableCarTile.dart';
import 'package:wheelie/main.dart';
import './notificationScreen.dart';
import './profileScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _listViewSelectedIndex = 0;
  int _selectedPageIndex = 0;
  final _zoomDrawerController = ZoomDrawerController();

  List<Widget> _pages = [Container(), NotificationScreen(), ProfileScreen()];

  List<String> _carCategories = [
    "All",
    "Luxury Car",
    "Family Car",
    "CamperVan",
    "Minivan",
    "SUV",
    "Convertible",
    "Compact Car",
    "Economy Car",
    "Full-Size Car",
    "Mid-Size Car"
  ];

  List<dynamic> _availableCars = [
    {
      "title": "Audi Q3",
      "image": "images/cars/audia1.png",
      "brand": "images/car-brands/audi.png",
      "price": "Ksh2000"
    },
    {
      "title": "Audi Box",
      "image": "images/cars/audi-box.png",
      "brand": "images/car-brands/audi.png",
      "price": "Ksh1800"
    },
    {
      "title": "Tesla",
      "image": "images/cars/carforbox.png",
      "brand": "images/car-brands/tesla.png",
      "price": "Ksh2000"
    },
    {
      "title": "Benz",
      "image": "images/cars/benz.png",
      "brand": "images/car-brands/mercedes.png",
      "price": "Ksh3000"
    },
    {
      "title": "Benz Box",
      "image": "images/cars/benz-box.png",
      "brand": "images/car-brands/mercedes.png",
      "price": "Ksh3500"
    },
    {
      "title": "Toyota Box",
      "image": "images/cars/toyota-box.png",
      "brand": "images/car-brands/toyota.png",
      "price": "Ksh1500"
    },
    {
      "title": "Toyota Camry",
      "image": "images/cars/toyotacamry.png",
      "brand": "images/car-brands/toyota.png",
      "price": "Ksh1800"
    },
    {
      "title": "BMW Box",
      "image": "images/cars/bmw-box.png",
      "brand": "images/car-brands/bmw.png",
      "price": "Ksh4000"
    },
    {
      "title": "BMW 320",
      "image": "images/cars/bmw320.png",
      "brand": "images/car-brands/bmw.png",
      "price": "Ksh3500"
    },
    {
      "title": "Golf6 Box",
      "image": "images/cars/golf6-box.png",
      "brand": "images/car-brands/volkswagen.png",
      "price": "Ksh1500"
    },
    {
      "title": "Golf6",
      "image": "images/cars/golf6.png",
      "brand": "images/car-brands/volkswagen.png",
      "price": "Ksh1700"
    },
    {
      "title": "Passat",
      "image": "images/cars/passat-box.png",
      "brand": "images/car-brands/volkswagen.png",
      "price": "Ksh1000"
    },
    {
      "title": "Passat CC",
      "image": "images/cars/passatcc.png",
      "brand": "images/car-brands/volkswagen.png",
      "price": "Ksh1200"
    },
  ];

  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkModeOn = Provider.of<ThemeProvider>(context).isDarkMode;
    return Scaffold(
      appBar: _selectedPageIndex == 0
          ? AppBar(
              elevation: 0,
              leading: GestureDetector(
                onTap: () {
                  ZoomDrawer.of(context)!.open();
                },
                child: Container(
                  child: FractionallySizedBox(
                    widthFactor: 0.5,
                    heightFactor: 0.5,
                    child: Image.asset(
                      'images/menus/menu4.png',
                      height: 20,
                      width: 20,
                      color: isDarkModeOn ? Colors.white : null,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              title:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.location_pin,
                    size: 15,
                    color:
                        isDarkModeOn ? Color(0xFF03506F) : Color(0xFF141E61)),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  prefs.getString('location').toString() + ",Kenya",
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                )
              ]),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: CircleAvatar(
                    radius: 15,
                    backgroundImage: AssetImage('images/add-user.png'),
                  ),
                ),
              ],
            )
          : null,
      body: _selectedPageIndex == 0
          ? SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  //Find the ideal car for you
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'Find the ideal car for you',
                      style: TextStyle(
                          fontSize: 45,
                          fontFamily: 'NunitoSans Bold',
                          color: isDarkModeOn
                              ? Colors.grey[200]
                              : Colors.grey[700]),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  //Search Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: TextField(
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: Icon(Icons.search),
                          hintText: "Find any car...",
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300))),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),

                  //Categories
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      height: 50,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: ((context, index) => GestureDetector(
                              onTap: (() {
                                setState(() {
                                  _listViewSelectedIndex = index;
                                });
                              }),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Text(
                                      _carCategories[index],
                                      style: TextStyle(
                                          color: _listViewSelectedIndex == index
                                              ? Theme.of(context).primaryColor
                                              : Colors.grey[700],
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  if (_listViewSelectedIndex == index)
                                    Container(
                                      width: 6,
                                      height: 6,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(12.0)),
                                    )
                                ],
                              ),
                            )),
                        itemCount: _carCategories.length,
                      ),
                    ),
                  ),
                  //Horizontal Listview of cars
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, bottom: 20.0),
                    child: Row(children: [
                      Text(
                        "Available Near You",
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0),
                      ),
                      Spacer(),
                      Text(
                        "View All",
                        style: TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.underline,
                        ),
                      )
                    ]),
                  ),
                  //Vertical ListView of Reccomended Cars
                  //List
                  Container(
                    height: 300,
                    child: Expanded(
                      child: ListView.builder(
                          itemCount: _availableCars.length,
                          itemBuilder: ((context, index) => AvailableCarTile(
                              title: _availableCars[index]['title'],
                              imageUrl: _availableCars[index]['image'],
                              brandUrl: _availableCars[index]['brand'],
                              price: _availableCars[index]['price']))),
                    ),
                  ),
                ],
              ),
            )
          : _pages[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.grey[900],
          currentIndex: _selectedPageIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey[500],
          onTap: _selectedPage,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: '',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), label: ''),
          ]),
    );
  }
}
