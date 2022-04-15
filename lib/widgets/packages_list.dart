import 'package:amusic_app/models/package.dart';
import 'package:esewa_pnp/esewa.dart';
import 'package:esewa_pnp/esewa_pnp.dart';
import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class PackagesList extends StatelessWidget {
  List<Package> packagesList = [];
  String selectedPaymentMethod = '';
  PackagesList(
      {Key? key,
      required this.packagesList,
      required this.selectedPaymentMethod})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: packagesList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: InkWell(
              onTap: () async {
                if (selectedPaymentMethod == 'esewa') {
                  try {
                    ESewaConfiguration _configuration = ESewaConfiguration(
                        clientID:
                            "JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R",
                        secretKey: "BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==",
                        environment: ESewaConfiguration
                            .ENVIRONMENT_TEST //ENVIRONMENT_LIVE
                        );
                    ESewaPnp _eSewaPnp =
                        ESewaPnp(configuration: _configuration);
                    ESewaPayment _payment = ESewaPayment(
                        amount: packagesList[index].price.toDouble(),
                        productName: packagesList[index].name,
                        productID: packagesList[index].id.toString(),
                        callBackURL:
                            "http://ec2-13-126-202-84.ap-south-1.compute.amazonaws.com/amusic/backend/web/index.php/api/payment/esewa");
                    final _res = await _eSewaPnp.initPayment(payment: _payment);
                  } on ESewaPaymentException catch (e) {
                    // Handle error
                  }
                } else {
                  final config = PaymentConfig(
                    amount: packagesList[index].price *
                        100, // Amount should be in paisa
                    productIdentity: packagesList[index].name,
                    productName: packagesList[index].name,
                    productUrl: 'https://www.khalti.com/#/bazaar',
                    additionalData: {
                      // Not mandatory; can be used for reporting purpose
                      'vendor': 'Khalti Bazaar',
                    },
                  );
                  KhaltiScope.of(context).pay(
                    config: config,
                    preferences: [
                      PaymentPreference.connectIPS,
                      PaymentPreference.eBanking,
                      PaymentPreference.sct,
                    ],
                    onSuccess: (successModel) {
                      // Perform Server Verification
                    },
                    onFailure: (failureModel) {
                      // What to do on failure?
                    },
                    onCancel: () {
                      // User manually cancelled the transaction
                    },
                  );
                }
              },
              child: InkWell(child: Text(packagesList[index].name)),
            ),
          );
        });
  }
}
