import 'package:flutter/material.dart';
import 'package:juniper/core/widgets/button.dart';
import 'package:juniper/core/widgets/investment_modal.dart';

class InvestmentModalExample extends StatelessWidget {
  const InvestmentModalExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Investment Modal Example'),
      ),
      body: Center(
        child: CustomButton(
          text: 'Show Investment Modal',
          onPressed: () {
            InvestmentModal.show(
              context,
              balance: 5000.00,
              propertyTitle: 'Luxury Condo in Downtown',
              onInvest: (amount, method) {
                // Process the investment
                final methodName =
                    method == PaymentMethod.wallet ? 'Wallet' : 'Credit Card';
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Invested \$$amount using $methodName'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
