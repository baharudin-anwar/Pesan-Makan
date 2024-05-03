import 'package:aan_uts/main.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    
      void cekHarga() {
    harga = 0;
    for (int i = 0; i < listMenuOrder.length; i++) {
      harga += listMenuOrder[i].harga;
    }
  }

    return Scaffold(
      appBar: AppBar(
          title: Text('Keranjang'),
        ),
        body: SafeArea(child:  Column(children: [
          Container(
          height: 0.1*MediaQuery.of(context).size.height*listMenuOrder.length,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(
                  listMenuOrder.length,
                  (index) => ListTile(
                        trailing: IconButton(
                            onPressed: () {
                              listMenuOrder
                                  .removeAt(index);
                              cekHarga();
                              setState(() {});
                            },
                            icon: Icon(Icons.close)),
                        title: Text(
                            listMenuOrder[index]
                                .nama),
                        subtitle: Text(
                            listMenuOrder[index]
                                .harga
                                .toString()),
                      )),
            ),
          )),
          Center(child: ElevatedButton(onPressed: (){
            listMenuOrder.clear();
            setState(() {
              cekHarga();
            });
          }, child: Text('Hapus Semua')),)
        ],)),
    );
  }
}