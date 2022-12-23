import 'dart:developer';

import 'package:app_sena/carrito/Carrito.dart';
import 'package:app_sena/data/get_user_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'data/get_user_name.dart';
import 'package:intl/intl.dart';


class PantallaCarrito extends StatefulWidget {
  @override
  _PantallaCarritoState createState() => _PantallaCarritoState();


}

class _PantallaCarritoState extends State<PantallaCarrito> {
  final user = FirebaseAuth.instance.currentUser!;

  List<String> docIds = [];

  Future getDocId() async {
    await FirebaseFirestore.instance.collection('cuentas').get().then(
            (snapshot) => snapshot.docs.forEach((document) {
          print(document.reference);
          docIds.add(document.reference.id);
        })
    );
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<Carrito>(builder: (context, carrito, child) {
      return Scaffold(
        backgroundColor: Colors.lightGreen[800],
        appBar: AppBar(
          title: Text("Pedidos"),
          elevation: 0,
          backgroundColor: Colors.lightGreen[700],
        ),
        body: Container(
          child: carrito.items.length == 0
              ? Center(
                  child: Text("Carrito Vacio"),
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    for (var item in carrito.items.values)
                      Card(
                          margin: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Image.asset(
                                "images/" + item.imagen,
                                width: 100,
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  height: 100,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(item.nombre),
                                      Text("\$" +
                                          item.precio.toStringAsFixed(3),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Container(
                                            child: IconButton(
                                              icon: Icon(
                                                Icons.remove,
                                                size: 13,
                                                color: Colors.white,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  carrito
                                                      .decrementarCantidadItem(
                                                          item.id);
                                                });
                                              },
                                            ),
                                            width: 50,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                color: Colors.lightGreen[800],
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(30))),
                                          ),
                                          Container(
                                            width: 20,
                                            child: Center(
                                              child: Text(
                                                  item.cantidad.toString()),
                                            ),
                                          ),
                                          Container(
                                            child: IconButton(
                                              icon: Icon(
                                                Icons.add,
                                                size: 13,
                                                color: Colors.white,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  carrito
                                                      .incrementarCantidadItem(
                                                          item.id);
                                                });
                                              },
                                            ),
                                            width: 50,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                color: Colors.lightGreen[800],
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(30))),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 100,
                                width: 70,
                                decoration:
                                    BoxDecoration(color: Color(0x99f0f0f0)),
                                child: Center(
                                  child: Text("\$" +
                                      (item.precio * item.cantidad).toStringAsFixed(3),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                ),
                              )
                            ],
                          )),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text("SubTotal:", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                          ),
                          Text("\$ " + carrito.subTotal.toStringAsFixed(3), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 16),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text("Costo Envio", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                          ),
                          Text("\$ " + carrito.impuesto.toStringAsFixed(3),  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 16),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text("Total:", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                          ),
                          Text("\$ " + carrito.total.toStringAsFixed(3), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 16),),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            String pedido = "";
            pedido = "$pedido" + "*Cliente :* " + "${user.email}" + "\n" +
            "-------------------------------------------------------------" + "\n";


            carrito.items.forEach((key, value) {
              pedido = '$pedido' +
                  "*-"+value.nombre + "*"+"\n" +
                  " *Cantidad :* " +
                  value.cantidad.toString() + "\n" +
                  " *Precio Unitario :* \$" +
                  value.precio.toStringAsFixed(3) + "\n" +
                  " *Precio Total :* \$" +
                  (value.cantidad * value.precio).toStringAsFixed(3) +
                  "\n" + "\n";
            });
            pedido = '$pedido' +  "*SubTotal:* \$"+carrito.subTotal.toStringAsFixed(3)+"\n";
            pedido = '$pedido' +  "*Costo Envio:* \$"+carrito.impuesto.toStringAsFixed(3)+"\n";
            pedido = '$pedido' +  "*Total:* \$"+carrito.total.toStringAsFixed(3)+"\n";
            pedido = '$pedido' +  "*Fecha Pedido :* "+DateFormat("yyyy-MM-dd hh:mm").format(DateTime.now());
            log(pedido);

            String celular= "+573196728751";
            String mensaje = pedido;
            String url = "whatsapp://send?phone=$celular&text=$mensaje";
            if(await canLaunch(url)){
              await launch(url);

            }else{
              throw('No se pudo enviar mensaje por whatsapp');
            }

          },
          backgroundColor: Colors.lightGreen[800],
          child: Icon(
            Icons.send,
            color: Colors.white,
          ),
        ),
      );
    });
  }
}
