// All hardcoded demo data for the Diagnostic Center App

class Patient {
  final String id;
  final String name;
  final String relation;
  final int age;
  final String gender;
  final String bloodGroup;

  Patient({
    required this.id,
    required this.name,
    required this.relation,
    required this.age,
    required this.gender,
    required this.bloodGroup,
  });
}

class TestCategory {
  final String id;
  final String name;
  final String icon;
  final String color;

  TestCategory({required this.id, required this.name, required this.icon, required this.color});
}

class LabTest {
  final String id;
  final String name;
  final String categoryId;
  final double price;
  final String sampleType;
  final String reportDelivery;
  final String preparation;
  final String description;
  final bool isPopular;

  LabTest({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.price,
    required this.sampleType,
    required this.reportDelivery,
    required this.preparation,
    required this.description,
    this.isPopular = false,
  });
}

class TestPackage {
  final String id;
  final String name;
  final String description;
  final double originalPrice;
  final double discountedPrice;
  final List<String> testNames;
  final String badge;

  TestPackage({
    required this.id,
    required this.name,
    required this.description,
    required this.originalPrice,
    required this.discountedPrice,
    required this.testNames,
    required this.badge,
  });
}

class Booking {
  final String id;
  final String testName;
  final String patientName;
  final String date;
  final String timeSlot;
  final String collectionType; // "home" or "lab"
  final String status;
  final double amount;
  final String paymentStatus;

  Booking({
    required this.id,
    required this.testName,
    required this.patientName,
    required this.date,
    required this.timeSlot,
    required this.collectionType,
    required this.status,
    required this.amount,
    required this.paymentStatus,
  });
}

class Report {
  final String id;
  final String testName;
  final String patientName;
  final String date;
  final String status;

  Report({
    required this.id,
    required this.testName,
    required this.patientName,
    required this.date,
    required this.status,
  });
}

class DiagnosticCenter {
  final String id;
  final String name;
  final String address;
  final double distance;
  final double rating;
  final String timing;
  final bool isOpen;

  DiagnosticCenter({
    required this.id,
    required this.name,
    required this.address,
    required this.distance,
    required this.rating,
    required this.timing,
    required this.isOpen,
  });
}

class AppData {
  // ── Patients ──────────────────────────────────────────────────────────────
  static List<Patient> patients = [
    Patient(id: 'p1', name: 'Rahim Hossain', relation: 'Self', age: 35, gender: 'Male', bloodGroup: 'B+'),
    Patient(id: 'p2', name: 'Fatema Hossain', relation: 'Wife', age: 30, gender: 'Female', bloodGroup: 'A+'),
    Patient(id: 'p3', name: 'Anik Hossain', relation: 'Son', age: 8, gender: 'Male', bloodGroup: 'B+'),
    Patient(id: 'p4', name: 'Rahela Begum', relation: 'Mother', age: 60, gender: 'Female', bloodGroup: 'O+'),
  ];

  // ── Test Categories ────────────────────────────────────────────────────────
  static List<TestCategory> categories = [
    TestCategory(id: 'c1', name: 'Blood', icon: '🩸', color: 'red'),
    TestCategory(id: 'c2', name: 'Imaging', icon: '🫁', color: 'blue'),
    TestCategory(id: 'c3', name: 'Hormone', icon: '⚗️', color: 'purple'),
    TestCategory(id: 'c4', name: 'Urine', icon: '🧪', color: 'amber'),
    TestCategory(id: 'c5', name: 'Cardiac', icon: '❤️', color: 'pink'),
    TestCategory(id: 'c6', name: 'Diabetes', icon: '💉', color: 'orange'),
    TestCategory(id: 'c7', name: 'Thyroid', icon: '🦋', color: 'teal'),
    TestCategory(id: 'c8', name: 'Allergy', icon: '🌿', color: 'green'),
  ];

