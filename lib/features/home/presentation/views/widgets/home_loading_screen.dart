import 'package:filehive/core/utils/other_constants.dart';
import 'package:flutter/material.dart';

class HomeLoadingScreen extends StatelessWidget {
  const HomeLoadingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: generalBorderRadius10),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 20,
              width: 60,
              decoration: BoxDecoration(
                  borderRadius: generalBorderRadius10,
                  color: Colors.black.withOpacity(0.06)),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 140,
                    decoration: BoxDecoration(
                        borderRadius: generalBorderRadius10,
                        color: Colors.black.withOpacity(0.06)),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: 70,
                        decoration: BoxDecoration(
                            borderRadius: generalBorderRadius10,
                            color: Colors.black.withOpacity(0.06)),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 70,
                              decoration: BoxDecoration(
                                  borderRadius: generalBorderRadius10,
                                  color: Colors.black.withOpacity(0.06)),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Container(
                              height: 70,
                              decoration: BoxDecoration(
                                  borderRadius: generalBorderRadius10,
                                  color: Colors.black.withOpacity(0.06)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
