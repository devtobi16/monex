import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:monex/viewCard.dart';

class AddNewCard extends StatefulWidget {
  const AddNewCard({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AddNewCardState();
}

class AddNewCardState extends State<AddNewCard> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  late String userUid;

  @override
  void initState() {
    super.initState();
    // Get the currently authenticated user's UID
    getUserUid();
  }

  void getUserUid() {
    // Check if there is a currently authenticated user
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userUid = user.uid;
      });
    } else {
      // Handle the case where no user is signed in
    }
  }

  void storeUserCard(String number, String expiry, String cvv, String name) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userUid)
        .collection('cards')
        .add({
      'name': name,
      'number': number,
      'cvv': cvv,
      'expiry': expiry
    }).then((value) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ViewCard(
            cardNumber: this.cardNumber,
            expiryDate: this.expiryDate,
            cardHolderName: this.cardHolderName,
            cvvCode: this.cvvCode,
          ),
        ),
      );

      print('Card details saved successfully!');
    }).catchError((error) {
      print('Failed to save card details: $error');
    });
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      this.cardNumber = creditCardModel.cardNumber; // Use 'this' keyword here
      this.expiryDate = creditCardModel.expiryDate; // Use 'this' keyword here
      this.cardHolderName =
          creditCardModel.cardHolderName; // Use 'this' keyword here
      this.cvvCode = creditCardModel.cvvCode; // Use 'this' keyword here
      this.isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  final OutlineInputBorder border = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey.withOpacity(0.7),
      width: 2.0,
    ),
  );
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light,
    );
    return MaterialApp(
      title: 'Flutter Credit Card View Demo',
      themeMode: ThemeMode.light,
      theme: ThemeData.light(),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                bankName: 'Monex',
                frontCardBorder: Border.all(color: Colors.grey),
                backCardBorder: Border.all(color: Colors.grey),
                showBackView: isCvvFocused,
                obscureCardNumber: true,
                obscureCardCvv: true,
                isHolderNameVisible: true,
                cardBgColor: Colors.blue,
                isSwipeGestureEnabled: true,
                onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      CreditCardForm(
                        formKey: formKey,
                        obscureCvv: true,
                        obscureNumber: true,
                        cardNumber: cardNumber,
                        cvvCode: cvvCode,
                        isHolderNameVisible: true,
                        isCardNumberVisible: true,
                        isExpiryDateVisible: true,
                        cardHolderName: cardHolderName,
                        expiryDate: expiryDate,
                        inputConfiguration: const InputConfiguration(
                          cardNumberDecoration: InputDecoration(
                            labelText: 'Number',
                            labelStyle: TextStyle(color: Colors.black),
                            hintText: 'XXXX XXXX XXXX XXXX',
                            hintStyle: TextStyle(color: Colors.black),
                          ),
                          expiryDateDecoration: InputDecoration(
                            labelText: 'Expiry Date',
                            labelStyle: TextStyle(color: Colors.black),
                            hintText: 'XX/XX',
                            hintStyle: TextStyle(color: Colors.black),
                          ),
                          cvvCodeDecoration: InputDecoration(
                            labelText: 'CVV',
                            labelStyle: TextStyle(color: Colors.black),
                            hintText: 'XXX',
                            hintStyle: TextStyle(color: Colors.black),
                          ),
                          cardHolderDecoration: InputDecoration(
                            labelText: 'Card Holder',
                            labelStyle: TextStyle(color: Colors.black),
                          ),
                        ),
                        onCreditCardModelChange: onCreditCardModelChange,
                      ),
                      GestureDetector(
                        onTap: () {
                          storeUserCard(
                              cardNumber, expiryDate, cvvCode, cardHolderName);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          alignment: Alignment.center,
                          child: const Text(
                            'Save',
                            style: TextStyle(
                              color: Colors.white, // Change color to blue
                              fontSize: 14,
                              package: 'flutter_credit_card',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