  // ── Lab Tests ─────────────────────────────────────────────────────────────
  static List<LabTest> tests = [
    LabTest(id: 't1', name: 'CBC (Complete Blood Count)', categoryId: 'c1', price: 350, sampleType: 'Blood', reportDelivery: '6 hours', preparation: 'Fasting not required', description: 'Measures different components of blood including red cells, white cells and platelets.', isPopular: true),
    LabTest(id: 't2', name: 'Blood Sugar (Fasting)', categoryId: 'c6', price: 120, sampleType: 'Blood', reportDelivery: '4 hours', preparation: 'Fasting required for 8-10 hours', description: 'Measures glucose level in blood after fasting.', isPopular: true),
    LabTest(id: 't3', name: 'HbA1c', categoryId: 'c6', price: 600, sampleType: 'Blood', reportDelivery: '24 hours', preparation: 'No special preparation', description: 'Average blood sugar over the past 2-3 months.', isPopular: true),
    LabTest(id: 't4', name: 'Thyroid Profile (TSH, T3, T4)', categoryId: 'c7', price: 900, sampleType: 'Blood', reportDelivery: '24 hours', preparation: 'Morning collection preferred', description: 'Evaluates thyroid gland function.'),
    LabTest(id: 't5', name: 'Lipid Profile', categoryId: 'c1', price: 700, sampleType: 'Blood', reportDelivery: '12 hours', preparation: 'Fasting required for 12 hours', description: 'Measures cholesterol and triglycerides levels.'),
    LabTest(id: 't6', name: 'Liver Function Test (LFT)', categoryId: 'c1', price: 800, sampleType: 'Blood', reportDelivery: '24 hours', preparation: 'Fasting for 4-6 hours recommended', description: 'Evaluates liver function and detects liver disease.'),
    LabTest(id: 't7', name: 'Kidney Function Test (KFT)', categoryId: 'c1', price: 750, sampleType: 'Blood', reportDelivery: '12 hours', preparation: 'Stay hydrated', description: 'Checks how well your kidneys are working.'),
    LabTest(id: 't8', name: 'Urine R/E (Routine Exam)', categoryId: 'c4', price: 150, sampleType: 'Urine', reportDelivery: '4 hours', preparation: 'Collect mid-stream morning sample', description: 'Analyses urine for infections and kidney issues.'),
    LabTest(id: 't9', name: 'ECG / EKG', categoryId: 'c5', price: 500, sampleType: 'N/A', reportDelivery: '1 hour', preparation: 'Avoid caffeine before test', description: 'Records electrical activity of the heart.', isPopular: true),
    LabTest(id: 't10', name: 'Chest X-Ray', categoryId: 'c2', price: 400, sampleType: 'N/A', reportDelivery: '2 hours', preparation: 'Remove metal jewelry', description: 'Imaging of chest to detect lung and heart conditions.'),
    LabTest(id: 't11', name: 'USG Abdomen', categoryId: 'c2', price: 1200, sampleType: 'N/A', reportDelivery: '3 hours', preparation: 'Fasting for 6 hours required', description: 'Ultrasound imaging of abdominal organs.'),
    LabTest(id: 't12', name: 'Testosterone (Total)', categoryId: 'c3', price: 800, sampleType: 'Blood', reportDelivery: '24 hours', preparation: 'Morning collection preferred', description: 'Measures testosterone hormone level.'),
    LabTest(id: 't13', name: 'Vitamin D', categoryId: 'c1', price: 1100, sampleType: 'Blood', reportDelivery: '48 hours', preparation: 'No special preparation', description: 'Checks Vitamin D level in blood.'),
    LabTest(id: 't14', name: 'Iron Studies', categoryId: 'c1', price: 950, sampleType: 'Blood', reportDelivery: '24 hours', preparation: 'Fasting for 8 hours', description: 'Evaluates iron levels and storage in body.'),
  ];

  // ── Test Packages ─────────────────────────────────────────────────────────
  static List<TestPackage> packages = [
    TestPackage(id: 'pk1', name: 'Basic Health Checkup', description: 'Essential tests for overall health', originalPrice: 2500, discountedPrice: 1499, testNames: ['CBC', 'Blood Sugar', 'Urine R/E', 'Lipid Profile'], badge: 'Most Popular'),
    TestPackage(id: 'pk2', name: 'Diabetes Care Package', description: 'Complete diabetes monitoring', originalPrice: 1800, discountedPrice: 1099, testNames: ['Blood Sugar (Fasting)', 'HbA1c', 'Urine Microalbumin', 'Kidney Function'], badge: 'Best Value'),
    TestPackage(id: 'pk3', name: 'Heart Health Package', description: 'Comprehensive cardiac checkup', originalPrice: 3200, discountedPrice: 1999, testNames: ['ECG', 'Lipid Profile', 'CRP', 'Blood Pressure'], badge: 'Doctor Recommended'),
    TestPackage(id: 'pk4', name: 'Women\'s Wellness', description: 'Complete women\'s health panel', originalPrice: 5000, discountedPrice: 2999, testNames: ['CBC', 'Thyroid Profile', 'Iron Studies', 'Vitamin D', 'Hormonal Panel'], badge: 'New'),
    TestPackage(id: 'pk5', name: 'Senior Citizen Package', description: 'Full body checkup for 50+', originalPrice: 6500, discountedPrice: 3999, testNames: ['CBC', 'LFT', 'KFT', 'ECG', 'Chest X-Ray', 'Blood Sugar', 'Thyroid'], badge: 'Comprehensive'),
  ];

