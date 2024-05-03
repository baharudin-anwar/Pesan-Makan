import 'package:aan_uts/cart.dart';
import 'package:flutter/material.dart';


import 'menu.dart';


void main() {
  runApp(const MyApp());
}


  List<Menu> listMenu = [];
  List<Menu> listMenuSearch = [];
  List<Menu> listMenuOrder = [];
  int harga = 0;
  bool isSearch = false;
  TextEditingController cariKey = TextEditingController();


class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Pesan Menu "Ayamku"'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {



  void dummyMenu() {
    listMenu.add(Menu(
        nama: 'Ayam Geprek',
        deskripsi: "Nasi dengan Ayam Crispy dengan Sambal Bawang",
        harga: 20000,
        gambar: 'ayam-geprek.jpg'));
    listMenu.add(Menu(
        nama: "Ayam Goreng",
        deskripsi: "Nasi dengan Ayam Goreng Gurih, Tempe dan Tahu Goreng",
        harga: 15000,
        gambar: 'ayam-goreng.jpg'));
    listMenu.add(Menu(
        nama: "Ayam Hainan",
        deskripsi: "Nasi dengan Ayam bumbu Hainan gurih dan kaya rempah",
        harga: 18000,
        gambar: 'ayam-hainan.jpg'));
    listMenu.add(Menu(
        nama: "Nasi Bakar Ayam",
        deskripsi: "Nasi Bakar dengan isian ayam suwir dan sambal terasi",
        harga: 25000,
        gambar: 'nasi-bakar-ayam.jpg'));
    listMenu.add(Menu(
        nama: "Ayam Mentega",
        deskripsi: "Nasi dengan Ayam Saus Mentega yang Smokey",
        harga: 25000,
        gambar: 'ayam-mentega.jpg'));
    listMenu.add(Menu(
        nama: "Ayam Panggang",
        deskripsi: "Nasi dengan Ayam dipanggang dengan Tumis Sawi",
        harga: 30000,
        gambar: 'ayam-panggang.jpg'));
  }


  void cekHarga() {
    harga = 0;
    for (int i = 0; i < listMenuOrder.length; i++) {
      harga += listMenuOrder[i].harga;
    }
  }

@override
  void initState() {
    // TODO: implement initState
    cekHarga();
    super.initState();
  }

  Widget gridContent(
      String nama, String desc, int harga, String img, int index) {
    return GestureDetector(
      onTap: () {
        listMenuOrder.add(listMenu[index]);
        cekHarga();
        setState(() {});
      },
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(30)),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              width: 100,
              height: 100,
              child: Image.asset(
                'assets/img/$img',
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              nama,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
            ),
            Text(
              'Rp ${harga.toString()}',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    if (listMenu.isEmpty) {
      dummyMenu();
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SafeArea(
            child: SingleChildScrollView(child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              SizedBox(child: TextFormField(controller: cariKey, decoration: InputDecoration(hintText: 'Pencarian..'), ), width: 0.65*MediaQuery.of(context).size.width,),
              IconButton(onPressed: (){
                listMenuSearch.clear();
                if(listMenu.isNotEmpty){
                 listMenuSearch.add(listMenu.firstWhere((element) => element.nama == cariKey.text));
                  
                }
                isSearch = true;
                setState(() {});
              }, icon:Icon( Icons.search,)),
               IconButton(onPressed: (){
                listMenuSearch.clear();
                cariKey.clear();
                isSearch = false;
                setState(() {});
              }, icon:Icon( Icons.delete,))
            ],),
            Container(
              height: 560,
              margin: EdgeInsets.only(top: 10),
              child: 
              isSearch == false?
              listMenu.isNotEmpty ?
              GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, crossAxisSpacing: 20),
                  children:
                  List.generate(
                      listMenu.length,
                      (index) => gridContent(
                          listMenu[index].nama,
                          listMenu[index].deskripsi,
                          listMenu[index].harga,
                          listMenu[index].gambar!,
                          index))):
                  Text('Data kosong !'): 
                  listMenuSearch.isNotEmpty?
                  GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, crossAxisSpacing: 20),
                  children:
                  List.generate(
                      listMenuSearch.length,
                      (index) => gridContent(
                          listMenuSearch[index].nama,
                          listMenuSearch[index].deskripsi,
                          listMenuSearch[index].harga,
                          listMenuSearch[index].gambar!,
                          index))):Text('Data kosong !'),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 120,
                    child: Column(
                      children: [
                        Text('Total Pesananku'),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Rp ${harga.toString()}',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context){return CartScreen();})).then((value) => setState(() {
                          cekHarga();
                        }));
                      },
                      child: Text('Keranjang'))
                ],
              ),
            ),
          ],
        ),)));
  }
}

