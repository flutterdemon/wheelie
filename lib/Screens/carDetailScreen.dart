import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wheelie/main.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';

class CarDetailScreen extends StatefulWidget {
  const CarDetailScreen(
      {Key? key,
      required this.imagePath,
      required this.name,
      required this.logoPath,
      required this.price})
      : super(key: key);
  final imagePath, name, logoPath, price;

  @override
  State<CarDetailScreen> createState() => _CarDetailScreenState();
}

class _CarDetailScreenState extends State<CarDetailScreen> {
  late TextEditingController _amountController;
  late TextEditingController _phoneNoController;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _amountController = TextEditingController();
    _phoneNoController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _phoneNoController.dispose();
    super.dispose();
  }

  Future<dynamic> lipaNaMpesa(
      {required double amount, required String phoneNo}) async {
    dynamic transactionInitialization;

    try {
      transactionInitialization = await MpesaFlutterPlugin.initializeMpesaSTKPush(
          businessShortCode: "174379",
          transactionType: TransactionType.CustomerPayBillOnline,
          amount: amount,
          partyA: phoneNo,
          partyB: "174379",
          callBackURL: Uri.parse('https://sandbox.safaricom.co.ke/'),
          accountReference: "Wheelie Bookings LTD",
          phoneNumber: phoneNo,
          baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
          passKey:
              'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919',
          transactionDesc: "Test");
      print("Results: " + transactionInitialization.toString());
      return transactionInitialization;
    } catch (e) {
      print("Caught MPESA Excepion: " + e.toString());
    }
  }

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
              tag: widget.imagePath,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
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
                      image: AssetImage(widget.imagePath),
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
                            text: widget.price,
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
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20.0))),
                        context: context,
                        builder: (BuildContext context) {
                          return Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: SizedBox(
                              height: 450,
                              child: Form(
                                key: _formKey,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        PaymentTile(
                                            title: 'M-PESA',
                                            backgroundColor: Color(0xFF2cb349),
                                            textColor: Colors.white),
                                        PaymentTile(
                                            title: "Paypal",
                                            backgroundColor: Colors.white,
                                            textColor: Colors.grey),
                                        PaymentTile(
                                            title: "Card",
                                            backgroundColor: Colors.white,
                                            textColor: Colors.grey),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                              'images/icons/M-PESA_LOGO.svg',
                                              height: 100),
                                          Spacer(),
                                          Column(
                                            children: [
                                              Text(
                                                "Enter Amount & ",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                "Mobile Number",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    //Input Fields for amount and number
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, bottom: 15),
                                      child: Text(
                                        "Amount",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey[600]),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Please enter amount";
                                          }
                                          final n =
                                              num.tryParse(value.toString());
                                          if (n == null || n < 1) {
                                            return "Please enter a valid amount";
                                          }
                                          return null;
                                        },
                                        controller: _amountController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            hintText: "Amount in Ksh",
                                            fillColor: Colors.grey[300],
                                            filled: true,
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    //Phone Number
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, bottom: 15),
                                      child: Text(
                                        "Phone Number",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey[600]),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Please enter phone number";
                                          }

                                          if (value.length < 10) {
                                            return "Please enter a valid phone number";
                                          }
                                          return null;
                                        },
                                        controller: _phoneNoController,
                                        keyboardType: TextInputType.phone,
                                        decoration: InputDecoration(
                                            hintText: "Mobile digits",
                                            fillColor: Colors.grey[300],
                                            filled: true,
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    //Submit Button
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: Row(
                                        children: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    color: Color(0xFF00c4cc)),
                                              )),
                                          Spacer(),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: Color(0xFF00c4cc),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0))),
                                              onPressed: () {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  lipaNaMpesa(
                                                      amount: double.parse(
                                                          _amountController
                                                              .text),
                                                      phoneNo:
                                                          _phoneNoController
                                                              .text);

                                                  print("Paying now ...");
                                                }
                                              },
                                              child: Text("Pay Booking"))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  },
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
                  ),
                )),
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

class PaymentTile extends StatelessWidget {
  const PaymentTile({
    Key? key,
    required this.title,
    required this.backgroundColor,
    required this.textColor,
  }) : super(key: key);
  final String title;
  final Color backgroundColor;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        title,
        style: TextStyle(color: textColor),
      ),
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
