import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pbp_e_03_flutter/history/models/history_model.dart';

class TransactionHistoryTab extends StatelessWidget {
  const TransactionHistoryTab({super.key, required this.transactions});
  final List<TransactionHistory> transactions;

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('MMM d, yyyy');

    return transactions.isNotEmpty
        ? ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 5,
                color: Colors.white,
                child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                transactions[index].productName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                              Text.rich(
                                TextSpan(
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600),
                                    children: [
                                      const TextSpan(
                                        text: "Amount:",
                                      ),
                                      const WidgetSpan(
                                        child: SizedBox(
                                          width: 5,
                                        ),
                                      ),
                                      TextSpan(
                                          text:
                                              "${transactions[index].productAmount}",
                                          style: const TextStyle(
                                              color: Colors.green))
                                    ]),
                              )
                            ]),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text.rich(
                              TextSpan(
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600),
                                  children: [
                                    const WidgetSpan(
                                        child: Icon(
                                      Icons.monetization_on,
                                      size: 18,
                                      color: Colors.orange,
                                    )),
                                    const WidgetSpan(
                                      child: SizedBox(
                                        width: 5,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          "${transactions[index].transactionAmount}",
                                    )
                                  ]),
                            ),
                            Text(formatter.format(transactions[index].date))
                          ],
                        )
                      ],
                    )),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(
                  height: 5,
                ),
            itemCount: transactions.length)
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Center(
                  child: Text(
                "No transaction's record found.",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )),
              Center(
                child: Text(
                  "Let's go to the market!",
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          );
  }
}
