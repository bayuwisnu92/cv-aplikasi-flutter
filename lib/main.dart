import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const CvApp());
}

class CvApp extends StatelessWidget {
  const CvApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, themeNotifier, child) {
          return MaterialApp(
            theme:
                themeNotifier.isDarkMode ? ThemeData.dark() : ThemeData.light(),
            home: CvHomePage(),
          );
        },
      ),
    );
  }
}

class ThemeNotifier with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}

class CvHomePage extends StatelessWidget {
  final List<String> imageList = [
    'assets/image/bayu.png',
    'assets/image/bayu4.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bayu Wisnu Aji'),
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.phone),
            onPressed: () {
              _launchURL('tel:+6283806620512');
            },
          ),
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.whatsapp),
            onPressed: () {
              _launchURL('https://wa.me/6283806620512');
            },
          ),
          Switch(
            value: Provider.of<ThemeNotifier>(context).isDarkMode,
            onChanged: (value) {
              Provider.of<ThemeNotifier>(context, listen: false).toggleTheme();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'CV (Curriculum Vitae)',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            CarouselSlider(
              options: CarouselOptions(
                height: 200,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
              items: imageList
                  .map((item) => Container(
                        child: Center(
                          child:
                              Image.asset(item, fit: BoxFit.cover, width: 1000),
                        ),
                      ))
                  .toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'I. Data Pribadi',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  DataTable(
                    columns: [
                      DataColumn(label: Text('NO.')),
                      DataColumn(label: Text('KETERANGAN')),
                      DataColumn(label: Text('DETAIL')),
                    ],
                    rows: [
                      DataRow(cells: [
                        DataCell(Text('1')),
                        DataCell(Text('Nama')),
                        DataCell(Text('Bayu Wisnu Aji')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('2')),
                        DataCell(Text('Tempat dan Tanggal Lahir')),
                        DataCell(Text('Ngawi, 27 Oktober 1992')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('3')),
                        DataCell(Text('Alamat')),
                        DataCell(Text('123 Jalan Merdeka, Ngawi')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('4')),
                        DataCell(Text('Jenis Kelamin')),
                        DataCell(Text('Laki-laki')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('5')),
                        DataCell(Text('Kewarganegaraan')),
                        DataCell(Text('Indonesia')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('6')),
                        DataCell(Text('Status')),
                        DataCell(Text('Belum Menikah')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('7')),
                        DataCell(Text('Agama')),
                        DataCell(Text('Islam')),
                      ]),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'II. Pendidikan',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                      '• S1 Teknik Informatika - Universitas Indonesia (2010 - 2014)'),
                  Text('• SMA Negeri 1 Ngawi (2007 - 2010)'),
                  SizedBox(height: 20),
                  Text(
                    'III. Pengalaman Kerja',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text('• Software Engineer - PT. ABC (2015 - Sekarang)'),
                  Text('• Intern - PT. XYZ (2014 - 2015)'),
                  SizedBox(height: 20),
                  Text(
                    'IV. Keahlian',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text('• Pemrograman: Dart, Flutter, Java, Python'),
                  Text('• Database: MySQL, PostgreSQL'),
                  Text('• Tools: Git, Docker, Kubernetes'),
                  SizedBox(height: 20),
                  Text(
                    'V. Kontak',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text('• Email: bayu.wisnuaji@example.com'),
                  Text('• Telepon: +6283806620512'),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _launchURL('https://wa.me/6283806620512');
        },
        child: Icon(Icons.chat),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _launchURL(String url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }
}
