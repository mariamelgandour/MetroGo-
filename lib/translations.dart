import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en': {
      'title': 'Metro Map',
      'home': 'Home',
      'feature': 'Feature',
      'settings': 'Settings',
      'dark_mode': 'Dark Mode',
      'light_mode': 'Light Mode',
      'we_wish_you_an_easy_trip': 'We Wish You an easy Trip',
      'nearest_metro_station': 'Nearest Metro Station',
      'please_open_gps': 'Please open GPS',
      'start_station': 'Start Station',
      'end_station': 'End Station',
      'select_station': 'Select Station',
      'get_details': 'Get Details',
      'use_default_location': 'Default location used (Cairo)',

      'route_from_to': 'Route from {start} to {end}',
      'to': 'to',
      'error': 'Error',
      'We Wish You an easy Trip': 'We Wish you an easy trip',
      "summary_title": "Route Summary",
      "stations": "stations",
      "minutes": "minutes",

      "path": "Path",
      "transfer_to": "Transfer to :line",
      "same_line": "On the same line (:line)",
      "no_transfer": "No transfer, same line",
      "transfer_station": "Transfer station",
      'select_both_stations': 'Please select both stations',
      'location_services_disabled': 'Location services are disabled.',
      'location_permissions_denied': 'Location permissions are denied',
      'location_permissions_permanently_denied':
          'Location permissions are permanently denied.',
      'metro_lines': 'Metro Lines',
      'ticket_price': 'Ticket Price',
      'number_of_individuals': 'Number Of Individuals',
      'count': 'Count',
      'choose_two_stations': 'Please select two valid stations',
      'minutes': 'minutes',
      'stations': 'stations',
      'total_amount': 'Total Amount',
      'currency': 'EGP',
      'select_line': 'Select Metro Line',
      'first_line': 'First Line',
      'second_line': 'Second Line',
      'third_line': 'Third Line',
      'select_metro_line': 'Select Metro Line',
      'zoom_icon_hint': 'Zoom image',
      'trip_details': 'Trip Details',
      'from': 'From',
      'to': 'To',
      'search': 'Search',
      'change_line': 'Change to another line',
      'from_to': 'From: @start\nTo: @end',
      'transfer_info': 'Transfer Information',
      'stations_count': ' stations',
      'minutes_count': 'minutes',

      'unknown_station': 'One of the stations is unknown',
      "unknown": "Unknown",
      "not_available": "Not available",
      "stations_count": "Number of stations",
      "estimated_time": "Estimated time",
      "price": "Price",
      "egp": "EGP",
      "minutes": "minutes",
      "route_path": "Route",

      'summary_title': 'Trip Summary',
      'stations': 'Stations',
      'minutes': 'Minutes',
      'route_from_to': 'Route from @start to @end',
      'path': 'Path',
      'no_transfer': 'No transfer needed',
      'transfer_to': 'Transfer to @line line',
      'same_line': 'Continue on @line line',
      'transfer_station': 'Transfer at: @station',
      'back': 'Back',
      'total_time': 'Total Time',
      'total_stations': 'Total Stations',
      'ticket_price': 'Ticket Price',
      "no_routes_found": "No routes found",

      // Line 1 Stations
      'line1_helwan': 'Helwan',
      'line1_ain_helwan': 'Ain Helwan',
      'line1_helwan_university': 'Helwan University',
      'line1_wadi_hoff': 'Wadi Hoff',
      'line1_helwan_garden': 'Helwan Garden',
      'line1_el_maasara': 'El-Maasara',
      'line1_tura_el_asmant': 'Tura El-Asmant',
      'line1_kozzika': 'Kozzika',
      'line1_tora_el_balad': 'Tora El-Balad',
      'line1_sakanat_el_maadi': 'Sakanat El-Maadi',
      'line1_el_maadi': 'El-Maadi',
      'line1_hadayeq_el_maadi': 'Hadayeq El-Maadi',
      'line1_dar_el_salam': 'Dar El-Salam',
      'line1_el_zahraa': 'El-Zahraa',
      'line1_mar_girgis': 'Mar Girgis',
      'line1_el_malek_el_saleh': 'El Malek El-Saleh',
      'line1_el_sayeda_zeinab': 'El-Sayeda Zeinab',
      'line1_saad_zaghloul': 'Saad Zaghloul',
      'line1_sadat': 'Sadat',
      'line1_gamal_abd_al_nasser': 'Gamal Abd Al-Nasser',
      'line1_orabi': 'Orabi',
      'line1_al_shohadaa': 'Al-Shohadaa',
      'line1_ghamra': 'Ghamra',
      'line1_el_demerdash': 'El-Demerdash',
      'line1_manshiet_el_sadr': 'Manshiet El-Sadr',
      'line1_kobri_el_qobba': 'Kobri El-Qobba',
      'line1_hammamat_el_kobba': 'Hammamat El-Kobba',
      'line1_saray_el_kobba': 'Saray El-Kobba',
      'line1_hadayeq_el_zaitoun': 'Hadayeq El-Zaitoun',
      'line1_helmeyat_el_zaitoun': 'Helmeyat El-Zaitoun',
      'line1_ain_shams': 'Ain Shams',
      'line1_ezbet_el_nakhl': 'Ezbet El-Nakhl',
      'line1_el_marg': 'El-Marg',
      'line1_new_el_marg': 'New El-Marg',

      // Line 2 Stations
      'line2_shubra_el_kheima': 'Shubra El-Kheima',
      'line2_kolleyyet_el_zeraa': 'Kolleyyet El-Zeraa',
      'line2_el_mazallat': 'El Mazallat',
      'line2_al_khalafawi': 'Al Khalafawi',
      'line2_st_teresa': 'St. Teresa',
      'line2_rod_el_farag': 'Rod El-Farag',
      'line2_masra': 'Masra',
      'line2_el_shohada': 'El Shohada',
      'line2_attaba': 'Attaba',
      'line2_mohamed_naguib': 'Mohamed Naguib',
      'line2_opera': 'Opera',
      'line2_dokki': 'Dokki Metro Station',
      'line2_bohouth': 'Bohouth Metro Station',
      'line2_cairo_university': 'Cairo University',
      'line2_faisal': 'Faisal Metro Station',
      'line2_giza': 'Giza Metro Station',
      'line2_omm_el_misryeen': 'Omm El-Misryeen',
      'line2_sakiat_mekki': 'Sakiat Mekki',
      'line2_el_monib': 'El Monib',

      // Line 3 Stations
      'line3_tawfikia': 'Tawfikia',
      'line3_wadi_al_nile': 'Wadi Al Nile Metro Station',
      'line3_arab_league': 'Arab League Metro Station',
      'line3_boulaq': 'Boulaq Metro Station',
      'line3_roud_al_farag_axis': 'Roud AL-farag Axis',
      'line3_ring_road': 'Ring Road',
      'line3_national': 'National Metro Station',
      'line3_al_bouhi': 'Al-Bouhi',
      'line3_imbaba': 'Imbaba',
      'line3_al_sudan': 'Al-Sudan',
      'line3_kit_kat': 'Kit Kat',
      'line3_safaa_hegazy': 'Safaa Hegazy',
      'line3_maspero': 'Maspero',
      'line3_bab_el_shaariya': 'Bab El-Shaariya',
      'line3_el_geish': 'El-Geish',
      'line3_abdou_pasha': 'Abdou Pasha',
      'line3_el_abassiya': 'El-Abassiya',
      'line3_fair_zone': 'Fair Zone',
      'line3_cairo_stadium': 'Cairo Stadium',
      'line3_kolleyet_el_banat': 'Kolleyet El-Banat',
      'line3_el_ahram': 'El-Ahram',
      'line3_haroun': 'Haroun',
      'line3_heliopolis': 'Heliopolis',
      'line3_alf_maskan': 'Alf Maskan',
      'line3_el_shams_club': 'El-Shams Club',
      'line3_el_nozha': 'El-Nozha',
      'line3_hesham_barakat': 'Hesham Barakat',
      'line3_qubaa': 'Qubaa',
      'line3_omar_ibn_el_khattab': 'Omar Ibn El-Khattab',
      'line3_el_haykestep': 'El-Haykestep',
      'line3_adli_mansour': 'Adli Mansour',
      "same_line": "On the same line ({line})",
      'settings': 'Settings',
      'dark_mode': 'Dark Mode',
      'dark_mode_title': 'Dark Mode',
      'light_mode_title': 'Light Mode',
      'language': 'Language',
      'about_app': 'About the App',
      'about_developer': 'About Developers',
      'route_from_to': 'From {start} to {end}',
    },
    'ar': {
      'title': 'خريطة المترو',
      'home': 'الرئيسية',
      'feature': 'الميزة',
      'settings': 'الإعدادات',
      'dark_mode': 'الوضع الداكن',
      'light_mode': 'الوضع الفاتح',
      'we_wish_you_an_easy_trip': 'نتمنى لك رحلة سعيدة',
      'nearest_metro_station': 'أقرب محطة مترو',
      'please_open_gps': 'من فضلك فعّل الـ GPS',
      'start_station': 'محطة البداية',
      'end_station': 'محطة النهاية',
      'select_station': 'اختر محطة',
      'get_details': 'احصل على التفاصيل',
      'error': 'خطأ',
      'select_both_stations': 'يرجى اختيار المحطتين',
      'location_services_disabled': 'خدمات الموقع غير مفعلة.',
      'location_permissions_denied': 'تم رفض صلاحيات الموقع.',
      'location_permissions_permanently_denied':
          'تم رفض صلاحيات الموقع نهائيًا.',
      'metro_lines': 'خطوط المترو',
      'ticket_price': 'سعر التذكرة',
      'number_of_individuals': 'عدد الأفراد',
      'count': 'العدد',
      'choose_two_stations': 'يرجى اختيار محطتين صحيحتين',
      'minutes': 'دقيقة',
      'stations': 'محطة',
      'total_amount': 'الإجمالي',
      'currency': 'جنيه',
      'select_line': 'اختر خط المترو',
      'first_line': 'الخط الأول',
      'second_line': 'الخط الثاني',
      'third_line': 'الخط الثالث',
      'select_metro_line': 'اختر خط المترو',
      'zoom_icon_hint': 'تكبير الصورة',
      'trip_details': 'تفاصيل الرحلة',
      'from': 'من',
      'to': 'إلى',
      'search': 'بحث',
      'change_line': 'التبديل إلى خط آخر',
      'from_to': 'من: @start\nإلى: @end',
      'transfer_info': 'معلومات التبديل',
      'stations_count': ' محطات',
      'minutes_count': 'دقائق',
      'route_from_to': 'من: @start\nإلى: @end',
      'same_line': 'المحطتان على نفس الخط (@line)',
      'transfer_station': 'محطة التبديل: @station (من @startLine إلى @endLine)',
      'transfer_stations':
          'محطات التبديل المتاحة: @stations (من @startLine إلى @endLine)',
      'no_transfer': 'لا توجد محطات تبديل معروفة بين الخطين',
      'unknown_station': 'إحدى المحطتين غير معروفة',

      // Line 1
      'line1_helwan': 'حلوان',
      'line1_ain_helwan': 'عين حلوان',
      'line1_helwan_university': 'جامعة حلوان',
      'line1_wadi_hoff': 'وادي حوف',
      'line1_helwan_garden': 'حدائق حلوان',
      'line1_el_maasara': 'المعصرة',
      'line1_tura_el_asmant': 'طرة الأسمنت',
      'line1_kozzika': 'كوتسيكا',
      'line1_tora_el_balad': 'طرة البلد',
      'line1_sakanat_el_maadi': 'سكك حديد المعادي',
      'line1_el_maadi': 'المعادي',
      'line1_hadayeq_el_maadi': 'حدائق المعادي',
      'line1_dar_el_salam': 'دار السلام',
      'line1_el_zahraa': 'الزهراء',
      'line1_mar_girgis': 'مار جرجس',
      'line1_el_malek_el_saleh': 'الملك الصالح',
      'line1_el_sayeda_zeinab': 'السيدة زينب',
      'line1_saad_zaghloul': 'سعد زغلول',
      'line1_sadat': 'السادات',
      'line1_gamal_abd_al_nasser': 'جمال عبد الناصر',
      'line1_orabi': 'عرابي',
      'line1_al_shohadaa': 'الشهداء',
      'line1_ghamra': 'غمرة',
      'line1_el_demerdash': 'الدمرداش',
      'line1_manshiet_el_sadr': 'منشية الصدر',
      'line1_kobri_el_qobba': 'كوبري القبة',
      'line1_hammamat_el_kobba': 'حمامات القبة',
      'line1_saray_el_kobba': 'قصر القبة',
      'line1_hadayeq_el_zaitoun': 'حدائق الزيتون',
      'line1_helmeyat_el_zaitoun': 'حلمية الزيتون',
      'line1_ain_shams': 'عين شمس',
      'line1_ezbet_el_nakhl': 'عزبة النخل',
      'line1_el_marg': 'المرج',
      'line1_new_el_marg': 'المرج الجديدة',

      // Line 2
      'line2_shubra_el_kheima': 'شبرا الخيمة',
      'line2_kolleyyet_el_zeraa': 'كلية الزراعة',
      'line2_el_mazallat': 'المظلات',
      'line2_al_khalafawi': 'الخلفاوي',
      'line2_st_teresa': 'سانت تريزا',
      'line2_rod_el_farag': 'روض الفرج',
      'line2_masra': 'مسرة',
      'line2_el_shohada': 'الشهداء',
      'line2_attaba': 'العتبة',
      'line2_mohamed_naguib': 'محمد نجيب',
      'line2_opera': 'الأوبرا',
      'line2_dokki': 'الدقي',
      'line2_bohouth': 'البحوث',
      'line2_cairo_university': 'جامعة القاهرة',
      'line2_faisal': 'الفيصل',
      'line2_giza': 'الجيزة',
      'line2_omm_el_misryeen': 'أم المصريين',
      'line2_sakiat_mekki': 'ساقية مكي',
      'line2_el_monib': 'المنيب',

      // Line 3
      'line3_tawfikia': 'التوفيقية',
      'line3_wadi_al_nile': 'وادي النيل',
      'line3_arab_league': 'جامعة الدول',
      'line3_boulaq': 'بولاق الدكرور',
      'line3_roud_al_farag_axis': 'محور روض الفرج',
      'line3_ring_road': 'الدائري',
      'line3_national': 'الوطنية',
      'line3_al_bouhi': 'البوهي',
      'line3_imbaba': 'إمبابة',
      'line3_al_sudan': 'السودان',
      'line3_kit_kat': 'الكيت كات',
      'line3_safaa_hegazy': 'صفاء حجازي',
      'line3_maspero': 'ماسبيرو',
      'line3_bab_el_shaariya': 'باب الشعرية',
      'line3_el_geish': 'الجيش',
      'line3_abdou_pasha': 'عبده باشا',
      'line3_el_abassiya': 'العباسية',
      'line3_fair_zone': 'أرض المعارض',
      'line3_cairo_stadium': 'استاد القاهرة',
      'line3_kolleyet_el_banat': 'كلية البنات',
      'line3_el_ahram': 'الأهرام',
      'line3_haroun': 'هارون',
      'line3_heliopolis': 'هيليوبوليس',
      'line3_alf_maskan': 'ألف مسكن',
      'line3_el_shams_club': 'نادي الشمس',
      'line3_el_nozha': 'النزهة',
      'line3_hesham_barakat': 'هشام بركات',
      'line3_qubaa': 'قباء',
      'line3_omar_ibn_el_khattab': 'عمر بن الخطاب',
      'line3_el_haykestep': 'الهايكستب',
      'line3_adli_mansour': 'عدلي منصور',
      "unknown": "غير معروفة",
      "not_available": "غير متاح",
      "stations_count": "عدد المحطات",
      "estimated_time": "الزمن التقريبي",
      "price": "التكلفة",
      "egp": "جنيه",
      "minutes": "دقيقة",
      "route_path": "المسار",
      "transfer_stations": "محطات التبديل",
      "no_routes_found": "لا توجد مسارات",
      "trip_summary": "ملخص الرحلة",
      "route_number": "المسار :num",
      'settings': 'الإعدادات',
      'dark_mode': 'الوضع الداكن',
      'dark_mode_title': 'الوضع الداكن',
      'light_mode_title': 'الوضع الفاتح',
      'language': 'اللغة',
      'about_app': 'حول التطبيق',
      'about_developer': 'حول المطورين',

      'summary_title': 'ملخص الرحلة',
      'stations': 'محطات',
      'minutes': 'دقائق',

      'path': 'مسار',
      'no_transfer': 'لا يوجد تبديل خطوط',
      'transfer_to': 'التبديل إلى خط @line',
      'same_line': 'مستمر على خط @line',
      'transfer_station': 'محطة التبديل: @station',
      'back': 'رجوع',
      'total_time': 'الوقت الكلي',
      'total_stations': 'إجمالي المحطات',
      'ticket_price': 'سعر التذكرة',
      "route_from_to": "مسار من @start إلى @end",
      'We Wish You an easy Trip': 'نتمنى لك رحلة سهلة',
      "route_from_to": "مسار من {start} إلى {end}",
      "to": "إلى",
      'use_default_location':
          'تم استخدام القاهره كموقع افتراضي عند بدايه الاستخدام',
    },
  };
}

extension CustomTranslation on String {
  String trParams(Map<String, String> params) {
    String translated = this.tr; // الحصول على الترجمة الأساسية
    params.forEach((key, value) {
      translated = translated.replaceAll(
        '@$key',
        value,
      ); // استبدال @key بالقيمة
    });
    return translated;
  }
}
