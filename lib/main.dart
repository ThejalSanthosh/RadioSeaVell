import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:radio_sea_well/app/data/bindings/initial_bindings.dart';
import 'package:radio_sea_well/app/routes/app_pages.dart';
import 'package:radio_sea_well/app/theme/app_theme.dart';
import 'package:radio_sea_well/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options:
        DefaultFirebaseOptions
            .currentPlatform, // Ensure this is defined correctly
  );
  //   final dashboardController = Get.put(DashboardController());
  // await dashboardController.initializeData();
  // uploadAvoorUpdatedStores();
  // uploadThiruvidaicheriUpdatedStores();
  // uploadKudavasalUpdatedStores();
  // uploadKoradacheriUpdatedStores();
  // uploadAaduthurai2UpdatedStores();
  // uploadThirukattupalliUpdatedStores();
  // uploadTPazhurUpdatedStores();
  // uploadAyyampettaiUpdatedStores();
  // uploadKabisthalamUpdatedStores();
  // uploadPapanasamUpdatedStores();
  // uploadThirunageswaramUpdatedStores();
  // uploadPoraiyarUpdatedStores();
  // uploadDevanancheriUpdatedStores();
  // uploadKumbakonamUpdatedStores();
  runApp(
    GetMaterialApp(
      title: 'Radio Seevel Management',
      initialBinding: InitialBinding(),

      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}

Future<void> uploadKumbakonamUpdatedStores() async {
  final firestore = FirebaseFirestore.instance;

  final stores = [
    {'name': 'காயத்ரி', 'englishName': 'GAYATRI', 'balanceAmount': 0.0},
    {'name': 'சின்னதுரை', 'englishName': 'SINNADURAI', 'balanceAmount': 0.0},
    {'name': 'ஏழுமலையான்', 'englishName': 'EZHUMALAIYAN', 'balanceAmount': 0.0},
    {'name': 'சையு', 'englishName': 'SAYYU', 'balanceAmount': 0.0},
    {'name': 'காளியம்மாள்', 'englishName': 'KALIYAMMAL', 'balanceAmount': 0.0},
    {'name': 'மாரியம்மாள்', 'englishName': 'MARIYAMMAL', 'balanceAmount': 0.0},
    {'name': 'VSV வெற்றி', 'englishName': 'VSV VETRI', 'balanceAmount': 924.0},
    {'name': 'மணி', 'englishName': 'MANI', 'balanceAmount': 7500.0},
    {'name': 'இளையராஜா', 'englishName': 'ILAYARAJA', 'balanceAmount': 1800.0},
    {'name': 'ராபியா', 'englishName': 'RABIYA', 'balanceAmount': 0.0},
    {'name': 'அமீர்', 'englishName': 'AMEER', 'balanceAmount': 0.0},
    {'name': 'ஓம் சக்தி', 'englishName': 'OM SAKTHI', 'balanceAmount': 0.0},
    {'name': 'நெல்லை', 'englishName': 'NELLAI', 'balanceAmount': 6865.0},
    {'name': 'பரோஸ்', 'englishName': 'PARESH', 'balanceAmount': 0.0},
    {'name': 'நவமணி -I', 'englishName': 'NAVAMANI-I', 'balanceAmount': 0.0},
    {'name': 'குமரன்', 'englishName': 'KUMAR', 'balanceAmount': 0.0},
    {'name': 'SAN', 'englishName': 'SAN', 'balanceAmount': 4650.0},
    {'name': 'பாஸ்கர்', 'englishName': 'BASKAR', 'balanceAmount': 0.0},
    {'name': 'ராஜாத்தி', 'englishName': 'RAJATHI', 'balanceAmount': 3380.0},
    {
      'name': 'சேகர் ‌இன்னம்யூர்',
      'englishName': 'SEKAR INNAMYUR',
      'balanceAmount': 0.0,
    },
    {'name': 'சேகர்', 'englishName': 'SEKAR', 'balanceAmount': 0.0},
    {'name': 'செட்டியார்', 'englishName': 'CHETTIYAR', 'balanceAmount': 0.0},
    {'name': 'MKR', 'englishName': 'MKR', 'balanceAmount': 1118.0},
    {'name': 'முருகன்', 'englishName': 'MURUGAN', 'balanceAmount': 0.0},
    {'name': 'PMVK', 'englishName': 'PMVK', 'balanceAmount': 1184.0},
    {'name': 'சாமிநாதன்', 'englishName': 'SAMINADHAN', 'balanceAmount': 2100.0},
    {'name': 'சத்யா', 'englishName': 'SATYA', 'balanceAmount': 0.0},
    {
      'name': 'சாந்தி கமலி',
      'englishName': 'SANTHI KAMALI',
      'balanceAmount': 900.0,
    },
    {
      'name': 'விஷ்வ லிங்கம்',
      'englishName': 'VISHVALINGAM',
      'balanceAmount': 0.0,
    },
    {'name': 'சர்வேஷ்', 'englishName': 'SARVESH', 'balanceAmount': 0.0},
    {'name': 'மரகதம்', 'englishName': 'MARAGADHAM', 'balanceAmount': 1500.0},
    {'name': 'சண்முகா', 'englishName': 'SANMUGA', 'balanceAmount': 0.0},
    {'name': 'R.S', 'englishName': 'R.S', 'balanceAmount': 0.0},
    {
      'name': 'ராஜ் மல்லிகா',
      'englishName': 'RAJMALLIGA',
      'balanceAmount': 5580.0,
    },
    {'name': 'தங்கையன்', 'englishName': 'THANGAIYAN', 'balanceAmount': 1256.0},
    {'name': 'கல்யாணி', 'englishName': 'KALYANI', 'balanceAmount': 1488.0},
    {'name': 'அட்சயா', 'englishName': 'ATCHAYA', 'balanceAmount': 0.0},
    {
      'name': 'வசந்த உதயம்',
      'englishName': 'VASANDHA UDHAYM',
      'balanceAmount': 0.0,
    },
    {'name': 'மாதா ஸ்டோர்', 'englishName': 'MADHA STORE', 'balanceAmount': 0.0},
    {'name': 'லாவண்யா', 'englishName': 'LAVANYA', 'balanceAmount': 3720.0},
    {
      'name': 'சுந்தரமூர்த்தி',
      'englishName': 'SUNDHARAMOORTHY',
      'balanceAmount': 0.0,
    },
    {'name': 'ஶ்ரீரங்கன்', 'englishName': 'SRIRANJAN', 'balanceAmount': 0.0},
    {
      'name': 'வசந்தகுமார்',
      'englishName': 'VASANDHAKUMAR',
      'balanceAmount': 0.0,
    },
    {'name': 'SMS சாய்', 'englishName': 'SMS SAI', 'balanceAmount': 100.0},
    {'name': 'செல்வி', 'englishName': 'SELVI', 'balanceAmount': 3032.0},
    {
      'name': 'வெங்கடேஸ்வரா',
      'englishName': 'VENGADESHWARA',
      'balanceAmount': 986.0,
    },
    {'name': 'குமார்', 'englishName': 'KUMAR', 'balanceAmount': 0.0},
    {'name': 'நேஷனல்', 'englishName': 'NATIONAL', 'balanceAmount': 0.0},
    {'name': 'பிஸ்மி', 'englishName': 'BISMI', 'balanceAmount': 0.0},
    {
      'name': 'பாஸ்கர் பீடா',
      'englishName': 'BASKAR BEEDA',
      'balanceAmount': 0.0,
    },
  ];

  final batch = firestore.batch();

  for (final store in stores) {
    final docRef = firestore.collection('stores').doc();

    batch.set(docRef, {
      'name': store['name'],
      'englishName': store['englishName'],
      'district': 'கும்பகோணம்',
      'address': 'கும்பகோணம்',
      'phone': '',
      'email': '',
      'balanceAmount': store['balanceAmount'],
      'currentBalance': store['balanceAmount'],
      'totalTransactions': 0,
      'lastTransactionDate': '',
      'UpdatedAt': FieldValue.serverTimestamp(),
    });
  }

  await batch.commit();

  print('Successfully uploaded ${stores.length} Kumbakonam stores');
}

Future<void> uploadDevanancheriUpdatedStores() async {
  final firestore = FirebaseFirestore.instance;

  final stores = [
    {'name': 'J.S', 'englishName': 'J.S', 'balanceAmount': 0.0},
    {'name': 'A.K.M', 'englishName': 'A.K.M', 'balanceAmount': 0.0},
    {'name': 'சாந்தி', 'englishName': 'SANTHI', 'balanceAmount': 2809.0},
    {
      'name': 'ரூபதர்ஷினி',
      'englishName': 'ROOPADHARSHINI',
      'balanceAmount': 0.0,
    },
    {'name': 'கவி ஜெய்', 'englishName': 'KAVIJAI', 'balanceAmount': 0.0},
    {'name': 'ஜெயா', 'englishName': 'JEYA', 'balanceAmount': 0.0},
    {
      'name': 'சண்முகநாதன்',
      'englishName': 'SANMUGANADHAN',
      'balanceAmount': 0.0,
    },
    {'name': 'சண்முகம்', 'englishName': 'SANMUGAM', 'balanceAmount': 0.0},
    {'name': 'V.L.V.L', 'englishName': 'V.L.V.L', 'balanceAmount': 0.0},
    {
      'name': 'வெங்கடாசலம்',
      'englishName': 'VENGADASALAM',
      'balanceAmount': 0.0,
    },
    {'name': 'வேணு', 'englishName': 'VENU', 'balanceAmount': 3500.0},
    {'name': 'சுகுமார்', 'englishName': 'SUGUMAR', 'balanceAmount': 0.0},
    {'name': 'மோகன்', 'englishName': 'MOHAN', 'balanceAmount': 0.0},
    {'name': 'சன்மதி', 'englishName': 'SANMATHI', 'balanceAmount': 0.0},
    {'name': 'வைஸ்னவா', 'englishName': 'VAISHNAVA', 'balanceAmount': 1180.0},
    {'name': 'தீரன்', 'englishName': 'DEERAN', 'balanceAmount': 0.0},
    {'name': 'மீனாட்சி', 'englishName': 'MEENAKSHI', 'balanceAmount': 1900.0},
    {'name': 'குமரன்', 'englishName': 'KUMAR', 'balanceAmount': 0.0},
    {'name': 'G.P', 'englishName': 'G.P', 'balanceAmount': 0.0},
    {'name': 'ரஜினி', 'englishName': 'RAJINI', 'balanceAmount': 592.0},
    {'name': 'கண்ணையன்', 'englishName': 'KANNAIYAN', 'balanceAmount': 9450.0},
    {'name': 'செல்வம்', 'englishName': 'SELVAM', 'balanceAmount': 0.0},
    {'name': 'சுதாகர்', 'englishName': 'SUDHAKAR', 'balanceAmount': 0.0},
    {'name': 'காயத்ரி', 'englishName': 'GAYATRI', 'balanceAmount': 0.0},
    {'name': 'G.S', 'englishName': 'G.S', 'balanceAmount': 0.0},
    {'name': 'தமிழா', 'englishName': 'TAMILA', 'balanceAmount': 0.0},
    {'name': 'கோழிகடை', 'englishName': 'KOZHIKADAI', 'balanceAmount': 0.0},
    {'name': 'அம்மன்', 'englishName': 'AMMAN', 'balanceAmount': 0.0},
    {'name': 'ரஞ்சிதா', 'englishName': 'RANJITHA', 'balanceAmount': 5212.0},
    {'name': 'மகேந்திரன்', 'englishName': 'MAHENDIRAN', 'balanceAmount': 0.0},
    {'name': 'K.P', 'englishName': 'K.P', 'balanceAmount': 0.0},
    {'name': 'S.N.K', 'englishName': 'S.N.K', 'balanceAmount': 0.0},
    {'name': 'பத்மா', 'englishName': 'BADMA', 'balanceAmount': 4900.0},
    {'name': 'சந்தோஷ்', 'englishName': 'SANTHOSH', 'balanceAmount': 2532.0},
    {'name': 'ஜெயராமன்', 'englishName': 'JEYARAMAN', 'balanceAmount': 0.0},
    {'name': 'மித்ரன்', 'englishName': 'MITHRA', 'balanceAmount': 0.0},
    {'name': 'ராணி', 'englishName': 'RANI', 'balanceAmount': 3402.0},
    {'name': 'மளிகை', 'englishName': 'MALIGAI', 'balanceAmount': 0.0},
    {'name': 'குமார்', 'englishName': 'KUMAR', 'balanceAmount': 0.0},
    {
      'name': 'ராஜேந்திரன்',
      'englishName': 'RAJENDRAN',
      'balanceAmount': 4640.0,
    },
    {'name': 'தேசிகர்', 'englishName': 'THESIKAR', 'balanceAmount': 1690.0},
    {'name': 'முருகன்', 'englishName': 'MURUGAN', 'balanceAmount': 8028.0},
    {
      'name': 'சிங்கப்பெருமாள்',
      'englishName': 'SINGAPPERUMAL',
      'balanceAmount': 1430.0,
    },
    {'name': 'ஜனப்ரியா', 'englishName': 'JANAPRIYA', 'balanceAmount': 62580.0},
    {'name': 'மருதையன்', 'englishName': 'MARUDHAIYAN', 'balanceAmount': 0.0},
    {'name': 'மலர்', 'englishName': 'MALAR', 'balanceAmount': 1000.0},
    {
      'name': 'கல்லூர் ஸ்டோர்',
      'englishName': 'KALLUR STORE',
      'balanceAmount': 0.0,
    },
    {'name': 'R.K.P', 'englishName': 'R.K.P', 'balanceAmount': 1056.0},
    {
      'name': 'அன்னை பாத்திமா',
      'englishName': 'ANNAI FATHIMA',
      'balanceAmount': 15740.0,
    },
    {'name': 'A.K.N', 'englishName': 'A.K.N', 'balanceAmount': 0.0},
    {
      'name': 'லெட்சுமி விலாஸ்',
      'englishName': 'LAKSHMI VILAS',
      'balanceAmount': 1890.0,
    },
    {'name': 'திருப்பதி', 'englishName': 'TIRUPATI', 'balanceAmount': 0.0},
    {'name': 'சிந்துஜா', 'englishName': 'SINDHUJA', 'balanceAmount': 2250.0},
    {'name': 'செட்டியார்', 'englishName': 'CHETTIYAR', 'balanceAmount': 422.0},
    {
      'name': 'உமா மகேஸ்வரி',
      'englishName': 'UMA MAGESHWARI',
      'balanceAmount': 840.0,
    },
    {'name': 'A.P.R', 'englishName': 'A.P.R', 'balanceAmount': 762.0},
    {'name': 'மித்ரன்', 'englishName': 'MITHRAN', 'balanceAmount': 2496.0},
    {'name': 'அனேகா', 'englishName': 'ANEGA', 'balanceAmount': 13970.0},
    {'name': 'மரியா', 'englishName': 'MARIYA', 'balanceAmount': 1002.0},
    {'name': 'கத்ரவேல்', 'englishName': 'KADHRVEL', 'balanceAmount': 2400.0},
    {'name': 'விஷ்ணு', 'englishName': 'VISHNU', 'balanceAmount': 6100.0},
    {'name': 'ஆதேஸ்', 'englishName': 'ADHESH', 'balanceAmount': 4000.0},
    {
      'name': 'செந்தில் குமார்',
      'englishName': 'SENDHIL KUMAR',
      'balanceAmount': 200.0,
    },
    {'name': 'இந்தியன்', 'englishName': 'INDIAN', 'balanceAmount': 2490.0},
    {'name': 'ஆனந்தம்', 'englishName': 'AANANDHAM', 'balanceAmount': 848.0},
    {'name': 'பிரகாஷ்', 'englishName': 'PRAKASH', 'balanceAmount': 2100.0},
    {'name': 'சித்ரா', 'englishName': 'CHITHRA', 'balanceAmount': 790.0},
    {'name': 'டேவிட்', 'englishName': 'DAVID', 'balanceAmount': 5000.0},
    {'name': 'விஜய்', 'englishName': 'VIJAY', 'balanceAmount': 3800.0},
  ];

  final batch = firestore.batch();

  for (final store in stores) {
    final docRef = firestore.collection('stores').doc();

    batch.set(docRef, {
      'name': store['name'],
      'englishName': store['englishName'],
      'district': 'தேவனாஞ்சேரி',
      'address': 'தேவனாஞ்சேரி',
      'phone': '',
      'email': '',
      'balanceAmount': store['balanceAmount'],
      'currentBalance': store['balanceAmount'],
      'totalTransactions': 0,
      'lastTransactionDate': '',
      'UpdatedAt': FieldValue.serverTimestamp(),
    });
  }

  await batch.commit();

  print('Successfully uploaded ${stores.length} Devanancheri stores');
}

Future<void> uploadPoraiyarUpdatedStores() async {
  final firestore = FirebaseFirestore.instance;

  final stores = [
    {'name': 'S.K', 'englishName': 'S.K', 'balanceAmount': 0.0},
    {'name': 'சிவா', 'englishName': 'SIVA', 'balanceAmount': 3000.0},
    {'name': 'அன்பழகன்', 'englishName': 'ANBALAGAN', 'balanceAmount': 9178.0},
    {'name': 'பரகத்', 'englishName': 'BARAKATH', 'balanceAmount': 6730.0},
    {'name': 'தீன்', 'englishName': 'DEEN', 'balanceAmount': 0.0},
    {'name': 'பிரபா', 'englishName': 'PRABA', 'balanceAmount': 0.0},
    {
      'name': 'குழந்தை இயேசு',
      'englishName': 'KULANDHAI YESHU',
      'balanceAmount': 42.0,
    },
    {'name': 'சங்கர்', 'englishName': 'SANKAR', 'balanceAmount': 0.0},
    {'name': 'சாந்தி', 'englishName': 'SAANTHI', 'balanceAmount': 1300.0},
    {'name': 'ஹாஜி', 'englishName': 'HAJI', 'balanceAmount': 0.0},
    {'name': 'அப்ஸா', 'englishName': 'APSA', 'balanceAmount': 0.0},
    {'name': 'ஆயிஷா', 'englishName': 'AYESHA', 'balanceAmount': 0.0},
    {'name': 'நிலவு', 'englishName': 'NILAVU', 'balanceAmount': 0.0},
    {'name': 'சின்னையன்', 'englishName': 'SINNAYAN', 'balanceAmount': 1282.0},
    {'name': 'SKS', 'englishName': 'SKS', 'balanceAmount': 0.0},
    {'name': 'அம்மன்', 'englishName': 'AMMAN', 'balanceAmount': 1180.0},
    {'name': 'அழகி', 'englishName': 'ALAGI', 'balanceAmount': 342.0},
    {'name': 'முத்து', 'englishName': 'MUTHU', 'balanceAmount': 0.0},
    {'name': 'செந்தூர்', 'englishName': 'SENDHUR', 'balanceAmount': 0.0},
    {'name': 'அன்பு', 'englishName': 'ANBU', 'balanceAmount': 5.0},
    {'name': 'உபயக்', 'englishName': 'UBAYAK', 'balanceAmount': 4160.0},
    {'name': 'கர்ணன்', 'englishName': 'KARNAN', 'balanceAmount': 2842.0},
    {'name': 'கீர்த்தனா', 'englishName': 'KEERTHANA', 'balanceAmount': 0.0},
    {'name': 'MMM', 'englishName': 'MMM', 'balanceAmount': 688.0},
    {'name': 'தீன்', 'englishName': 'DEEN', 'balanceAmount': 0.0},
    {'name': 'கண்ணன்', 'englishName': 'KANNAN', 'balanceAmount': 0.0},
    {
      'name': 'AV மாரியப்பன்',
      'englishName': 'AV MARIYAPPAN',
      'balanceAmount': 0.0,
    },
    {'name': 'வடிவேல்', 'englishName': 'VADIVEL', 'balanceAmount': 0.0},
    {'name': 'சாமிநாதன்', 'englishName': 'SAMINADHAN', 'balanceAmount': 2480.0},
    {'name': 'தயாநிதி', 'englishName': 'DHAYANIDHI', 'balanceAmount': 943.0},
    {'name': 'சாமி', 'englishName': 'SAAMI', 'balanceAmount': 0.0},
    {'name': 'ஜெகன்', 'englishName': 'JEGAN', 'balanceAmount': 0.0},
    {
      'name': 'சந்திரசேகர்',
      'englishName': 'SANDHIRASEKAR',
      'balanceAmount': 500.0,
    },
    {'name': 'சரண்', 'englishName': 'SARAN', 'balanceAmount': 0.0},
    {'name': 'சாய்பாபா', 'englishName': 'SAIBABA', 'balanceAmount': 1476.0},
    {'name': 'ரவி', 'englishName': 'RAVI', 'balanceAmount': 1162.0},
    {'name': 'ராசி', 'englishName': 'RAASI', 'balanceAmount': 0.0},
    {'name': 'செல்வம்', 'englishName': 'SELVAM', 'balanceAmount': 0.0},
    {'name': 'சந்தோஷ்', 'englishName': 'SANTHOSH', 'balanceAmount': 3802.0},
    {'name': 'KRMJ', 'englishName': 'KRMJ', 'balanceAmount': 0.0},
    {'name': 'மோகன்', 'englishName': 'MOHAN', 'balanceAmount': 0.0},
    {'name': 'மாதவன்', 'englishName': 'MAADHAVAN', 'balanceAmount': 0.0},
    {'name': 'பிரபு', 'englishName': 'PRABU', 'balanceAmount': 245.0},
    {'name': 'வீர்ராஜ்', 'englishName': 'VEERRAJ', 'balanceAmount': 2215.0},
    {
      'name': 'சமயபுரம் ஶ்ரீ மகா மாரியம்மன்',
      'englishName': 'SAMAYAPURAM SRI MAGA MARIAMMAN',
      'balanceAmount': 3000.0,
    },
    {'name': 'ஶ்ரீராம்', 'englishName': 'SRIRAM', 'balanceAmount': 1260.0},
    {'name': 'சாய்', 'englishName': 'SAI', 'balanceAmount': 180.0},
    {'name': 'அக்பர் அலி', 'englishName': 'AKBAR ALI', 'balanceAmount': 3000.0},
    {'name': 'KSD', 'englishName': 'KSD', 'balanceAmount': 206.0},
    {
      'name': 'கார்த்திகேயன்',
      'englishName': 'KARTHIKEYAN',
      'balanceAmount': 168.0,
    },
    {'name': 'ரோஜா', 'englishName': 'ROJA', 'balanceAmount': 1050.0},
    {'name': 'பாலு', 'englishName': 'BALU', 'balanceAmount': 3490.0},
    {'name': 'KG', 'englishName': 'KG', 'balanceAmount': 1280.0},
    {'name': 'பிஸ்மில்லா', 'englishName': 'BISMILLAH', 'balanceAmount': 420.0},
    {'name': 'பழனி', 'englishName': 'PALANI', 'balanceAmount': 590.0},
    {'name': 'VK', 'englishName': 'VK', 'balanceAmount': 3400.0},
    {'name': 'பாலா-II', 'englishName': 'BALA-II', 'balanceAmount': 982.0},
    {'name': 'பாலா-I', 'englishName': 'BALA-I', 'balanceAmount': 998.0},
  ];

  final batch = firestore.batch();

  for (final store in stores) {
    final docRef = firestore.collection('stores').doc();

    batch.set(docRef, {
      'name': store['name'],
      'englishName': store['englishName'],
      'district': 'பொறையார்',
      'address': 'பொறையார்',
      'phone': '',
      'email': '',
      'balanceAmount': store['balanceAmount'],
      'currentBalance': store['balanceAmount'],
      'totalTransactions': 0,
      'lastTransactionDate': '',
      'UpdatedAt': FieldValue.serverTimestamp(),
    });
  }

  await batch.commit();

  print('Successfully uploaded ${stores.length} Poraiyar stores');
}

Future<void> uploadThirunageswaramUpdatedStores() async {
  final firestore = FirebaseFirestore.instance;

  final stores = [
    {'name': 'J.S', 'englishName': 'J.S', 'balanceAmount': 0.0},
    {'name': 'பாஸ்ட்', 'englishName': 'FAST', 'balanceAmount': 11880.0},
    {
      'name': 'ராஜகிரி பாய்',
      'englishName': 'RAJAGIRI BHAI',
      'balanceAmount': 0.0,
    },
    {'name': 'ஜெயம்', 'englishName': 'JEYAM', 'balanceAmount': 0.0},
    {'name': 'மாரியம்மன்', 'englishName': 'MARIAMMAN', 'balanceAmount': 3130.0},
    {'name': 'J.J', 'englishName': 'J.J', 'balanceAmount': 0.0},
    {'name': 'சம்பூர்ணம்', 'englishName': 'SAMPOORNAM', 'balanceAmount': 0.0},
    {'name': 'வேலன்', 'englishName': 'VELAN', 'balanceAmount': 0.0},
    {'name': 'கிருஷ்ணா', 'englishName': 'KRISHNA', 'balanceAmount': 1178.0},
    {'name': 'சாகுல்', 'englishName': 'SAHUL', 'balanceAmount': 4130.0},
    {'name': 'தமிழ்', 'englishName': 'TAMIL', 'balanceAmount': 1400.0},
    {'name': 'ரியாஸ்', 'englishName': 'RIYAS', 'balanceAmount': 0.0},
    {'name': 'ஹாஜி', 'englishName': 'HAJI', 'balanceAmount': 56120.0},
    {'name': 'J.P', 'englishName': 'J.P', 'balanceAmount': 0.0},
    {'name': 'சித்ரா', 'englishName': 'SITHRA', 'balanceAmount': 0.0},
    {'name': 'மாதா', 'englishName': 'MAADHAA', 'balanceAmount': 30000.0},
    {'name': 'பாட்டி', 'englishName': 'PAATTI', 'balanceAmount': 0.0},
    {'name': 'தனலெட்சுமி', 'englishName': 'DHANALAKSHMI', 'balanceAmount': 0.0},
    {'name': 'கீதா', 'englishName': 'GEETHA', 'balanceAmount': 0.0},
    {'name': 'விக்னேஷ்', 'englishName': 'VIGNESH', 'balanceAmount': 0.0},
    {'name': 'சுரேஷ்', 'englishName': 'SURESH', 'balanceAmount': 3380.0},
    {'name': 'R.P.M', 'englishName': 'R.P.M', 'balanceAmount': 6400.0},
    {'name': 'இலக்கியா', 'englishName': 'ILAKKIYA', 'balanceAmount': 0.0},
    {'name': 'மார்ஸ்', 'englishName': 'MARS', 'balanceAmount': 500.0},
    {'name': 'பாபு', 'englishName': 'BABU', 'balanceAmount': 3440.0},
    {'name': 'செல்வி', 'englishName': 'SELVI', 'balanceAmount': 0.0},
    {'name': 'நாகராஜன்', 'englishName': 'NAGARAJAN', 'balanceAmount': 0.0},
    {'name': 'இன்பயாழ்', 'englishName': 'INBAYAZH', 'balanceAmount': 0.0},
    {'name': 'பரகத்', 'englishName': 'BARAKATH', 'balanceAmount': 0.0},
    {'name': 'கோகுல்', 'englishName': 'GOKUL', 'balanceAmount': 0.0},
    {'name': 'ஜெயமணி', 'englishName': 'JEYAMANI', 'balanceAmount': 0.0},
    {'name': 'தீன்', 'englishName': 'DEEN', 'balanceAmount': 0.0},
    {'name': 'L.P.S', 'englishName': 'L.P.S', 'balanceAmount': 0.0},
    {'name': 'ஆனந்தம்', 'englishName': 'AANANDHAM', 'balanceAmount': 700.0},
    {
      'name': 'திருப்பதி',
      'englishName': 'THIRUPATHI',
      'balanceAmount': 14000.0,
    },
    {'name': 'பிஸ்மி', 'englishName': 'BISMI', 'balanceAmount': 700.0},
    {'name': 'மூர்த்தி', 'englishName': 'MOORTHY', 'balanceAmount': 1700.0},
    {'name': 'A.K.M', 'englishName': 'A.K.M', 'balanceAmount': 8835.0},
    {'name': 'SKP', 'englishName': 'SKP', 'balanceAmount': 21100.0},
    {
      'name': 'மாரியப்பன்',
      'englishName': 'MARIYAPPAN',
      'balanceAmount': 7930.0,
    },
    {'name': 'குப்தா', 'englishName': 'GUPTHA', 'balanceAmount': 1200.0},
    {'name': 'T.S', 'englishName': 'T.S', 'balanceAmount': 3024.0},
    {'name': 'R.K உமா', 'englishName': 'R.K UMA', 'balanceAmount': 1690.0},
  ];

  final batch = firestore.batch();

  for (final store in stores) {
    final docRef = firestore.collection('stores').doc();

    batch.set(docRef, {
      'name': store['name'],
      'englishName': store['englishName'],
      'district': 'திருநாகேஸ்வரம்',
      'address': 'திருநாகேஸ்வரம்',
      'phone': '',
      'email': '',
      'balanceAmount': store['balanceAmount'],
      'currentBalance': store['balanceAmount'],
      'totalTransactions': 0,
      'lastTransactionDate': '',
      'UpdatedAt': FieldValue.serverTimestamp(),
    });
  }

  await batch.commit();

  print('Successfully uploaded ${stores.length} Thirunageswaram stores');
}

Future<void> uploadPapanasamUpdatedStores() async {
  final firestore = FirebaseFirestore.instance;

  final stores = [
    {'name': 'ஆசிகா', 'englishName': 'ASIKA', 'balanceAmount': 2300.0},
    {'name': 'J.S', 'englishName': 'J.S', 'balanceAmount': 2710.0},
    {'name': 'S.S.A', 'englishName': 'S.S.A', 'balanceAmount': 0.0},
    {'name': 'சாதிக்', 'englishName': 'SADIK', 'balanceAmount': 0.0},
    {'name': 'பாபு', 'englishName': 'BABU', 'balanceAmount': 2540.0},
    {'name': 'சூர்யா', 'englishName': 'SURYA', 'balanceAmount': 0.0},
    {'name': 'ராஜா', 'englishName': 'RAJA', 'balanceAmount': 0.0},
    {'name': 'விநாயகா', 'englishName': 'VINAYAGA', 'balanceAmount': 0.0},
    {'name': 'பெமினா', 'englishName': 'FEMINA', 'balanceAmount': 0.0},
    {'name': 'முருகன்', 'englishName': 'MURUGAN', 'balanceAmount': 0.0},
    {'name': 'T.S.P', 'englishName': 'T.S.P', 'balanceAmount': 1900.0},
    {'name': 'Cash', 'englishName': 'CASH', 'balanceAmount': 0.0},
    {'name': 'G.K', 'englishName': 'G.K', 'balanceAmount': 26240.0},
    {'name': 'அன்வர்', 'englishName': 'ANWAR', 'balanceAmount': 32379.0},
    {'name': 'ஆரிப்', 'englishName': 'AARIF', 'balanceAmount': 0.0},
    {'name': 'கபூர்', 'englishName': 'GAFOOR', 'balanceAmount': 0.0},
    {
      'name': 'சந்திரன்-II',
      'englishName': 'SANDHIRAN-II',
      'balanceAmount': 26590.0,
    },
    {'name': 'குறிஞ்சி', 'englishName': 'KURINJI', 'balanceAmount': 47060.0},
    {
      'name': 'முத்து பீடா',
      'englishName': 'MUTHU BEEDA',
      'balanceAmount': 4640.0,
    },
    {'name': 'பாலு', 'englishName': 'BALU', 'balanceAmount': 0.0},
    {
      'name': 'கண்ணதாசன்',
      'englishName': 'KANNADHASAN',
      'balanceAmount': 3380.0,
    },
    {'name': 'நித்தீஸ்', 'englishName': 'NITHEESH', 'balanceAmount': 0.0},
  ];

  final batch = firestore.batch();

  for (final store in stores) {
    final docRef = firestore.collection('stores').doc();

    batch.set(docRef, {
      'name': store['name'],
      'englishName': store['englishName'],
      'district': 'பாபநாசம்',
      'address': 'பாபநாசம்',
      'phone': '',
      'email': '',
      'balanceAmount': store['balanceAmount'],
      'currentBalance': store['balanceAmount'],
      'totalTransactions': 0,
      'lastTransactionDate': '',
      'UpdatedAt': FieldValue.serverTimestamp(),
    });
  }

  await batch.commit();

  print('Successfully uploaded ${stores.length} Papanasam stores');
}

Future<void> uploadKabisthalamUpdatedStores() async {
  final firestore = FirebaseFirestore.instance;

  final stores = [
    {
      'name': 'ராமச்சந்திரன்',
      'englishName': 'RAMACHANDRAN',
      'balanceAmount': 0.0,
    },
    {'name': 'அண்ணாதுரை', 'englishName': 'ANNADURAI', 'balanceAmount': 0.0},
    {'name': 'ஜனனி', 'englishName': 'JANANI', 'balanceAmount': 5815.0},
    {'name': 'ஜெயா', 'englishName': 'JEYA', 'balanceAmount': 0.0},
    {'name': 'ஆவின்', 'englishName': 'AAVIN', 'balanceAmount': 0.0},
    {
      'name': 'கலியபெருமாள்',
      'englishName': 'KALIYAPERUMAL',
      'balanceAmount': 0.0,
    },
    {'name': 'ஆசீஸ்', 'englishName': 'AASIS', 'balanceAmount': 0.0},
    {'name': 'ஜெகன்', 'englishName': 'JEGAN', 'balanceAmount': 3380.0},
    {'name': 'தர்ஷினி', 'englishName': 'DHARSHINI', 'balanceAmount': 0.0},
    {'name': 'ஜெயம்', 'englishName': 'JEYAM', 'balanceAmount': 0.0},
    {'name': 'CASH', 'englishName': 'CASH', 'balanceAmount': 0.0},
    {'name': 'ரமேஷ்', 'englishName': 'RAMESH', 'balanceAmount': 0.0},
    {'name': 'ஆண்டாள்', 'englishName': 'AANDAAL', 'balanceAmount': 0.0},
    {'name': 'மோகன்', 'englishName': 'MOHAN', 'balanceAmount': 0.0},
    {'name': 'சாமி', 'englishName': 'SAMI', 'balanceAmount': 0.0},
    {'name': 'நேஷனல்', 'englishName': 'NATIONAL', 'balanceAmount': 0.0},
    {'name': 'அம்மன்', 'englishName': 'AMMAN', 'balanceAmount': 0.0},
    {'name': 'கிருஷ்ணா', 'englishName': 'KRISHNA', 'balanceAmount': 0.0},
    {'name': 'காமதேனு', 'englishName': 'KAAMADHENU', 'balanceAmount': 0.0},
    {'name': 'கோகுல்', 'englishName': 'GOKUL', 'balanceAmount': 0.0},
    {'name': 'M.S', 'englishName': 'M.S', 'balanceAmount': 0.0},
    {'name': 'மணிமுத்து', 'englishName': 'MANIMUTHU', 'balanceAmount': 100.0},
    {
      'name': 'வெங்கடாசலம்',
      'englishName': 'VENGADACHALAM',
      'balanceAmount': 0.0,
    },
    {'name': 'செல்வகுமார்', 'englishName': 'SELVAKUMAR', 'balanceAmount': 0.0},
    {'name': 'குமார்', 'englishName': 'KUMAR', 'balanceAmount': 0.0},
    {'name': 'மணிவேல்', 'englishName': 'MANIVEL', 'balanceAmount': 0.0},
    {'name': 'A.K.R', 'englishName': 'A.K.R', 'balanceAmount': 0.0},
    {'name': 'சக்தி', 'englishName': 'SAKTHI', 'balanceAmount': 0.0},
    {'name': 'இந்தியன்', 'englishName': 'INDIAN', 'balanceAmount': 0.0},
    {'name': 'விஜய்-I', 'englishName': 'VIJAY-I', 'balanceAmount': 0.0},
    {'name': 'விஜய்-II', 'englishName': 'VIJAY-II', 'balanceAmount': 0.0},
    {'name': 'விஜய்-III', 'englishName': 'VIJAY-III', 'balanceAmount': 0.0},
    {'name': 'சியா', 'englishName': 'SIYA', 'balanceAmount': 0.0},
    {'name': 'ஜோசப்', 'englishName': 'JOSEPH', 'balanceAmount': 0.0},
    {'name': 'கணபதி', 'englishName': 'GANAPATHY', 'balanceAmount': 0.0},
    {'name': 'M.K.M', 'englishName': 'M.K.M', 'balanceAmount': 0.0},
    {'name': 'தனம்', 'englishName': 'DHANAM', 'balanceAmount': 1000.0},
    {
      'name': 'கருனை ஆனந்தம்',
      'englishName': 'KARUNAI AANANDHAM',
      'balanceAmount': 0.0,
    },
    {'name': 'ஜெயராமன்', 'englishName': 'JEYARAMAN', 'balanceAmount': 0.0},
    {'name': 'இளையராஜா', 'englishName': 'ILAYARAJA', 'balanceAmount': 0.0},
    {'name': 'சுந்தரி', 'englishName': 'SUNDARI', 'balanceAmount': 600.0},
    {'name': 'சுரேஷ்', 'englishName': 'SURESH', 'balanceAmount': 0.0},
    {'name': 'G.K', 'englishName': 'G.K', 'balanceAmount': 10000.0},
    {'name': 'குறிஞ்சி', 'englishName': 'KURINJI', 'balanceAmount': 43760.0},
    {'name': 'பழனிவேல்', 'englishName': 'PAZHANIVEL', 'balanceAmount': 844.0},
    {'name': 'ஜோதி', 'englishName': 'JOTHI', 'balanceAmount': 3160.0},
    {'name': 'துர்கா', 'englishName': 'DURGA', 'balanceAmount': 1700.0},
    {'name': 'கண்ணன்', 'englishName': 'KANNAN', 'balanceAmount': 0.0},
    {'name': 'V.C.K', 'englishName': 'V.C.K', 'balanceAmount': 940.0},
  ];

  final batch = firestore.batch();

  for (final store in stores) {
    final docRef = firestore.collection('stores').doc();

    batch.set(docRef, {
      'name': store['name'],
      'englishName': store['englishName'],
      'district': 'கபிஸ்தலம்',
      'address': 'கபிஸ்தலம்',
      'phone': '',
      'email': '',
      'balanceAmount': store['balanceAmount'],
      'currentBalance': store['balanceAmount'],
      'totalTransactions': 0,
      'lastTransactionDate': '',
      'UpdatedAt': FieldValue.serverTimestamp(),
    });
  }

  await batch.commit();

  print('Successfully uploaded ${stores.length} Kabisthalam stores');
}

Future<void> uploadAyyampettaiUpdatedStores() async {
  final firestore = FirebaseFirestore.instance;

  final stores = [
    {'name': 'அரன்யா', 'englishName': 'ARANYA', 'balanceAmount': 0.0},
    {'name': 'CASH', 'englishName': 'CASH', 'balanceAmount': 0.0},
    {
      'name': 'மாஸ் அல்லாஹ்',
      'englishName': 'MASS ALLAH',
      'balanceAmount': 2156.0,
    },
    {'name': 'கருப்பையன்', 'englishName': 'KARUPPAYAN', 'balanceAmount': 0.0},
    {'name': 'ராதா', 'englishName': 'RADHA', 'balanceAmount': 0.0},
    {'name': 'பாலாஜி-I', 'englishName': 'BALAJI-I', 'balanceAmount': 0.0},
    {'name': 'முத்து பீடா', 'englishName': 'MUTHU BEEDA', 'balanceAmount': 0.0},
    {'name': 'ஆரிப்', 'englishName': 'AARIF', 'balanceAmount': 0.0},
    {'name': 'மதி', 'englishName': 'MATHI', 'balanceAmount': 0.0},
    {'name': 'விஸ்வா', 'englishName': 'VISHWA', 'balanceAmount': 0.0},
    {'name': 'டெல்டா', 'englishName': 'DELTA', 'balanceAmount': 0.0},
    {'name': 'மங்களம்', 'englishName': 'MANGALAM', 'balanceAmount': 0.0},
    {'name': 'முருகன்', 'englishName': 'MURUGAN', 'balanceAmount': 0.0},
    {'name': 'சக்தி', 'englishName': 'SAKTHI', 'balanceAmount': 0.0},
    {'name': 'பத்மநாபன்', 'englishName': 'PADHMANAPAN', 'balanceAmount': 0.0},
    {'name': 'சிவானந்தம்', 'englishName': 'SIVANANDHAM', 'balanceAmount': 0.0},
    {'name': 'வைகோ', 'englishName': 'VAIKO', 'balanceAmount': 0.0},
    {'name': 'ஐடியல்', 'englishName': 'IDEAL', 'balanceAmount': 0.0},
    {'name': 'கோபி', 'englishName': 'GOPI', 'balanceAmount': 0.0},
    {'name': 'தீன்', 'englishName': 'DEEN', 'balanceAmount': 0.0},
    {'name': 'எரிக்', 'englishName': 'ERIC', 'balanceAmount': 0.0},
    {'name': 'திருமலை', 'englishName': 'THIRUMALAI', 'balanceAmount': 3000.0},
    {'name': 'மார்ஸ்', 'englishName': 'MARS', 'balanceAmount': 0.0},
    {'name': 'ராமன்', 'englishName': 'RAMAN', 'balanceAmount': 0.0},
    {'name': 'குமார்', 'englishName': 'KUMAR', 'balanceAmount': 0.0},
    {'name': 'திருமங்கை', 'englishName': 'THIRUMANGAI', 'balanceAmount': 0.0},
    {'name': 'ராஜா', 'englishName': 'RAJA', 'balanceAmount': 0.0},
    {'name': 'பாஸ்கர்', 'englishName': 'BASKAR', 'balanceAmount': 0.0},
    {'name': 'M.K.M', 'englishName': 'M.K.M', 'balanceAmount': 0.0},
    {'name': 'T.S.S', 'englishName': 'T.S.S', 'balanceAmount': 0.0},
    {'name': 'கனகராஜ்', 'englishName': 'KANAGARAJ', 'balanceAmount': 0.0},
    {'name': 'சக்தி', 'englishName': 'SAKTHI', 'balanceAmount': 0.0},
    {'name': 'கணபதி', 'englishName': 'GANAPATHY', 'balanceAmount': 0.0},
    {'name': 'தென்றல்', 'englishName': 'THENDRAL', 'balanceAmount': 7180.0},
    {'name': 'பாஸ்கரன்', 'englishName': 'BASKARAN', 'balanceAmount': 0.0},
    {'name': 'மாரியம்மன்', 'englishName': 'MARIAMMAN', 'balanceAmount': 4360.0},
    {'name': 'தாமோதரன்', 'englishName': 'DHAMODHARAN', 'balanceAmount': 0.0},
    {'name': 'அம்மன்', 'englishName': 'AMMAN', 'balanceAmount': 0.0},
    {'name': 'உழவன்', 'englishName': 'UZHAVAN', 'balanceAmount': 0.0},
    {'name': 'மணிகண்டன்', 'englishName': 'MANIKANDAN', 'balanceAmount': 0.0},
    {
      'name': 'சஸ்வினி கருப்பையன்',
      'englishName': 'SASVINI KARUPPAYAN',
      'balanceAmount': 0.0,
    },
    {'name': 'பாண்டியன்', 'englishName': 'PANDIYAN', 'balanceAmount': 0.0},
    {
      'name': 'கிருஷ்ணமூர்த்தி',
      'englishName': 'KRISHNAMOORTHI',
      'balanceAmount': 0.0,
    },
    {'name': 'ஆழ்வார்', 'englishName': 'AALVAAR', 'balanceAmount': 0.0},
    {'name': 'மோகன்', 'englishName': 'MOHAN', 'balanceAmount': 0.0},
    {'name': 'மதி', 'englishName': 'MATHI', 'balanceAmount': 0.0},
    {'name': 'ஜோசப்', 'englishName': 'JOSEPH', 'balanceAmount': 0.0},
    {'name': 'பன்னீர்', 'englishName': 'PANNER', 'balanceAmount': 0.0},
    {
      'name': 'சந்திரன்-II',
      'englishName': 'SANDHIRAN-II',
      'balanceAmount': 14760.0,
    },
    {'name': 'G.K', 'englishName': 'G.K', 'balanceAmount': 24120.0},
    {'name': 'ராஜ்கனி', 'englishName': 'RAJKANI', 'balanceAmount': 21000.0},
    {'name': 'குறிஞ்சி', 'englishName': 'KURINJI', 'balanceAmount': 40500.0},
    {'name': 'T.S.P', 'englishName': 'T.S.P', 'balanceAmount': 0.0},
  ];

  final batch = firestore.batch();

  for (final store in stores) {
    final docRef = firestore.collection('stores').doc();

    batch.set(docRef, {
      'name': store['name'],
      'englishName': store['englishName'],
      'district': 'அய்யம்பேட்டை',
      'address': 'அய்யம்பேட்டை',
      'phone': '',
      'email': '',
      'balanceAmount': store['balanceAmount'],
      'currentBalance': store['balanceAmount'],
      'totalTransactions': 0,
      'lastTransactionDate': '',
      'UpdatedAt': FieldValue.serverTimestamp(),
    });
  }

  await batch.commit();

  print('Successfully uploaded ${stores.length} Ayyampettai stores');
}

Future<void> uploadTPazhurUpdatedStores() async {
  final firestore = FirebaseFirestore.instance;

  final stores = [
    {'name': 'பிரேமா', 'englishName': 'PREMA', 'balanceAmount': 0.0},
    {'name': 'அலி', 'englishName': 'ALI', 'balanceAmount': 6760.0},
    {'name': 'கருப்பர்', 'englishName': 'KARUPPAR', 'balanceAmount': 4860.0},
    {'name': 'பொன்னி', 'englishName': 'PONNI', 'balanceAmount': 34570.0},
    {'name': 'ராஜன்', 'englishName': 'RAJAN', 'balanceAmount': 0.0},
    {'name': 'பிரியம்', 'englishName': 'PIRIYAM', 'balanceAmount': 0.0},
    {'name': 'ஹாஜி', 'englishName': 'HAJI', 'balanceAmount': 0.0},
    {'name': 'வளர்மதி', 'englishName': 'VALARMATHI', 'balanceAmount': 0.0},
    {'name': 'G.S', 'englishName': 'G.S', 'balanceAmount': 0.0},
    {'name': 'தன்வந்திரி', 'englishName': 'THANVANDHIRI', 'balanceAmount': 0.0},
    {'name': 'ஆதி', 'englishName': 'AADHI', 'balanceAmount': 5100.0},
    {'name': 'யாழினி', 'englishName': 'YAZHINI', 'balanceAmount': 0.0},
    {'name': 'S.K', 'englishName': 'S,K', 'balanceAmount': 6072.0},
    {
      'name': 'தமிழ் அரசி',
      'englishName': 'TAMIL ARASI',
      'balanceAmount': 422.0,
    },
    {'name': 'சின்னப்பன்', 'englishName': 'SINNAPPAN', 'balanceAmount': 1600.0},
    {
      'name': 'சக்கரவர்த்தி',
      'englishName': 'SAKKARAVARTHI',
      'balanceAmount': 3380.0,
    },
    {'name': 'S.K', 'englishName': 'S.K', 'balanceAmount': 0.0},
    {'name': 'கார்த்தி', 'englishName': 'KARTHI', 'balanceAmount': 0.0},
    {'name': 'CASH', 'englishName': 'CASH', 'balanceAmount': 0.0},
    {'name': 'மகேந்திரன்', 'englishName': 'MAHENDHIRAN', 'balanceAmount': 0.0},
    {
      'name': 'சமயபுரத்தாள்',
      'englishName': 'SAMAYAPURATHAL',
      'balanceAmount': 0.0,
    },
    {'name': 'ஜனப்ரியா', 'englishName': 'JANAPRIYA', 'balanceAmount': 18760.0},
    {'name': 'விஜய்', 'englishName': 'VIJAY', 'balanceAmount': 0.0},
    {
      'name': 'வெங்கடேஸ்வரா',
      'englishName': 'VENGADESHWARA',
      'balanceAmount': 1940.0,
    },
    {'name': 'நித்யா', 'englishName': 'NITHYA', 'balanceAmount': 3960.0},
    {'name': 'பாலாஜி', 'englishName': 'BALAJI', 'balanceAmount': 170.0},
    {
      'name': 'சீதா லெட்சுமி',
      'englishName': 'SEETHA LAKSHMI',
      'balanceAmount': 4652.0,
    },
    {
      'name': 'செந்தில் குமார்',
      'englishName': 'SEMDHIL KUMAR',
      'balanceAmount': 3800.0,
    },
    {
      'name': 'ராஜ் வெங்கடேஷ்',
      'englishName': 'RAJ VENGADESH',
      'balanceAmount': 3000.0,
    },
    {'name': 'ராகவன்', 'englishName': 'RAGAVAN', 'balanceAmount': 24600.0},
    {'name': 'வைரம்', 'englishName': 'VAIRAM', 'balanceAmount': 2600.0},
    {'name': 'சிபி', 'englishName': 'SIBI', 'balanceAmount': 782.0},
    {
      'name': 'ராஜேந்திரன்',
      'englishName': 'RAJENDHIRAN',
      'balanceAmount': 1484.0,
    },
  ];

  final batch = firestore.batch();

  for (final store in stores) {
    final docRef = firestore.collection('stores').doc();

    batch.set(docRef, {
      'name': store['name'],
      'englishName': store['englishName'],
      'district': 'T.பழூர்',
      'address': 'T.பழூர்',
      'phone': '',
      'email': '',
      'balanceAmount': store['balanceAmount'],
      'currentBalance': store['balanceAmount'],
      'totalTransactions': 0,
      'lastTransactionDate': '',
      'UpdatedAt': FieldValue.serverTimestamp(),
    });
  }

  await batch.commit();

  print('Successfully uploaded ${stores.length} T.பழூர் stores');
}

Future<void> uploadThirukattupalliUpdatedStores() async {
  final firestore = FirebaseFirestore.instance;

  final stores = [
    {'name': 'செந்தில்', 'englishName': 'SENTHIL', 'balanceAmount': 0.0},
    {'name': 'ஓம்சக்தி', 'englishName': 'OMSAKTHI', 'balanceAmount': 0.0},
    {'name': 'KS குட்டி', 'englishName': 'KS KUTTY', 'balanceAmount': 290.0},
    {'name': 'ஆம்ஸ்', 'englishName': 'AARMS', 'balanceAmount': 0.0},
    {'name': 'யாசின்', 'englishName': 'YASIN', 'balanceAmount': 200.0},
    {'name': 'அப்ஸா', 'englishName': 'APSHA', 'balanceAmount': 0.0},
    {'name': 'ஜஹபர்அலி', 'englishName': 'JAHABER ALI', 'balanceAmount': 0.0},
    {'name': 'கங்கா', 'englishName': 'GANGA', 'balanceAmount': 0.0},
    {'name': 'ஆதேஷ்', 'englishName': 'AADHESH', 'balanceAmount': 0.0},
    {'name': 'சிராஜ்', 'englishName': 'SIRAJ', 'balanceAmount': 0.0},
    {'name': 'ஆனந்தம்', 'englishName': 'AANANDHAM', 'balanceAmount': 0.0},
    {
      'name': 'ராஜேந்திரன்',
      'englishName': 'RAJENDHIRAN',
      'balanceAmount': 506.0,
    },
    {'name': 'ரமேஷ்', 'englishName': 'RAMESH', 'balanceAmount': 2078.0},
    {'name': 'சுகுமாரன்', 'englishName': 'SUGUMARAN', 'balanceAmount': 0.0},
    {'name': 'சண்முகம்', 'englishName': 'SANMUGAM', 'balanceAmount': 1560.0},
    {'name': 'கண்ணன்', 'englishName': 'KANNAN', 'balanceAmount': 0.0},
    {'name': 'கண்ணன்-II', 'englishName': 'KANNAN-II', 'balanceAmount': 0.0},
    {'name': '2 K', 'englishName': '2 K', 'balanceAmount': 0.0},
    {'name': 'சேதுராமன்', 'englishName': 'SETHURAMAN', 'balanceAmount': 1270.0},
    {'name': 'லக்கி', 'englishName': 'LUCKY', 'balanceAmount': 0.0},
    {'name': 'சையதுஅலி', 'englishName': 'SYEDALI', 'balanceAmount': 338.0},
    {'name': 'சக்தி', 'englishName': 'SAKTHI', 'balanceAmount': 0.0},
    {'name': 'சிங்கப்பூர்', 'englishName': 'SINGAPORE', 'balanceAmount': 0.0},
    {'name': 'பாட்டிகடை', 'englishName': 'PATTIKADAI', 'balanceAmount': 0.0},
    {'name': 'தாரணி', 'englishName': 'THARANI', 'balanceAmount': 0.0},
    {'name': 'ஜெஸ்வின்', 'englishName': 'JESWIN', 'balanceAmount': 0.0},
    {'name': 'ஆரிப்', 'englishName': 'AARIF', 'balanceAmount': 582.0},
    {'name': 'அக்பர்', 'englishName': 'AKBAR', 'balanceAmount': 1700.0},
    {'name': 'BRM', 'englishName': 'BRM', 'balanceAmount': 340.0},
    {'name': 'ஆமீனா', 'englishName': 'AAMEENA', 'balanceAmount': 0.0},
    {'name': 'குறிஞ்சி', 'englishName': 'KURINJI', 'balanceAmount': 0.0},
    {'name': 'ரகுமான்', 'englishName': 'RAHUMAN', 'balanceAmount': 0.0},
    {'name': 'மலர்விழி', 'englishName': 'MALARVIZHI', 'balanceAmount': 0.0},
    {'name': 'புஷ்பம்', 'englishName': 'PUSHPAM', 'balanceAmount': 0.0},
    {
      'name': 'சரவணன் நாடார்',
      'englishName': 'SARAVANAN NADAR',
      'balanceAmount': 0.0,
    },
    {'name': 'அன்னை', 'englishName': 'ANNAI', 'balanceAmount': 0.0},
    {'name': 'பார்வதி', 'englishName': 'PARVATHY', 'balanceAmount': 0.0},
    {'name': 'கதிர்வேல்', 'englishName': 'KATHIRVEL', 'balanceAmount': 1732.0},
    {
      'name': 'சுப்ரமணியன்',
      'englishName': 'SUBRAMANIYAN',
      'balanceAmount': 0.0,
    },
    {'name': 'மகாகணபதி', 'englishName': 'MAGAGANAPATHY', 'balanceAmount': 0.0},
    {'name': 'மூரா சன்ஸ்', 'englishName': 'MURA SONS', 'balanceAmount': 450.0},
    {'name': 'சங்கர்-II', 'englishName': 'SANKAR-II', 'balanceAmount': 1500.0},
    {'name': 'முருகன்', 'englishName': 'MURUGAN', 'balanceAmount': 1300.0},
    {'name': 'அய்யனார்', 'englishName': 'AYYANAR', 'balanceAmount': 0.0},
    {'name': 'சீனிவாசா', 'englishName': 'SRINIVASA', 'balanceAmount': 0.0},
    {'name': 'அருண்', 'englishName': 'ARUN', 'balanceAmount': 0.0},
    {'name': 'கணபதி', 'englishName': 'GANAPATHI', 'balanceAmount': 0.0},
    {'name': 'கௌதம்', 'englishName': 'GOWTHAM', 'balanceAmount': 0.0},
    {'name': 'கண்ணன் - III', 'englishName': 'KANNAN-III', 'balanceAmount': 0.0},
    {
      'name': 'துர்க்கையம்மன்',
      'englishName': 'DURGAIAMMAN',
      'balanceAmount': 0.0,
    },
    {'name': 'செல்வம்பாள்', 'englishName': 'SELVAMBAL', 'balanceAmount': 0.0},
    {'name': 'அனுசியா', 'englishName': 'ANUSHIYA', 'balanceAmount': 0.0},
    {'name': 'அனுசியா-II', 'englishName': 'ANUSHIYA-II', 'balanceAmount': 0.0},
    {'name': 'அய்யப்பன்', 'englishName': 'AYYAPPAN', 'balanceAmount': 0.0},
    {'name': 'ஜெயராமன்', 'englishName': 'JAYARAMAN', 'balanceAmount': 590.0},
    {
      'name': 'பரணிவிக்னேஷ்',
      'englishName': 'BARANIVIGNESH',
      'balanceAmount': 1310.0,
    },
    {'name': 'தன்யஸ்ரீ', 'englishName': 'DHANYASRI', 'balanceAmount': 500.0},
    {
      'name': 'மைதீன்பாட்ஷா',
      'englishName': 'MAIDEEN BATCHA',
      'balanceAmount': 1270.0,
    },
    {'name': 'காயத்ரி', 'englishName': 'GAYATHRI', 'balanceAmount': 672.0},
    {'name': 'ராஜவேலு', 'englishName': 'RAJA VELU', 'balanceAmount': 1800.0},
    {'name': 'தனம்', 'englishName': 'DHANAM', 'balanceAmount': 1014.0},
    {'name': 'ஸ்ரீ சாய்', 'englishName': 'SRISAI', 'balanceAmount': 0.0},
    {'name': 'பெரோஸ்', 'englishName': 'FEROSE', 'balanceAmount': 0.0},
    {
      'name': 'புண்ணியமூர்த்தி',
      'englishName': 'PUNNIYAMOORTHI',
      'balanceAmount': 0.0,
    },
  ];

  final batch = firestore.batch();

  for (final store in stores) {
    final docRef = firestore.collection('stores').doc();

    batch.set(docRef, {
      'name': store['name'],
      'englishName': store['englishName'],
      'district': 'திருக்காட்டுப்பள்ளி',
      'address': 'திருக்காட்டுப்பள்ளி',
      'phone': '',
      'email': '',
      'balanceAmount': store['balanceAmount'],
      'currentBalance': store['balanceAmount'],
      'totalTransactions': 0,
      'lastTransactionDate': '',
      'UpdatedAt': FieldValue.serverTimestamp(),
    });
  }

  await batch.commit();

  print('Successfully uploaded ${stores.length} Thirukattupalli stores');
}

Future<void> uploadAaduthurai2UpdatedStores() async {
  final firestore = FirebaseFirestore.instance;

  final stores = [
    {'name': 'விநாயகா', 'englishName': 'VINAYAKA', 'balanceAmount': 0.0},
    {'name': 'MRR', 'englishName': 'MRR', 'balanceAmount': 0.0},
    {'name': 'காந்தி', 'englishName': 'GANDHI', 'balanceAmount': 2640.0},
    {'name': 'விகாஸ்', 'englishName': 'VIKAS', 'balanceAmount': 0.0},
    {'name': 'நெல்லை', 'englishName': 'NELLAI', 'balanceAmount': 0.0},
    {'name': 'பெரோஸ்', 'englishName': 'FEROSE', 'balanceAmount': 0.0},
    {
      'name': 'பன்னீர்செல்வம்',
      'englishName': 'PANNERSELVAM',
      'balanceAmount': 0.0,
    },
    {'name': 'நவமணி-I', 'englishName': 'NAVAMANI-I', 'balanceAmount': 16000.0},
    {
      'name': 'நவமணி-II',
      'englishName': 'NAVAMANI-II',
      'balanceAmount': 11640.0,
    },
    {'name': 'பிஸ்மி', 'englishName': 'BISMI', 'balanceAmount': 0.0},
    {'name': 'அல்ஜசீரா', 'englishName': 'ALJASEERA', 'balanceAmount': 0.0},
    {'name': 'ஆதித்யா', 'englishName': 'AADHITHYA', 'balanceAmount': 0.0},
    {'name': 'ஸ்ரீமதி', 'englishName': 'SRIMATHI', 'balanceAmount': 3380.0},
    {'name': 'ARLUCK', 'englishName': 'ARLUCK', 'balanceAmount': 0.0},
    {'name': 'நடராஜ்', 'englishName': 'NATRAJ', 'balanceAmount': 0.0},
    {'name': 'சாகுல்', 'englishName': 'SAHUL', 'balanceAmount': 0.0},
    {'name': 'ரகுமான்', 'englishName': 'RAHUMAAN', 'balanceAmount': 0.0},
    {'name': 'நேமிகா', 'englishName': 'NEMIKA', 'balanceAmount': 0.0},
    {'name': 'கண்ணன்', 'englishName': 'KANNAN', 'balanceAmount': 0.0},
    {'name': 'SMR', 'englishName': 'SMR', 'balanceAmount': 0.0},
    {'name': 'பாலு', 'englishName': 'BALU', 'balanceAmount': 0.0},
    {'name': 'ரவி', 'englishName': 'RAVI', 'balanceAmount': 0.0},
    {'name': 'சாய்', 'englishName': 'SAI', 'balanceAmount': 0.0},
    {'name': 'KR', 'englishName': 'KR', 'balanceAmount': 998.0},
    {
      'name': 'நேஷனல்(பேராவூர்)',
      'englishName': 'NATIONAL(PERAVUR)',
      'balanceAmount': 0.0,
    },
    {'name': 'கணேசன்', 'englishName': 'GANESAN', 'balanceAmount': 640.0},
    {
      'name': 'நேஷனல்(திருநீலக்குடி)',
      'englishName': 'NATIONAL(THIRUNEELAKUDI)',
      'balanceAmount': 3200.0,
    },
    {'name': 'லெட்சுமணன்', 'englishName': 'LAKSHMANAN', 'balanceAmount': 0.0},
    {'name': 'வசந்தம்', 'englishName': 'VASANDHAM', 'balanceAmount': 0.0},
    {'name': 'சரஸ்வதி', 'englishName': 'SARASWATHI', 'balanceAmount': 1300.0},
    {'name': 'அன்னை', 'englishName': 'ANNAI', 'balanceAmount': 3338.0},
    {'name': 'அருள்', 'englishName': 'ARUL', 'balanceAmount': 0.0},
    {'name': 'செல்வி', 'englishName': 'SELVI', 'balanceAmount': 0.0},
    {'name': 'அஹிஸ்வர்', 'englishName': 'AHISWAR', 'balanceAmount': 1520.0},
    {'name': 'தீன்', 'englishName': 'DEEN', 'balanceAmount': 2440.0},
    {'name': 'ராஷிகா', 'englishName': 'RASHIKA', 'balanceAmount': 2050.0},
    {'name': 'AJ', 'englishName': 'AJ', 'balanceAmount': 22070.0},
    {
      'name': 'நேஷனல்(சாத்தனூர்)',
      'englishName': 'NATONAL(SAATHANUR)',
      'balanceAmount': 2600.0,
    },
    {'name': 'டில்லி', 'englishName': 'DELHI', 'balanceAmount': 0.0},
  ];

  final batch = firestore.batch();

  for (final store in stores) {
    final docRef = firestore.collection('stores').doc();

    batch.set(docRef, {
      'name': store['name'],
      'englishName': store['englishName'],
      'district': 'ஆடுதுறை',
      'address': 'ஆடுதுறை',
      'phone': '',
      'email': '',
      'balanceAmount': store['balanceAmount'],
      'currentBalance': store['balanceAmount'],
      'totalTransactions': 0,
      'lastTransactionDate': '',
      'UpdatedAt': FieldValue.serverTimestamp(),
    });
  }

  await batch.commit();

  print('Successfully uploaded ${stores.length} Aaduthurai stores');
}

Future<void> uploadKoradacheriUpdatedStores() async {
  final firestore = FirebaseFirestore.instance;

  final stores = [
    {'name': 'மாரிமுத்து', 'englishName': 'MARIMUTHU', 'balanceAmount': 0.0},
    {'name': 'விநாயகா', 'englishName': 'VINAYAKA', 'balanceAmount': 0.0},
    {'name': 'பார்த்தி', 'englishName': 'PARTHI', 'balanceAmount': 0.0},
    {'name': 'சம்யுக்தா', 'englishName': 'SAMYUKTHA', 'balanceAmount': 0.0},
    {'name': 'மாரியம்மாள்', 'englishName': 'MAARIYAMMAL', 'balanceAmount': 0.0},
    {'name': 'கிருஷ்ணா', 'englishName': 'KRISHNA', 'balanceAmount': 3040.0},
    {'name': 'குமார்', 'englishName': 'KUMAR', 'balanceAmount': 0.0},
    {'name': 'ஆசிரா', 'englishName': 'ASIRA', 'balanceAmount': 0.0},
    {
      'name': 'நடராஜன்(தாத்தா)',
      'englishName': 'NATARAJAN(TATHA)',
      'balanceAmount': 100.0,
    },
    {'name': 'சர்வேஸ்', 'englishName': 'SARVESH', 'balanceAmount': 0.0},
    {'name': 'பரமசிவம்', 'englishName': 'PARAMASIVAM', 'balanceAmount': 0.0},
    {'name': 'நாராயணன்', 'englishName': 'NARAYANAN', 'balanceAmount': 0.0},
    {'name': 'கார்த்தி', 'englishName': 'KARTHI', 'balanceAmount': 0.0},
    {'name': 'வாசு', 'englishName': 'VAASU', 'balanceAmount': 0.0},
    {
      'name': 'குருமூர்த்தி (குரு)',
      'englishName': 'GURUMOORTHI(GURU)',
      'balanceAmount': 3155.0,
    },
    {'name': 'மூவேந்தன்', 'englishName': 'MOOVENDHAN', 'balanceAmount': 0.0},
    {'name': 'இலக்கியா', 'englishName': 'ILAKKIYA', 'balanceAmount': 2000.0},
    {'name': 'மணிவண்ணன்', 'englishName': 'MANIVANNAN', 'balanceAmount': 0.0},
    {'name': 'ஜெகன்', 'englishName': 'JEGAN', 'balanceAmount': 0.0},
    {'name': 'சுரேகா', 'englishName': 'SUREKA', 'balanceAmount': 0.0},
    {'name': 'இந்திரா', 'englishName': 'INDHIRA', 'balanceAmount': 0.0},
    {'name': 'மாதவன்', 'englishName': 'MAADHAVAN', 'balanceAmount': 0.0},
    {'name': 'செல்வம்-I', 'englishName': 'SELVAM-I', 'balanceAmount': 0.0},
    {'name': 'ARR', 'englishName': 'ARR', 'balanceAmount': 0.0},
    {'name': 'ஆசிம்', 'englishName': 'ASIM', 'balanceAmount': 0.0},
    {'name': 'TN ரமேஷ்', 'englishName': 'TN RAMESH', 'balanceAmount': 0.0},
    {'name': 'பவுன்', 'englishName': 'PAVUN', 'balanceAmount': 0.0},
    {'name': 'TNR', 'englishName': 'TNR', 'balanceAmount': 0.0},
    {'name': 'வெற்றி', 'englishName': 'VETRI', 'balanceAmount': 0.0},
    {'name': 'பன்னீர்', 'englishName': 'PANNER', 'balanceAmount': 13912.0},
    {'name': 'அபிராமி', 'englishName': 'ABIRAMI', 'balanceAmount': 17910.0},
    {'name': 'ராஜேஷ்', 'englishName': 'RAJESH', 'balanceAmount': 0.0},
    {'name': 'ASK', 'englishName': 'ASK', 'balanceAmount': 6300.0},
    {'name': 'HM', 'englishName': 'HM', 'balanceAmount': 0.0},
    {'name': 'SF', 'englishName': 'SF', 'balanceAmount': 0.0},
    {
      'name': 'மணிவண்ணண்-II',
      'englishName': 'MANIVANNAN-II',
      'balanceAmount': 0.0,
    },
    {'name': 'தங்கராசு', 'englishName': 'THANGARAASU', 'balanceAmount': 0.0},
    {'name': 'நேஷனல்', 'englishName': 'NATIONAL', 'balanceAmount': 1000.0},
    {'name': 'கவிதியா', 'englishName': 'KAVITHIYA', 'balanceAmount': 2000.0},
    {'name': 'YS', 'englishName': 'YS', 'balanceAmount': 0.0},
    {'name': 'NS', 'englishName': 'NS', 'balanceAmount': 0.0},
    {'name': 'வசந்தம்', 'englishName': 'VASANDHAM', 'balanceAmount': 0.0},
    {'name': 'இந்தியன்', 'englishName': 'INDIAN', 'balanceAmount': 0.0},
    {'name': 'பாத்திமா', 'englishName': 'FATHIMA', 'balanceAmount': 0.0},
    {'name': 'விக்னேஷ்', 'englishName': 'VIGNESH', 'balanceAmount': 0.0},
    {'name': 'செல்வம்-II', 'englishName': 'SELVAN-II', 'balanceAmount': 0.0},
    {'name': 'குருநாதன்', 'englishName': 'GURUNADHAN', 'balanceAmount': 0.0},
    {'name': 'KMA', 'englishName': 'KMA', 'balanceAmount': 0.0},
    {'name': 'ஆயிஷா', 'englishName': 'AYESHA', 'balanceAmount': 0.0},
    {'name': 'நிலவு', 'englishName': 'NILAVU', 'balanceAmount': 0.0},
    {
      'name': 'அன்பே சிவம்',
      'englishName': 'ANBE SIVAM',
      'balanceAmount': 8400.0,
    },
    {'name': 'சேகர்', 'englishName': 'SEKAR', 'balanceAmount': 0.0},
    {'name': 'சன்', 'englishName': 'SUN', 'balanceAmount': 0.0},
    {'name': 'நஜிமா', 'englishName': 'NAJIMA', 'balanceAmount': 0.0},
    {'name': 'குமார்', 'englishName': 'KUMAR', 'balanceAmount': 0.0},
    {
      'name': 'ஆவின் பன்னீர்',
      'englishName': 'AAVIN PANNER',
      'balanceAmount': 0.0,
    },
    {'name': 'முத்து', 'englishName': 'MUTHU', 'balanceAmount': 2780.0},
    {'name': 'நம்நாடு', 'englishName': 'NAMNAADU', 'balanceAmount': 0.0},
    {'name': 'கார்த்தி-II', 'englishName': 'KARTH-II', 'balanceAmount': 0.0},
    {'name': 'அன்பு', 'englishName': 'ANBU', 'balanceAmount': 0.0},
    {'name': 'ஓம்சக்தி', 'englishName': 'ONSHAKTHI', 'balanceAmount': 3380.0},
    {'name': 'சூர்யா', 'englishName': 'SURYA', 'balanceAmount': 0.0},
    {'name': 'ஸ்டார்', 'englishName': 'STAR', 'balanceAmount': 0.0},
    {'name': 'தாத்தா', 'englishName': 'THATHA', 'balanceAmount': 0.0},
    {'name': 'ரவி', 'englishName': 'RAVI', 'balanceAmount': 0.0},
    {'name': 'அண்ணாதுரை', 'englishName': 'ANNADURAI', 'balanceAmount': 0.0},
    {'name': 'சீமாட்டி', 'englishName': 'SEEMATI', 'balanceAmount': 0.0},
    {'name': 'குபேரன்', 'englishName': 'GUBERAN', 'balanceAmount': 8000.0},
    {'name': 'பாண்டியன்', 'englishName': 'PANDIYAN', 'balanceAmount': 0.0},
    {'name': 'MGS', 'englishName': 'MGS', 'balanceAmount': 4630.0},
    {'name': 'தீன்', 'englishName': 'DEEN', 'balanceAmount': 11995.0},
    {'name': 'ஜனபிரியா', 'englishName': 'JANAPRIYA', 'balanceAmount': 8000.0},
  ];

  final batch = firestore.batch();

  for (final store in stores) {
    final docRef = firestore.collection('stores').doc();

    batch.set(docRef, {
      'name': store['name'],
      'englishName': store['englishName'],
      'district': 'கொரடாச்சேரி',
      'address': 'கொரடாச்சேரி',
      'phone': '',
      'email': '',
      'balanceAmount': store['balanceAmount'],
      'currentBalance': store['balanceAmount'],
      'totalTransactions': 0,
      'lastTransactionDate': '',
      'UpdatedAt': FieldValue.serverTimestamp(),
    });
  }

  await batch.commit();

  print('Successfully uploaded ${stores.length} Koradacheri stores');
}

Future<void> uploadKudavasalUpdatedStores() async {
  final firestore = FirebaseFirestore.instance;

  final stores = [
    {'name': 'சேகர்', 'englishName': 'SEKAR', 'balanceAmount': 0.0},
    {'name': 'துர்கா', 'englishName': 'DURGA', 'balanceAmount': 0.0},
    {'name': 'குமார்', 'englishName': 'KUMAR', 'balanceAmount': 0.0},
    {'name': 'உப்பிலி', 'englishName': 'UPPILI', 'balanceAmount': 3380.0},
    {'name': 'சுமதி', 'englishName': 'SUMATHI', 'balanceAmount': 0.0},
    {'name': 'தங்கராசு', 'englishName': 'THANGARASU', 'balanceAmount': 0.0},
    {'name': 'தீன் (ஓகை)', 'englishName': 'DEEN(OOGAI)', 'balanceAmount': 0.0},
    {'name': 'பிரபா', 'englishName': 'PRABHA', 'balanceAmount': 0.0},
    {'name': 'ராகவன்', 'englishName': 'RAGHAVAN', 'balanceAmount': 0.0},
    {'name': 'சோலை', 'englishName': 'SOLAI', 'balanceAmount': 500.0},
    {'name': 'கணேசன்', 'englishName': 'GANESHAN', 'balanceAmount': 0.0},
    {'name': 'மதினா', 'englishName': 'MATHEENA', 'balanceAmount': 0.0},
    {'name': 'அபிநயா', 'englishName': 'ABINAYA', 'balanceAmount': 1940.0},
    {'name': 'யோகா', 'englishName': 'YOOGA', 'balanceAmount': 0.0},
    {'name': 'இந்தியன்', 'englishName': 'INDIAN', 'balanceAmount': 0.0},
    {
      'name': 'சக்திமிட்டாய்',
      'englishName': 'SAKTHIMITTAI',
      'balanceAmount': 65980.0,
    },
    {'name': 'கனி', 'englishName': 'KANI', 'balanceAmount': 700.0},
    {'name': 'ஜெயவேல்', 'englishName': 'JAYAVEL', 'balanceAmount': 2480.0},
    {'name': 'ராமமூர்த்தி', 'englishName': 'RAMAMOORTHI', 'balanceAmount': 0.0},
    {'name': 'சாமுவேல்', 'englishName': 'SAMUVEL', 'balanceAmount': 40135.0},
    {'name': 'செல்லப்பா', 'englishName': 'SELLAPA', 'balanceAmount': 10410.0},
    {'name': 'மோகன்', 'englishName': 'MOHAN', 'balanceAmount': 0.0},
    {'name': 'ரியாஸ்', 'englishName': 'RIYAS', 'balanceAmount': 0.0},
    {'name': 'சாகுல்', 'englishName': 'SAHUL', 'balanceAmount': 0.0},
    {
      'name': 'அலிபிரதர்ஸ்',
      'englishName': 'ALI BROTHERS',
      'balanceAmount': 0.0,
    },
    {
      'name': 'தீன்(குடவாசல்)',
      'englishName': 'DEEN(KUDAVASAL)',
      'balanceAmount': 15000.0,
    },
    {'name': 'அன்னை', 'englishName': 'ANNAI', 'balanceAmount': 0.0},
    {'name': 'ஜக்கிரியா', 'englishName': 'JAKKIRIYA', 'balanceAmount': 0.0},
    {'name': 'நேஷனல்', 'englishName': 'NATIONAL', 'balanceAmount': 0.0},
    {'name': 'ஆனந்தம்', 'englishName': 'ANANDHAM', 'balanceAmount': 0.0},
    {'name': 'பைசல்', 'englishName': 'FAISAL', 'balanceAmount': 37015.0},
    {'name': 'ரமேஷ்', 'englishName': 'RAMESH', 'balanceAmount': 0.0},
    {'name': 'காவியா', 'englishName': 'KAVIYA', 'balanceAmount': 1510.0},
    {'name': 'மாலா', 'englishName': 'MAALA', 'balanceAmount': 0.0},
    {'name': 'யாழினி', 'englishName': 'YAZHINI', 'balanceAmount': 0.0},
    {'name': 'குறிஞ்சி', 'englishName': 'KURINJI', 'balanceAmount': 0.0},
    {'name': 'ஸ்ரீ அம்மன்', 'englishName': 'SRI AMMAN', 'balanceAmount': 0.0},
    {'name': 'அம்மன்', 'englishName': 'AMMAN', 'balanceAmount': 0.0},
    {'name': 'அல்நூர்', 'englishName': 'ALNOOR', 'balanceAmount': 0.0},
    {
      'name': 'தீன்(ஆரியச்சேரி)',
      'englishName': 'DEEN(AARIYACHERI)',
      'balanceAmount': 0.0,
    },
    {'name': 'கண்ணையன்', 'englishName': 'KANNAIYAN', 'balanceAmount': 0.0},
    {'name': 'ரவி', 'englishName': 'RAVI', 'balanceAmount': 0.0},
    {'name': 'பரகத்', 'englishName': 'BARAKATH', 'balanceAmount': 0.0},
    {'name': 'இந்தியன்-II', 'englishName': 'INDIAN-II', 'balanceAmount': 0.0},
    {'name': 'லெட்சுமி-I', 'englishName': 'LAKSHMI-I', 'balanceAmount': 0.0},
    {
      'name': 'கிருஷ்ணா-I',
      'englishName': 'KRISHNAN-I',
      'balanceAmount': 5000.0,
    },
    {'name': 'சோழன்-I', 'englishName': 'CHOLAN-I', 'balanceAmount': 0.0},
    {'name': 'மதீனா-II', 'englishName': 'MATHEENA-II', 'balanceAmount': 0.0},
    {'name': 'கிருஷ்ணா-II', 'englishName': 'KRISHNAN-II', 'balanceAmount': 0.0},
    {'name': 'மாறன்', 'englishName': 'MAARAN', 'balanceAmount': 0.0},
    {'name': 'சாதிக்', 'englishName': 'SATHIK', 'balanceAmount': 0.0},
    {'name': 'பாலமுருகன்', 'englishName': 'BALAMURUGAN', 'balanceAmount': 0.0},
    {
      'name': 'செல்வபாரதி',
      'englishName': 'SELVABHARATHI',
      'balanceAmount': 0.0,
    },
    {'name': 'பாத்திமா', 'englishName': 'FATHIMA', 'balanceAmount': 0.0},
    {
      'name': 'நேஷனல்-II',
      'englishName': 'NATIONAL-II',
      'balanceAmount': 11420.0,
    },
    {'name': 'ஸ்டார்', 'englishName': 'STAR', 'balanceAmount': 0.0},
    {'name': 'ஜலால்', 'englishName': 'JALAL', 'balanceAmount': 0.0},
    {'name': 'அல்ரையான்', 'englishName': 'ALRAYAAN', 'balanceAmount': 0.0},
    {'name': 'நூருல்', 'englishName': 'NOORUL', 'balanceAmount': 0.0},
    {'name': 'முகைதீன்', 'englishName': 'MUGAIDEEN', 'balanceAmount': 0.0},
    {'name': 'சோழன்-II', 'englishName': 'CHOLAN-II', 'balanceAmount': 7605.0},
    {'name': 'மணிகண்டன்', 'englishName': 'MANIKANDAN', 'balanceAmount': 0.0},
    {'name': 'லெட்சுமணன்', 'englishName': 'LAKSHMANAN', 'balanceAmount': 0.0},
    {'name': 'லெட்சுமி II', 'englishName': 'LAKSHMI-II', 'balanceAmount': 0.0},
    {'name': 'கண்ணன்', 'englishName': 'KANNAN', 'balanceAmount': 0.0},
    {'name': 'பாலசந்தோஷ்', 'englishName': 'BALASANTHOSH', 'balanceAmount': 0.0},
    {'name': 'சீனு', 'englishName': 'SEENU', 'balanceAmount': 0.0},
    {'name': 'அழகேஷன்', 'englishName': 'AZHAGESAN', 'balanceAmount': 0.0},
    {'name': 'மகஸ்ரீ', 'englishName': 'MAHASRI', 'balanceAmount': 0.0},
  ];

  final batch = firestore.batch();

  for (final store in stores) {
    final docRef = firestore.collection('stores').doc();

    batch.set(docRef, {
      'name': store['name'],
      'englishName': store['englishName'],
      'district': 'குடவாசல்',
      'address': 'குடவாசல்',
      'phone': '',
      'email': '',
      'balanceAmount': store['balanceAmount'],
      'currentBalance': store['balanceAmount'],
      'totalTransactions': 0,
      'lastTransactionDate': '',
      'UpdatedAt': FieldValue.serverTimestamp(),
    });
  }

  await batch.commit();

  print('Successfully uploaded ${stores.length} Kudavasal stores');
}

Future<void> uploadThiruvidaicheriUpdatedStores() async {
  final firestore = FirebaseFirestore.instance;

  final stores = [
    {'name': 'தீன்', 'englishName': 'DEEN', 'balanceAmount': 0.0},
    {'name': 'ராகவன்', 'englishName': 'RAGAVAN', 'balanceAmount': 0.0},
    {'name': 'SVM', 'englishName': 'SVM', 'balanceAmount': 0.0},
    {'name': 'மஞ்சுளா', 'englishName': 'MANJULA', 'balanceAmount': 0.0},
    {'name': 'குமார்', 'englishName': 'KUMAR', 'balanceAmount': 0.0},
    {'name': 'கணேசன்-I', 'englishName': 'GANESHAN-I', 'balanceAmount': 0.0},
    {
      'name': 'ஸ்ரீராம்மனோகர்',
      'englishName': 'SRIRAM MANOHAR',
      'balanceAmount': 0.0,
    },
    {'name': 'ஜெயராமன்', 'englishName': 'JAYARAM', 'balanceAmount': 0.0},
    {'name': 'சபரிஸ்', 'englishName': 'SABARISH', 'balanceAmount': 2940.0},
    {'name': 'கண்ணன்-I', 'englishName': 'KANNAN-I', 'balanceAmount': 0.0},
    {'name': 'கணேசன்-II', 'englishName': 'KANNAN-II', 'balanceAmount': 0.0},
    {'name': 'கண்ணையன்', 'englishName': 'KANNAYAN', 'balanceAmount': 0.0},
    {'name': 'சிவா-I', 'englishName': 'SIVA-I', 'balanceAmount': 0.0},
    {'name': 'குமரன்', 'englishName': 'KUMAR', 'balanceAmount': 0.0},
    {
      'name': 'காத்தாயிஅம்மன்',
      'englishName': 'KATHTHAYIAMMAN',
      'balanceAmount': 0.0,
    },
    {'name': 'அம்மன்', 'englishName': 'AMMAN', 'balanceAmount': 0.0},
    {'name': 'அஜ்மல்', 'englishName': 'AJMAL', 'balanceAmount': 3575.0},
    {'name': 'தீன்-II', 'englishName': 'DEEN-II', 'balanceAmount': 0.0},
    {'name': 'ஹரிஓம்', 'englishName': 'HARIOM', 'balanceAmount': 0.0},
    {'name': 'தருண்', 'englishName': 'DHARUN', 'balanceAmount': 0.0},
    {'name': 'ராஜகலா', 'englishName': 'RAJAKALA', 'balanceAmount': 0.0},
    {'name': 'முருகன்', 'englishName': 'MURUGAN', 'balanceAmount': 0.0},
    {'name': 'ஆயிஷா', 'englishName': 'AYESHA', 'balanceAmount': 1995.0},
    {'name': 'ஸ்டார்', 'englishName': 'STAR', 'balanceAmount': 0.0},
    {'name': 'ராயல்', 'englishName': 'ROYAL', 'balanceAmount': 0.0},
    {'name': 'சிவா II', 'englishName': 'SIVA-II', 'balanceAmount': 0.0},
    {'name': 'அழகம்பாள்', 'englishName': 'AZHAGAMBAL', 'balanceAmount': 0.0},
    {'name': 'பழனி', 'englishName': 'PALANI', 'balanceAmount': 0.0},
    {'name': 'நிவேதா', 'englishName': 'NIVETHA', 'balanceAmount': 3250.0},
    {'name': 'தேவர்தீன்', 'englishName': 'DHEVARDHEEN', 'balanceAmount': 0.0},
    {'name': 'திருமலை', 'englishName': 'THIRUMALAI', 'balanceAmount': 0.0},
    {'name': 'கற்பகம்', 'englishName': 'KARPAGAM', 'balanceAmount': 0.0},
    {'name': 'வசந்தம்', 'englishName': 'VASANTHAM', 'balanceAmount': 0.0},
    {
      'name': 'ஜெய்ஸ்ரீராம்',
      'englishName': 'JAISRIRAM',
      'balanceAmount': 14000.0,
    },
    {'name': 'கண்ணன் II', 'englishName': 'KANNAN-II', 'balanceAmount': 0.0},
    {'name': 'RSN', 'englishName': 'RSN', 'balanceAmount': 0.0},
    {'name': 'ESM', 'englishName': 'ESM', 'balanceAmount': 0.0},
    {
      'name': 'குருமூர்த்தி',
      'englishName': 'GURUMOORTHI',
      'balanceAmount': 0.0,
    },
    {'name': 'நியாஸ்ரீ', 'englishName': 'NIYASRI', 'balanceAmount': 0.0},
    {'name': 'SK', 'englishName': 'SK', 'balanceAmount': 0.0},
    {'name': 'சங்கர்', 'englishName': 'SANKAR', 'balanceAmount': 0.0},
    {
      'name': 'கலிபுல்லாஹ்',
      'englishName': 'KALIBULLAH',
      'balanceAmount': 5575.0,
    },
    {'name': 'MAS', 'englishName': 'MAS', 'balanceAmount': 2380.0},
    {'name': 'ஓம்சக்தி', 'englishName': 'OMSHAKTHI', 'balanceAmount': 0.0},
    {'name': 'ராஜமூர்த்தி', 'englishName': 'RAJMOORTHI', 'balanceAmount': 0.0},
    {'name': 'சிவகுமார்', 'englishName': 'SIVAKUMAR', 'balanceAmount': 0.0},
    {'name': 'விக்னேஷ்', 'englishName': 'VIGNESH', 'balanceAmount': 800.0},
    {'name': 'குறிஞ்சி', 'englishName': 'KURINJI', 'balanceAmount': 3280.0},
    {'name': 'கௌதம்', 'englishName': 'GOWTHAM', 'balanceAmount': 0.0},
    {'name': 'ரேவதி', 'englishName': 'REVATHI', 'balanceAmount': 0.0},
    {'name': 'பபிதா', 'englishName': 'BABITHA', 'balanceAmount': 0.0},
    {'name': 'நவீன்', 'englishName': 'NAVEEN', 'balanceAmount': 0.0},
    {'name': 'ராதா', 'englishName': 'RADHA', 'balanceAmount': 0.0},
    {'name': 'துர்கா', 'englishName': 'DURGA', 'balanceAmount': 0.0},
    {'name': 'வேலவன்', 'englishName': 'VELAVAN', 'balanceAmount': 0.0},
    {'name': 'காயத்ரி', 'englishName': 'GAYATHRI', 'balanceAmount': 0.0},
    {'name': 'வீரா', 'englishName': 'VEERA', 'balanceAmount': 0.0},
    {'name': 'சந்தோஷ்', 'englishName': 'SANTHOSH', 'balanceAmount': 0.0},
    {'name': 'VK', 'englishName': 'VK', 'balanceAmount': 0.0},
    {'name': 'PRK', 'englishName': 'PRK', 'balanceAmount': 0.0},
    {'name': 'RK', 'englishName': 'RK', 'balanceAmount': 0.0},
    {'name': 'முருகன்-II', 'englishName': 'MURUGAN-II', 'balanceAmount': 0.0},
  ];

  final batch = firestore.batch();

  for (final store in stores) {
    final docRef = firestore.collection('stores').doc();

    batch.set(docRef, {
      'name': store['name'],
      'englishName': store['englishName'],
      'district': 'திருவிடைச்சேரி',
      'address': 'திருவிடைச்சேரி',
      'phone': '',
      'email': '',
      'balanceAmount': store['balanceAmount'],
      'currentBalance': store['balanceAmount'],
      'totalTransactions': 0,
      'lastTransactionDate': '',
      'UpdatedAt': FieldValue.serverTimestamp(),
    });
  }

  await batch.commit();

  print('Successfully uploaded ${stores.length} Thiruvidaicheri stores');
}

Future<void> uploadAvoorUpdatedStores() async {
  final firestore = FirebaseFirestore.instance;

  final stores = [
    {'name': 'பிஸ்மி', 'englishName': 'BISMI', 'balanceAmount': 4000.0},
    {'name': 'இந்திரா-I', 'englishName': 'INDHIRA-I', 'balanceAmount': 0.0},
    {'name': 'காவேரி', 'englishName': 'KAVERI', 'balanceAmount': 0.0},
    {'name': 'குடந்தை', 'englishName': 'KUDANTHAI', 'balanceAmount': 0.0},
    {'name': 'சுல்தான்', 'englishName': 'SULTAN', 'balanceAmount': 0.0},
    {'name': 'பிஸ்மில்லாஹ்', 'englishName': 'BISMILLAH', 'balanceAmount': 0.0},
    {'name': 'யாகஸ்ரீ', 'englishName': 'YAGA SRI', 'balanceAmount': 0.0},
    {'name': 'இந்திரா-II', 'englishName': 'INDHIRA-II', 'balanceAmount': 0.0},
    {'name': 'இந்தியன்-I', 'englishName': 'INDIAN-I', 'balanceAmount': 0.0},
    {'name': 'பாத்திமா', 'englishName': 'FATHIMA', 'balanceAmount': 0.0},
    {'name': 'ஷாஜகான்', 'englishName': 'SHAJAHAN', 'balanceAmount': 0.0},
    {'name': 'சேட்டு-I', 'englishName': 'SETTU-I', 'balanceAmount': 0.0},
    {'name': 'இப்ராஹிம்', 'englishName': 'IBRAHIM', 'balanceAmount': 0.0},
    {'name': 'ஹபீப்-I', 'englishName': 'HABEEB-I', 'balanceAmount': 0.0},
    {'name': 'ஹபீப்-II', 'englishName': 'HABEEB-II', 'balanceAmount': 0.0},
    {'name': 'மதீனா-I', 'englishName': 'MATHEENA-I', 'balanceAmount': 0.0},
    {'name': 'சேட்டு-II', 'englishName': 'SETTU-II', 'balanceAmount': 0.0},
    {'name': 'வளர்பிறை', 'englishName': 'VALARPIRAI', 'balanceAmount': 27265.0},
    {'name': 'சாதிக்', 'englishName': 'SATHIK', 'balanceAmount': 10000.0},
    {'name': 'உதயம்', 'englishName': 'UDHAYAM', 'balanceAmount': 0.0},
    {'name': 'விஜயா', 'englishName': 'VIJAYA', 'balanceAmount': 0.0},
    {'name': 'SS', 'englishName': 'SS', 'balanceAmount': 0.0},
    {'name': 'தாஜ்', 'englishName': 'TAJ', 'balanceAmount': 0.0},
    {'name': 'தினேஷ்', 'englishName': 'DINESH', 'balanceAmount': 0.0},
    {'name': 'தஸ்மீன்', 'englishName': 'THASNEEM', 'balanceAmount': 0.0},
    {'name': 'KK', 'englishName': 'KK', 'balanceAmount': 2500.0},
    {'name': 'மதீனா II', 'englishName': 'MATHEENA-II', 'balanceAmount': 0.0},
    {'name': 'நேஷனல்-I', 'englishName': 'NATIONAL-I', 'balanceAmount': 0.0},
    {'name': 'துர்கா', 'englishName': 'DURGA', 'balanceAmount': 0.0},
    {'name': 'சோழன்', 'englishName': 'CHOLAN', 'balanceAmount': 0.0},
    {'name': 'இந்தியன் II', 'englishName': 'INDIAN-II', 'balanceAmount': 0.0},
    {'name': 'அம்சவள்ளி', 'englishName': 'AMSAVALLI', 'balanceAmount': 0.0},
    {'name': 'அண்ணாதுரை', 'englishName': 'ANNADURAI', 'balanceAmount': 0.0},
    {'name': 'சரவணன்', 'englishName': 'SARAVAN', 'balanceAmount': 1050.0},
    {
      'name': 'சுப்ரமணியன்',
      'englishName': 'SUBRAMANIYAN',
      'balanceAmount': 0.0,
    },
    {
      'name': 'ராமச்சந்திரன்',
      'englishName': 'RAMACHANDHIRAN',
      'balanceAmount': 0.0,
    },
    {'name': 'ராஜ்குமார்', 'englishName': 'RAJKUMAR', 'balanceAmount': 0.0},
    {'name': 'ராஜேந்திரன்', 'englishName': 'RAJENDRAN', 'balanceAmount': 0.0},
    {'name': 'காத்தையா', 'englishName': 'KAATHAYYA', 'balanceAmount': 0.0},
    {'name': 'ஈஸ்வரி', 'englishName': 'ESWARI', 'balanceAmount': 0.0},
    {'name': 'KS', 'englishName': 'KS', 'balanceAmount': 0.0},
    {'name': 'நேஷனல்-II', 'englishName': 'NATIONAL-II', 'balanceAmount': 0.0},
    {'name': 'காவியா', 'englishName': 'KAVYA', 'balanceAmount': 0.0},
    {'name': 'நிஜாம்', 'englishName': 'NIJAM', 'balanceAmount': 0.0},
    {'name': 'சென்ட்ரல்', 'englishName': 'CENTRAL', 'balanceAmount': 0.0},
    {'name': 'சஹானா', 'englishName': 'SAHANA', 'balanceAmount': 0.0},
    {
      'name': 'கலியபெருமாள்',
      'englishName': 'KALIYAPERUMAL',
      'balanceAmount': 0.0,
    },
    {'name': 'முரளி', 'englishName': 'MURALI', 'balanceAmount': 0.0},
    {'name': 'செல்வி', 'englishName': 'SELVI', 'balanceAmount': 0.0},
    {'name': 'ஜே. எஸ்-I', 'englishName': 'JS-I', 'balanceAmount': 8355.0},
    {'name': 'ஜே. எஸ்-II', 'englishName': 'JS-II', 'balanceAmount': 2620.0},
    {'name': 'சுசீலா', 'englishName': 'SUSILA', 'balanceAmount': 0.0},
    {'name': 'கணேசன்', 'englishName': 'GANESAN', 'balanceAmount': 0.0},
    {'name': 'திவ்யா', 'englishName': 'DIVYA', 'balanceAmount': 0.0},
    {'name': 'பாட்டி', 'englishName': 'PATTI', 'balanceAmount': 0.0},
    {'name': 'பாத்திமா', 'englishName': 'FATHUMA', 'balanceAmount': 0.0},
    {'name': 'KRS', 'englishName': 'KRS', 'balanceAmount': 0.0},
    {'name': 'MSD', 'englishName': 'MSD', 'balanceAmount': 0.0},
    {'name': 'முருகன்', 'englishName': 'MURUGN', 'balanceAmount': 2000.0},
    {'name': 'ஸ்ரீ ஹரி', 'englishName': 'SRI HARI', 'balanceAmount': 0.0},
    {
      'name': 'சமயபுரத்தாள்',
      'englishName': 'SAMAYAPURATHTHAL',
      'balanceAmount': 0.0,
    },
    {'name': 'ரவி', 'englishName': 'RAVI', 'balanceAmount': 0.0},
    {'name': 'அபிராமி', 'englishName': 'ABIRAMI', 'balanceAmount': 0.0},
    {'name': 'ராஜலெட்சுமி', 'englishName': 'RAJALAKSHMI', 'balanceAmount': 0.0},
    {'name': 'முபிதா', 'englishName': 'MUBITHA', 'balanceAmount': 0.0},
    {'name': 'ராமானுஜம்', 'englishName': 'RAMANUJAM', 'balanceAmount': 0.0},
    {'name': 'சௌந்தர்', 'englishName': 'SOWNDHAR', 'balanceAmount': 0.0},
    {'name': 'யுவன்ராஜா', 'englishName': 'YUVANRAJ', 'balanceAmount': 3115.0},
    {'name': 'சிவகுமார்', 'englishName': 'SIAKUMAR', 'balanceAmount': 0.0},
    {'name': 'அபு', 'englishName': 'ABU', 'balanceAmount': 0.0},
    {'name': 'மாதா', 'englishName': 'MAADHA', 'balanceAmount': 0.0},
    {'name': 'அதிக்', 'englishName': 'ATHIK', 'balanceAmount': 0.0},
    {'name': 'மாஸ்', 'englishName': 'MASS', 'balanceAmount': 0.0},
    {'name': 'சிவானி', 'englishName': 'SHIVANI', 'balanceAmount': 0.0},
    {'name': 'அருண் ஹரீஸ்', 'englishName': 'ARUN HARISH', 'balanceAmount': 0.0},
  ];

  final batch = firestore.batch();

  for (final store in stores) {
    final docRef = firestore.collection('stores').doc();

    batch.set(docRef, {
      'name': store['name'],
      'englishName': store['englishName'],
      'district': 'ஆவூர்',
      'address': 'ஆவூர்',
      'phone': '',
      'email': '',
      'balanceAmount': store['balanceAmount'],
      'currentBalance': store['balanceAmount'],
      'totalTransactions': 0,
      'lastTransactionDate': '',
      'UpdatedAt': FieldValue.serverTimestamp(),
    });
  }

  await batch.commit();

  print('Successfully uploaded ${stores.length} Avoor stores');
}
