import 'package:flutter/material.dart';
import 'package:mentora_app/core/assets_manager.dart';

class CoinsScreen extends StatelessWidget {
  const CoinsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF1D24CA);
    const Color coinsOrange = Color(0xFFDA8B00);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, color: primaryBlue),
                    ),
                    const Text(
                      'Coins',
                      style: TextStyle(
                        color: primaryBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 18,
                      child: Icon(Icons.person, color: primaryBlue),
                    ),
                  ],
                ),
              ),
          
              const SizedBox(height: 10),
          
              // Coins Balance Box
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Image.asset(AssetsManager.coins, width: 50, height: 50),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Your Coins Balance',
                            style: TextStyle(
                              color: coinsOrange,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '20,000',
                            style: TextStyle(
                              color: coinsOrange,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
          
              const SizedBox(height: 40),
              const Text(
                'Welcome to a world full of rewards!',
                style: TextStyle(
                  color: primaryBlue,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
          
              const SizedBox(height: 40),
          
              // Decorated Voucher Grid Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildVoucherItem(
                        AssetsManager.voucher200,
                        '40,000 Coins',
                        costColor: coinsOrange,
                      ),
                      _buildVoucherItem(
                        AssetsManager.voucher500,
                        '100,000 Coins',
                        costColor: coinsOrange,
                      ),
                      _buildVoucherItem(
                        AssetsManager.voucher1000,
                        '200,000 Coins',
                        costColor: coinsOrange,
                      ),
                      _buildVoucherItem(
                        AssetsManager.voucher3000,
                        '500,000 Coins',
                        costColor: coinsOrange,
                      ),
                    ],
                  ),
                ),
              ),
              
              // Redeem Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      'Redeem Coins',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVoucherItem(
    String imagePath,
    String costText, {
    Color costColor = Colors.black87,
  }) {
    return Column(
      children: [
        Expanded(child: Image.asset(imagePath, fit: BoxFit.contain)),
        const SizedBox(height: 6),
        Text(
          costText,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: costColor,
          ),
        ),
      ],
    );
  }
}
