import 'package:flutter/material.dart';

class TimeInputDrawer extends StatelessWidget {
  final TextEditingController hoursController;
  final TextEditingController minutesController;
  final TextEditingController secondsController;

  const TimeInputDrawer({
    super.key,
    required this.hoursController,
    required this.minutesController,
    required this.secondsController,
  });

  Widget _buildField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "0",
            hintStyle: const TextStyle(color: Colors.white38),
            filled: true,
            fillColor: Colors.white10,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black87,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            const Text(
              "Thiết lập thời gian",
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            const SizedBox(height: 24),
            _buildField("Giờ", hoursController),
            const SizedBox(height: 16),
            _buildField("Phút", minutesController),
            const SizedBox(height: 16),
            _buildField("Giây", secondsController),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).maybePop(),
              icon: const Icon(Icons.check),
              label: const Text("Xác nhận"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            )
          ],
        ),
      ),
    );
  }
}
