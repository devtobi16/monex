import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class ViewCard extends StatefulWidget {
  final String cardNumber;
  final String expiryDate;
  final String cardHolderName;
  final String cvvCode;

  ViewCard({
    required this.cardNumber,
    required this.expiryDate,
    required this.cardHolderName,
    required this.cvvCode,
  });

  @override
  State<ViewCard> createState() => _ViewCardState();
}

class _ViewCardState extends State<ViewCard> {
  late String cardNumber;
  late String expiryDate;
  late String cardHolderName;
  late String cvvCode;

  @override
  void initState() {
    super.initState();
    // Set state variables with constructor arguments
    cardNumber = widget.cardNumber;
    expiryDate = widget.expiryDate;
    cardHolderName = widget.cardHolderName;
    cvvCode = widget.cvvCode;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: true,
                obscureCardNumber: true,
                obscureCardCvv: true,
                cardBgColor: Colors.blue,
                bankName: 'Monex',
                onCreditCardWidgetChange: (CreditCardBrand) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
