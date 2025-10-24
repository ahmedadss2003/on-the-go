// 📄 lib/scripts/generate_sitemap.dart
import 'dart:io';
import 'package:flutter/widgets.dart'; // ضروري عشان WidgetsFlutterBinding
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:on_the_go/core/models/tour_model.dart';
import 'package:on_the_go/firebase_options.dart'; // لو عندك ملف firebase_options.dart

Future<void> generateSitemap() async {
  final String baseUrl = 'https://onthegoexcursions.com';
  final String sitemapPath = 'web/sitemap.xml';
  final DateTime lastModified = DateTime.now().toUtc();

  final StringBuffer sitemap = StringBuffer('''
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <url>
    <loc>${baseUrl}/</loc>
    <lastmod>${lastModified.toIso8601String().split('T')[0]}</lastmod>
    <changefreq>weekly</changefreq>
    <priority>1.00</priority>
  </url>
  <url>
    <loc>${baseUrl}/about</loc>
    <lastmod>${lastModified.toIso8601String().split('T')[0]}</lastmod>
    <changefreq>monthly</changefreq>
    <priority>0.80</priority>
  </url>
  <url>
    <loc>${baseUrl}/contact</loc>
    <lastmod>${lastModified.toIso8601String().split('T')[0]}</lastmod>
    <changefreq>monthly</changefreq>
    <priority>0.80</priority>
  </url>
  <url>
    <loc>${baseUrl}/discover_places/Cairo%20Tours</loc>
    <lastmod>${lastModified.toIso8601String().split('T')[0]}</lastmod>
    <changefreq>weekly</changefreq>
    <priority>0.90</priority>
  </url>
  <url>
    <loc>${baseUrl}/discover_places/Luxor%20Tours</loc>
    <lastmod>${lastModified.toIso8601String().split('T')[0]}</lastmod>
    <changefreq>weekly</changefreq>
    <priority>0.90</priority>
  </url>
  <url>
    <loc>${baseUrl}/discover_places/Sharm%20El%20Sheikh%20Tours</loc>
    <lastmod>${lastModified.toIso8601String().split('T')[0]}</lastmod>
    <changefreq>weekly</changefreq>
    <priority>0.90</priority>
  </url>
  <url>
    <loc>${baseUrl}/transportation-booking-view</loc>
    <lastmod>${lastModified.toIso8601String().split('T')[0]}</lastmod>
    <changefreq>monthly</changefreq>
    <priority>0.60</priority>
  </url>
''');

  // 🧩 جلب البيانات من Firebase
  final QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('tours').get();

  final List<TourModel> tours =
      querySnapshot.docs.map((doc) {
        return TourModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

  // 🔗 إضافة روابط الرحلات
  for (var tour in tours) {
    sitemap.write('''
  <url>
    <loc>${baseUrl}/place_details/${tour.id}</loc>
    <lastmod>${lastModified.toIso8601String().split('T')[0]}</lastmod>
    <changefreq>weekly</changefreq>
    <priority>0.85</priority>
  </url>
''');
  }

  sitemap.write('</urlset>');

  final file = File(sitemapPath);
  await file.writeAsString(sitemap.toString());
  print('✅ Sitemap generated successfully at: ${file.path}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await generateSitemap();
}
