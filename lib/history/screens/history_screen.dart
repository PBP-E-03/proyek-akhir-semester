import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pbp_e_03_flutter/history/components/donation_history_tab.dart';
import 'package:pbp_e_03_flutter/history/components/tab_bar_component.dart';
import 'package:pbp_e_03_flutter/history/components/transaction_history_tab.dart';
import 'package:pbp_e_03_flutter/history/models/history_model.dart';
import 'package:pbp_e_03_flutter/history/services/history_service.dart';
import 'package:pbp_e_03_flutter/home/components/bottom_navigation_bar_component.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: FutureBuilder(
          future: HistoryService.getHistory(),
          builder: (BuildContext context, AsyncSnapshot<History> snapshot) {
            if (snapshot.hasError) {
              Future.delayed(Duration.zero).then((value) =>
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(snapshot.error.toString()))));
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "History",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      // give the tab bar a height [can change hheight to preferred height]
                      TabBarComponent(controller: _tabController),
                      // tab bar view here
                      Expanded(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                // first tab bar view widget
                                DonationHistoryTab(
                                    donations: snapshot
                                        .data!.content!.donationHistory),

                                // second tab bar view widget
                                TransactionHistoryTab(
                                    transactions: snapshot
                                        .data!.content!.transactionHistory)
                              ],
                            )),
                      ),
                    ],
                  ));
            }
          },
        )),
        bottomNavigationBar: const BottomNavigationBarComponents(
          currentPage: 'History',
        ));
  }
}