  // ── Bookings ──────────────────────────────────────────────────────────────
  static List<Booking> bookings = [
    Booking(id: 'b1', testName: 'CBC (Complete Blood Count)', patientName: 'Rahim Hossain', date: '2025-03-15', timeSlot: '9:00 AM - 10:00 AM', collectionType: 'home', status: 'Sample Collected', amount: 350, paymentStatus: 'Paid'),
    Booking(id: 'b2', testName: 'Basic Health Checkup Package', patientName: 'Fatema Hossain', date: '2025-03-18', timeSlot: '8:00 AM - 9:00 AM', collectionType: 'home', status: 'Processing', amount: 1499, paymentStatus: 'Paid'),
    Booking(id: 'b3', testName: 'ECG / EKG', patientName: 'Rahim Hossain', date: '2025-03-20', timeSlot: '11:00 AM - 12:00 PM', collectionType: 'lab', status: 'Report Ready', amount: 500, paymentStatus: 'Paid'),
    Booking(id: 'b4', testName: 'Thyroid Profile', patientName: 'Rahela Begum', date: '2025-03-22', timeSlot: '7:00 AM - 8:00 AM', collectionType: 'home', status: 'Confirmed', amount: 900, paymentStatus: 'Cash on Collection'),
    Booking(id: 'b5', testName: 'Blood Sugar (Fasting)', patientName: 'Anik Hossain', date: '2025-02-10', timeSlot: '8:00 AM - 9:00 AM', collectionType: 'lab', status: 'Report Ready', amount: 120, paymentStatus: 'Paid'),
    Booking(id: 'b6', testName: 'Lipid Profile', patientName: 'Rahim Hossain', date: '2025-01-25', timeSlot: '9:00 AM - 10:00 AM', collectionType: 'home', status: 'Report Ready', amount: 700, paymentStatus: 'Paid'),
  ];

  // ── Reports ────────────────────────────────────────────────────────────────
  static List<Report> reports = [
    Report(id: 'r1', testName: 'CBC (Complete Blood Count)', patientName: 'Rahim Hossain', date: '2025-03-15', status: 'Available'),
    Report(id: 'r2', testName: 'ECG / EKG', patientName: 'Rahim Hossain', date: '2025-03-20', status: 'Available'),
    Report(id: 'r3', testName: 'Blood Sugar (Fasting)', patientName: 'Anik Hossain', date: '2025-02-10', status: 'Available'),
    Report(id: 'r4', testName: 'Lipid Profile', patientName: 'Rahim Hossain', date: '2025-01-25', status: 'Available'),
    Report(id: 'r5', testName: 'Basic Health Checkup Package', patientName: 'Fatema Hossain', date: '2025-03-18', status: 'Processing'),
  ];

  // ── Nearby Centers ─────────────────────────────────────────────────────────
  static List<DiagnosticCenter> nearbyCenters = [
    DiagnosticCenter(id: 'dc1', name: 'HealthFirst Diagnostics', address: 'House 12, Road 5, Dhanmondi, Dhaka', distance: 0.8, rating: 4.8, timing: '7 AM - 10 PM', isOpen: true),
    DiagnosticCenter(id: 'dc2', name: 'MedLab Center', address: 'Plot 45, Gulshan Avenue, Dhaka', distance: 1.5, rating: 4.6, timing: '8 AM - 9 PM', isOpen: true),
    DiagnosticCenter(id: 'dc3', name: 'Labaid Diagnostics', address: 'Mirpur Road, Shyamoli, Dhaka', distance: 2.1, rating: 4.9, timing: '6 AM - 11 PM', isOpen: true),
    DiagnosticCenter(id: 'dc4', name: 'Popular Diagnostics', address: 'Panthapath, Dhaka', distance: 2.8, rating: 4.5, timing: '7 AM - 10 PM', isOpen: false),
    DiagnosticCenter(id: 'dc5', name: 'Ibn Sina Diagnostic', address: 'Uttara, Sector 7, Dhaka', distance: 4.2, rating: 4.7, timing: '24 Hours', isOpen: true),
  ];

  // ── Blood Sugar Trend (for Health Dashboard) ───────────────────────────────
  static List<Map<String, dynamic>> bloodSugarTrend = [
    {'date': 'Oct', 'value': 112},
    {'date': 'Nov', 'value': 105},
    {'date': 'Dec', 'value': 118},
    {'date': 'Jan', 'value': 99},
    {'date': 'Feb', 'value': 108},
    {'date': 'Mar', 'value': 102},
  ];

  static List<Map<String, dynamic>> cholesterolTrend = [
    {'date': 'Oct', 'value': 210},
    {'date': 'Nov', 'value': 198},
    {'date': 'Dec', 'value': 215},
    {'date': 'Jan', 'value': 205},
    {'date': 'Feb', 'value': 195},
    {'date': 'Mar', 'value': 190},
  ];

  // ── Offers / Coupons ────────────────────────────────────────────────────────
  static List<Map<String, String>> coupons = [
    {'code': 'FIRST20', 'discount': '20% off', 'description': 'First time user discount'},
    {'code': 'HEALTH10', 'discount': '10% off', 'description': 'All packages'},
    {'code': 'CBC50', 'discount': '৳50 off', 'description': 'On CBC test'},
  ];

  // ── Time Slots ─────────────────────────────────────────────────────────────
  static List<String> timeSlots = [
    '7:00 AM', '8:00 AM', '9:00 AM', '10:00 AM',
    '11:00 AM', '12:00 PM', '1:00 PM', '2:00 PM',
    '3:00 PM', '4:00 PM', '5:00 PM', '6:00 PM',
  ];
}
