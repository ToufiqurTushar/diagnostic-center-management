import 'package:example/config/app_widgets.dart';
import 'package:flutter/material.dart';
import '../../../config/app_theme.dart';
import '../../../data/app_data.dart';
import 'booking_confirm_view.dart';

class BookingView extends StatefulWidget {
  static const routeName = '/booking';
  final String testName;
  final double testPrice;

  const BookingView({super.key, required this.testName, required this.testPrice});

  @override
  State<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
  String _collectionType = 'home'; // 'home' or 'lab'
  String? _selectedPatient;
  String? _selectedDate;
  String? _selectedTime;
  String _couponCode = '';
  bool _couponApplied = false;

  String get _selectedPatientName => _selectedPatient == null
      ? 'Select Patient'
      : AppData.patients.firstWhere((p) => p.id == _selectedPatient).name;

  double get _finalPrice => _couponApplied ? widget.testPrice * 0.8 : widget.testPrice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Test')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Test summary
          AppCard(child: Row(children: [
            Container(
              width: 44, height: 44,
              decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.science_outlined, color: AppColors.primary, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(widget.testName, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: AppColors.textDark)),
              const Text('Lab Test', style: TextStyle(color: AppColors.textGrey, fontSize: 12)),
            ])),
            Text('৳${widget.testPrice.toInt()}', style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.primary, fontSize: 16)),
          ])),

          const SizedBox(height: 20),

          // Collection type
          const Text('Collection Type', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: AppColors.textDark)),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: _collectionTypeCard('home', '🏠', 'Home Collection', 'Technician visits you')),
            const SizedBox(width: 12),
            Expanded(child: _collectionTypeCard('lab', '🏥', 'Lab Visit', 'Visit nearest center')),
          ]),

          const SizedBox(height: 20),

          // Select Patient
          const Text('Select Patient', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: AppColors.textDark)),
          const SizedBox(height: 12),
          SizedBox(
            height: 70,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: AppData.patients.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, i) {
                final patient = AppData.patients[i];
                final isSelected = _selectedPatient == patient.id;
                return GestureDetector(
                  onTap: () => setState(() => _selectedPatient = patient.id),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: isSelected ? AppColors.primary : AppColors.divider),
                    ),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(patient.name, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: isSelected ? Colors.white : AppColors.textDark)),
                      Text(patient.relation, style: TextStyle(fontSize: 11, color: isSelected ? Colors.white70 : AppColors.textGrey)),
                    ]),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          // Date Selection
          const Text('Select Date', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: AppColors.textDark)),
          const SizedBox(height: 12),
          SizedBox(
            height: 70,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 7,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, i) {
                final date = DateTime.now().add(Duration(days: i));
                final dayLabel = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'][date.weekday % 7];
                final dateStr = '${date.day}/${date.month}';
                final isSelected = _selectedDate == dateStr;
                return GestureDetector(
                  onTap: () => setState(() => _selectedDate = dateStr),
                  child: Container(
                    width: 58,
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: isSelected ? AppColors.primary : AppColors.divider),
                    ),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(dayLabel, style: TextStyle(fontSize: 11, color: isSelected ? Colors.white70 : AppColors.textGrey, fontWeight: FontWeight.w600)),
                      Text('${date.day}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: isSelected ? Colors.white : AppColors.textDark)),
                    ]),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          // Time Slots
          const Text('Select Time Slot', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: AppColors.textDark)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10, runSpacing: 10,
            children: AppData.timeSlots.map((slot) {
              final isSelected = _selectedTime == slot;
              return GestureDetector(
                onTap: () => setState(() => _selectedTime = slot),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: isSelected ? AppColors.primary : AppColors.divider),
                  ),
                  child: Text(slot, style: TextStyle(color: isSelected ? Colors.white : AppColors.textDark, fontSize: 12, fontWeight: FontWeight.w600)),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 20),

          // Coupon
          const Text('Apply Coupon', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: AppColors.textDark)),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(
              child: TextField(
                onChanged: (v) => setState(() => _couponCode = v),
                decoration: const InputDecoration(hintText: 'Enter coupon code', prefixIcon: Icon(Icons.discount_outlined)),
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () => setState(() => _couponApplied = _couponCode.toUpperCase() == 'FIRST20'),
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14)),
              child: const Text('Apply'),
            ),
          ]),
          if (_couponApplied)
            const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text('✅ 20% discount applied!', style: TextStyle(color: AppColors.success, fontWeight: FontWeight.w600, fontSize: 13)),
            ),

          const SizedBox(height: 20),

          // Price summary
          AppCard(child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text('Test Price', style: TextStyle(color: AppColors.textGrey)),
              Text('৳${widget.testPrice.toInt()}', style: const TextStyle(fontWeight: FontWeight.w600)),
            ]),
            if (_couponApplied) ...[
              const SizedBox(height: 8),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text('Discount (20%)', style: TextStyle(color: AppColors.success)),
                Text('-৳${(widget.testPrice * 0.2).toInt()}', style: const TextStyle(color: AppColors.success, fontWeight: FontWeight.w600)),
              ]),
            ],
            const Divider(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text('Total', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: AppColors.textDark)),
              Text('৳${_finalPrice.toInt()}', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: AppColors.primary)),
            ]),
          ])),

          const SizedBox(height: 30),
        ]),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: FullButton(
          'Proceed to Payment',
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => BookingConfirmView(
            testName: widget.testName,
            patientName: _selectedPatientName,
            date: _selectedDate ?? 'Not selected',
            time: _selectedTime ?? 'Not selected',
            collectionType: _collectionType,
            amount: _finalPrice,
          ))),
        ),
      ),
    );
  }

  Widget _collectionTypeCard(String type, String emoji, String title, String subtitle) {
    final isSelected = _collectionType == type;
    return GestureDetector(
      onTap: () => setState(() => _collectionType = type),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryLight : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: isSelected ? AppColors.primary : AppColors.divider, width: isSelected ? 1.5 : 1),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(emoji, style: const TextStyle(fontSize: 24)),
          const SizedBox(height: 8),
          Text(title, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: isSelected ? AppColors.primary : AppColors.textDark)),
          Text(subtitle, style: const TextStyle(color: AppColors.textGrey, fontSize: 11)),
        ]),
      ),
    );
  }
}
