import 'package:flutter/material.dart';
import 'package:pbp_e_03_flutter/history/models/history_model.dart';
import 'package:intl/intl.dart';

class DonationHistoryTab extends StatelessWidget {
  const DonationHistoryTab({super.key, required this.donations});
  final List<DonationHistory> donations;

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('MMM d, yyyy');

    return donations.isNotEmpty
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
                                donations[index].country,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                              donations[index].person != null
                                  ? Text.rich(
                                      TextSpan(
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600),
                                          children: [
                                            const TextSpan(
                                              text: "Donate For",
                                            ),
                                            const WidgetSpan(
                                              child: SizedBox(
                                                width: 5,
                                              ),
                                            ),
                                            TextSpan(
                                                text:
                                                    "${donations[index].person}",
                                                style: const TextStyle(
                                                    color: Colors.green))
                                          ]),
                                    )
                                  : const Text("")
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
                                      Icons.forest,
                                      size: 18,
                                      color: Colors.green,
                                    )),
                                    const WidgetSpan(
                                      child: SizedBox(
                                        width: 5,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "${donations[index].amount}",
                                    )
                                  ]),
                            ),
                            Text(formatter.format(donations[index].date))
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
            itemCount: donations.length)
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Center(
                  child: Text(
                "You have not donated any tree yet.",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )),
              Center(
                child: Text(
                  "Let's Donate!",
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          );
    ;
  }
}
