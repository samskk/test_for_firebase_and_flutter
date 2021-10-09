import 'package:flutter/material.dart';
import 'package:medical_erp/models/cafe_model.dart';
// import 'package:medical_erp/models/order.dart';
import 'package:provider/provider.dart';

class CafeView extends StatelessWidget {
  const CafeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('provider ewample'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text('Provider Example'),
            Consumer<CafeModel>(
              builder: (context, model, child) {
                if (model.dailySpecial != null) {
                  return Text(model.dailySpecial!.fancyDescription());
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            ElevatedButton(
                onPressed: () => {
                      Provider.of<CafeModel>(context, listen: false)
                          .repriceDailySecial()
                    },
                child: const Text("Randomize price")),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "ORDERS",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Consumer<CafeModel>(
              builder: (context, model, child) {
                return Expanded(
                  child: ListView(
                    children: [
                      ...model.order.map(
                        (order) => Card(
                          child: ListTile(
                            leading: const Icon(Icons.local_cafe_outlined),
                            title: Text(order.description),
                            subtitle:
                                Text('${order.customerName}\$${order.price}'),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
