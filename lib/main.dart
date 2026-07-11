import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:radio_sea_well/app/data/bindings/initial_bindings.dart';
import 'package:radio_sea_well/app/modules/dashboard/controller/dashboard_controller.dart';
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

Future<void> uploadThirukattupalliUpdatedStores() async {
  final firestore = FirebaseFirestore.instance;

  final stores = [
    {
      'name': 'செந்தில்',
      'englishName': 'SENTHIL',
      'balanceAmount': 0.0,
    },
    {
      'name': 'ஓம்சக்தி',
      'englishName': 'OMSAKTHI',
      'balanceAmount': 0.0,
    },
    {
      'name': 'KS குட்டி',
      'englishName': 'KS KUTTY',
      'balanceAmount': 290.0,
    },
    {
      'name': 'ஆம்ஸ்',
      'englishName': 'AARMS',
      'balanceAmount': 0.0,
    },
    {
      'name': 'யாசின்',
      'englishName': 'YASIN',
      'balanceAmount': 200.0,
    },
    {
      'name': 'அப்ஸா',
      'englishName': 'APSHA',
      'balanceAmount': 0.0,
    },
    {
      'name': 'ஜஹபர்அலி',
      'englishName': 'JAHABER ALI',
      'balanceAmount': 0.0,
    },
    {
      'name': 'கங்கா',
      'englishName': 'GANGA',
      'balanceAmount': 0.0,
    },
    {
      'name': 'ஆதேஷ்',
      'englishName': 'AADHESH',
      'balanceAmount': 0.0,
    },
    {
      'name': 'சிராஜ்',
      'englishName': 'SIRAJ',
      'balanceAmount': 0.0,
    },
    {
      'name': 'ஆனந்தம்',
      'englishName': 'AANANDHAM',
      'balanceAmount': 0.0,
    },
    {
      'name': 'ராஜேந்திரன்',
      'englishName': 'RAJENDHIRAN',
      'balanceAmount': 506.0,
    },
    {
      'name': 'ரமேஷ்',
      'englishName': 'RAMESH',
      'balanceAmount': 2078.0,
    },
    {
      'name': 'சுகுமாரன்',
      'englishName': 'SUGUMARAN',
      'balanceAmount': 0.0,
    },
    {
      'name': 'சண்முகம்',
      'englishName': 'SANMUGAM',
      'balanceAmount': 1560.0,
    },
    {
      'name': 'கண்ணன்',
      'englishName': 'KANNAN',
      'balanceAmount': 0.0,
    },
    {
      'name': 'கண்ணன்-II',
      'englishName': 'KANNAN-II',
      'balanceAmount': 0.0,
    },
    {
      'name': '2 K',
      'englishName': '2 K',
      'balanceAmount': 0.0,
    },
    {
      'name': 'சேதுராமன்',
      'englishName': 'SETHURAMAN',
      'balanceAmount': 1270.0,
    },
    {
      'name': 'லக்கி',
      'englishName': 'LUCKY',
      'balanceAmount': 0.0,
    },
    {
      'name': 'சையதுஅலி',
      'englishName': 'SYEDALI',
      'balanceAmount': 338.0,
    },
    {
      'name': 'சக்தி',
      'englishName': 'SAKTHI',
      'balanceAmount': 0.0,
    },
    {
      'name': 'சிங்கப்பூர்',
      'englishName': 'SINGAPORE',
      'balanceAmount': 0.0,
    },
    {
      'name': 'பாட்டிகடை',
      'englishName': 'PATTIKADAI',
      'balanceAmount': 0.0,
    },
    {
      'name': 'தாரணி',
      'englishName': 'THARANI',
      'balanceAmount': 0.0,
    },
    {
      'name': 'ஜெஸ்வின்',
      'englishName': 'JESWIN',
      'balanceAmount': 0.0,
    },
    {
      'name': 'ஆரிப்',
      'englishName': 'AARIF',
      'balanceAmount': 582.0,
    },
    {
      'name': 'அக்பர்',
      'englishName': 'AKBAR',
      'balanceAmount': 1700.0,
    },
    {
      'name': 'BRM',
      'englishName': 'BRM',
      'balanceAmount': 340.0,
    },
    {
      'name': 'ஆமீனா',
      'englishName': 'AAMEENA',
      'balanceAmount': 0.0,
    },    {
      'name': 'குறிஞ்சி',
      'englishName': 'KURINJI',
      'balanceAmount': 0.0,
    },
    {
      'name': 'ரகுமான்',
      'englishName': 'RAHUMAN',
      'balanceAmount': 0.0,
    },
    {
      'name': 'மலர்விழி',
      'englishName': 'MALARVIZHI',
      'balanceAmount': 0.0,
    },
    {
      'name': 'புஷ்பம்',
      'englishName': 'PUSHPAM',
      'balanceAmount': 0.0,
    },
    {
      'name': 'சரவணன் நாடார்',
      'englishName': 'SARAVANAN NADAR',
      'balanceAmount': 0.0,
    },
    {
      'name': 'அன்னை',
      'englishName': 'ANNAI',
      'balanceAmount': 0.0,
    },
    {
      'name': 'பார்வதி',
      'englishName': 'PARVATHY',
      'balanceAmount': 0.0,
    },
    {
      'name': 'கதிர்வேல்',
      'englishName': 'KATHIRVEL',
      'balanceAmount': 1732.0,
    },
    {
      'name': 'சுப்ரமணியன்',
      'englishName': 'SUBRAMANIYAN',
      'balanceAmount': 0.0,
    },
    {
      'name': 'மகாகணபதி',
      'englishName': 'MAGAGANAPATHY',
      'balanceAmount': 0.0,
    },
    {
      'name': 'மூரா சன்ஸ்',
      'englishName': 'MURA SONS',
      'balanceAmount': 450.0,
    },
    {
      'name': 'சங்கர்-II',
      'englishName': 'SANKAR-II',
      'balanceAmount': 1500.0,
    },
    {
      'name': 'முருகன்',
      'englishName': 'MURUGAN',
      'balanceAmount': 1300.0,
    },
    {
      'name': 'அய்யனார்',
      'englishName': 'AYYANAR',
      'balanceAmount': 0.0,
    },
    {
      'name': 'சீனிவாசா',
      'englishName': 'SRINIVASA',
      'balanceAmount': 0.0,
    },
    {
      'name': 'அருண்',
      'englishName': 'ARUN',
      'balanceAmount': 0.0,
    },
    {
      'name': 'கணபதி',
      'englishName': 'GANAPATHI',
      'balanceAmount': 0.0,
    },
    {
      'name': 'கௌதம்',
      'englishName': 'GOWTHAM',
      'balanceAmount': 0.0,
    },
    {
      'name': 'கண்ணன் - III',
      'englishName': 'KANNAN-III',
      'balanceAmount': 0.0,
    },
    {
      'name': 'துர்க்கையம்மன்',
      'englishName': 'DURGAIAMMAN',
      'balanceAmount': 0.0,
    },
    {
      'name': 'செல்வம்பாள்',
      'englishName': 'SELVAMBAL',
      'balanceAmount': 0.0,
    },
    {
      'name': 'அனுசியா',
      'englishName': 'ANUSHIYA',
      'balanceAmount': 0.0,
    },
    {
      'name': 'அனுசியா-II',
      'englishName': 'ANUSHIYA-II',
      'balanceAmount': 0.0,
    },
    {
      'name': 'அய்யப்பன்',
      'englishName': 'AYYAPPAN',
      'balanceAmount': 0.0,
    },
    {
      'name': 'ஜெயராமன்',
      'englishName': 'JAYARAMAN',
      'balanceAmount': 590.0,
    },
    {
      'name': 'பரணிவிக்னேஷ்',
      'englishName': 'BARANIVIGNESH',
      'balanceAmount': 1310.0,
    },
    {
      'name': 'தன்யஸ்ரீ',
      'englishName': 'DHANYASRI',
      'balanceAmount': 500.0,
    },
    {
      'name': 'மைதீன்பாட்ஷா',
      'englishName': 'MAIDEEN BATCHA',
      'balanceAmount': 1270.0,
    },
    {
      'name': 'காயத்ரி',
      'englishName': 'GAYATHRI',
      'balanceAmount': 672.0,
    },
    {
      'name': 'ராஜவேலு',
      'englishName': 'RAJA VELU',
      'balanceAmount': 1800.0,
    },    {
      'name': 'தனம்',
      'englishName': 'DHANAM',
      'balanceAmount': 1014.0,
    },
    {
      'name': 'ஸ்ரீ சாய்',
      'englishName': 'SRISAI',
      'balanceAmount': 0.0,
    },
    {
      'name': 'பெரோஸ்',
      'englishName': 'FEROSE',
      'balanceAmount': 0.0,
    },
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
    {'name': 'பன்னீர்செல்வம்', 'englishName': 'PANNERSELVAM', 'balanceAmount': 0.0},
    {'name': 'நவமணி-I', 'englishName': 'NAVAMANI-I', 'balanceAmount': 16000.0},
    {'name': 'நவமணி-II', 'englishName': 'NAVAMANI-II', 'balanceAmount': 11640.0},
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
    {'name': 'நேஷனல்(பேராவூர்)', 'englishName': 'NATIONAL(PERAVUR)', 'balanceAmount': 0.0},
    {'name': 'கணேசன்', 'englishName': 'GANESAN', 'balanceAmount': 640.0},
    {'name': 'நேஷனல்(திருநீலக்குடி)', 'englishName': 'NATIONAL(THIRUNEELAKUDI)', 'balanceAmount': 3200.0},
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
    {'name': 'நேஷனல்(சாத்தனூர்)', 'englishName': 'NATONAL(SAATHANUR)', 'balanceAmount': 2600.0},
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
