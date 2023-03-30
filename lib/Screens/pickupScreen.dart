import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:wheelie/Screens/homeScreen.dart';

import 'package:wheelie/main.dart';

class PickUpScreen extends StatefulWidget {
  PickUpScreen({Key? key}) : super(key: key);

  @override
  State<PickUpScreen> createState() => _PickUpScreenState();
}

class _PickUpScreenState extends State<PickUpScreen> {
  late TextEditingController _pickUpController;
  late TextEditingController _dropOfController;

  List<dynamic> _cities = [];
  String? _selectedCity;
  final _formKey = GlobalKey<FormState>();
  final dropdownState = GlobalKey<FormFieldState>();

  @override
  void initState() {
    super.initState();
    loadCityData();
    _pickUpController = TextEditingController();
    _dropOfController = TextEditingController();
  }

  @override
  void dispose() {
    _pickUpController.dispose();
    _dropOfController.dispose();
    super.dispose();
  }

  Future<void> loadCityData() async {
    String jsonCities = await rootBundle.loadString('assets/kenya_cities.json');
    List<dynamic> cities = jsonDecode(jsonCities);
    setState(() {
      _cities = cities;
      log("Am I really working?");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Color(0xFF04293A),
        child: ClipPath(
            clipper: CustomClipPath(),
            child: Container(
              color: Color(0xFF0F3460),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Rent a car",
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    DatePickField(
                        title: "Pick-Up Date *", controller: _pickUpController),
                    SizedBox(
                      height: 15.0,
                    ),
                    DatePickField(
                      controller: _dropOfController,
                      title: "Drop-Of Date *",
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          Text(
                            "Pick-Up Location *",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 15.0, left: 15.0),
                            child: DropdownButtonFormField(
                                dropdownColor: Color(0xFF323232),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select location';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  fillColor: Colors.grey,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                ),
                                items: _cities
                                    .map((city) => DropdownMenuItem(
                                          child: Text(
                                            city['city'],
                                            style: TextStyle(
                                                color: Colors.white70),
                                          ),
                                          value: city['city'],
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedCity = value.toString();
                                    print(_selectedCity);
                                  });
                                },
                                value: _selectedCity),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Color(0xFF00c4cc)),
                        width: MediaQuery.of(context).size.width * 0.65,
                        height: 50.0,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              prefs.setString(
                                  'pick-up-date', _pickUpController.text);
                              prefs.setString(
                                  'drop-of-date', _dropOfController.text);
                              prefs.setString(
                                  'location', _selectedCity.toString());
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (_) => HomeScreen()));
                            }
                          },
                          child: Text(
                            "Search",
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

class DatePickField extends StatefulWidget {
  const DatePickField({
    Key? key,
    required TextEditingController controller,
    required this.title,
  })  : dateController = controller,
        super(key: key);

  final TextEditingController dateController;
  final String title;

  @override
  State<DatePickField> createState() => _DatePickFieldState();
}

class _DatePickFieldState extends State<DatePickField> {
  @override
  Widget build(BuildContext context) {
    DateTime? _pickUpTime;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Text(
            widget.title,
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15.0, left: 15.0),
            child: TextFormField(
              controller: widget.dateController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "please pick a date";
                }
                return null;
              },
              readOnly: true,
              onTap: () async {
                _pickUpTime = await showRoundedDatePicker(
                  context: context,
                  theme: ThemeData.dark(),
                  initialDate: DateTime.now().add(new Duration(minutes: 5)),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(DateTime.now().year + 1),
                );
                if (_pickUpTime != null) {
                  setState(() {
                    String formattedDate = DateFormat('EEEE, MMM d, yyyy')
                        .format(_pickUpTime as DateTime);
                    widget.dateController.text = formattedDate;
                  });
                }
              },
              decoration: InputDecoration(
                  labelText: "dd/mm/yyyy",
                  fillColor: Colors.grey,
                  filled: true,
                  suffixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          )
        ],
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path0 = Path();

    path0.moveTo(size.width, size.height * 0.0015244);
    path0.cubicTo(
        size.width * 0.0543500,
        size.height * -0.0010061,
        size.width * 0.7939500,
        size.height * 0.1904268,
        0,
        size.height * 0.2275000);
    path0.cubicTo(
        size.width * 0.0005688,
        size.height * 0.4208689,
        size.width * 0.0017063,
        size.height * 0.8076067,
        size.width * 0.0022750,
        size.height * 1.0009756);
    path0.cubicTo(
        size.width * 0.8381250,
        size.height * 0.8990244,
        size.width * 0.2415250,
        size.height * 0.7658384,
        size.width * 0.9977250,
        size.height * 0.7596037);
    path0.cubicTo(
        size.width * 0.9982937,
        size.height * 0.5700838,
        size.width * 0.9982937,
        size.height * 0.5700838,
        size.width,
        size.height * 0.0015244);
    path0.close();

    return path0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
