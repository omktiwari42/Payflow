import 'package:flutter/material.dart';

class WeeklySpendingChart extends StatefulWidget {
  const WeeklySpendingChart({super.key});

  @override
  State<WeeklySpendingChart> createState() =>
      _WeeklySpendingChartState();
}

class _WeeklySpendingChartState
    extends State<WeeklySpendingChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final List<double> values = [
    45,
    80,
    60,
    110,
    150,
    125,
    90,
  ];

  final List<String> days = [
    "M",
    "T",
    "W",
    "T",
    "F",
    "S",
    "S",
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final maxValue =
        values.reduce((a, b) => a > b ? a : b);

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: const Color(0xFFF1F5F9),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  "Weekly Spending",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(.12),
                  borderRadius:
                      BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.trending_up,
                      color: Colors.green,
                      size: 16,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "+18%",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          const Text(
            "₹12,450 spent this week",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 30),

          SizedBox(
            height: 180,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (_, __) {
                return Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.end,
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    values.length,
                    (index) {
                      final height =
                          (values[index] / maxValue) *
                              120 *
                              _controller.value;

                      return Column(
                        mainAxisAlignment:
                            MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 34,
                            height: height,
                            decoration:
                                BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(
                                      14),
                              gradient:
                                  const LinearGradient(
                                begin:
                                    Alignment.topCenter,
                                end: Alignment
                                    .bottomCenter,
                                colors: [
                                  Color(0xFF60A5FA),
                                  Color(0xFF2563EB),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(
                              height: 12),

                          Text(
                            days[index],
                            style:
                                const TextStyle(
                              fontWeight:
                                  FontWeight.w600,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(
                        0xFFF8FAFC),
                    borderRadius:
                        BorderRadius.circular(
                            18),
                  ),
                  child: const Column(
                    children: [
                      Text(
                        "Highest",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "₹3,120",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(
                        0xFFF8FAFC),
                    borderRadius:
                        BorderRadius.circular(
                            18),
                  ),
                  child: const Column(
                    children: [
                      Text(
                        "Average",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "₹1,780",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}