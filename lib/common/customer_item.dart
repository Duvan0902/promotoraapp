import 'package:flutter/material.dart';
import 'package:mi_promotora/models/portfolio_model.dart';
import 'package:mi_promotora/providers/portfolio_provider.dart';
import 'package:mi_promotora/utils/launch_url.dart';
import 'package:recase/recase.dart';

import '../main.dart';

class CustomerItem extends StatefulWidget {
  final PortfolioModel contact;

  CustomerItem(this.contact, {Key key}) : super(key: key);

  @override
  _CustomerItemState createState() => _CustomerItemState();
}

class _CustomerItemState extends State<CustomerItem> {
  String destinationPhone;
  PortfolioProvider _portfolioProvider = PortfolioProvider();

  @override
  void initState() {
    super.initState();
    destinationPhone = widget.contact.phone;
  }

  @override
  Widget build(BuildContext context) {
    var listTile = Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.contact.customerName.titleCase,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.black, fontSize: 16),
          ),
          SizedBox(height: 5),
          Text(
            widget.contact.insurance.titleCase,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.black45, fontSize: 15),
          ),
        ],
      ),
    );

    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: Colors.white,
        child: InkWell(
          child: Container(
            padding: EdgeInsets.fromLTRB(15, 15, 3, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                listTile,
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.call_outlined,
                      ),
                      color: MiPromotora().primaryDark,
                      iconSize: 30,
                      onPressed: () => callPhone(widget.contact.phone),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.message,
                      ),
                      color: MiPromotora().primaryDark,
                      iconSize: 30,
                      onPressed: () => _sendMessage(widget.contact),
                    ),
                  ],
                )
              ],
            ),
          ),
          onTap: () {
            print("Contact pressed");
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _sendMessage(PortfolioModel customer) async {
    String _message =
        "Hola, ${customer.customerName}, soy tu asesor de Seguros SURA, ${customer.agent.name}. Paso a saludarte y a recordarte que tienes un pago pendiente con la póliza de ${customer.insurance} por valor de ${customer.balance}. Para no perder cobertura y seguir disfrutando de los beneficios de nuestra compañía te invito a ponerte al día en cualquiera de nuestras plataformas de pago.";
    _message +=
        "\n1. Pago Express https://www.segurossura.com.co/paginas/pago-express.aspx";
    _message +=
        "\n2. Whatsapp https://api.whatsapp.com/send?phone=573152757888";
    _message +=
        "\nSi quieres optar otros medios de pago disponibles ingresa a este link https://www.segurossura.com.co/paginas/formas-pago/pago-convenio-bancos-redes.aspx para conocerlos da clic aquí.";

    Widget confirmateAlertDialog = AlertDialog(
      title: const Text('Enviar mensaje'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("¿Enviar mensaje al usuario seleccionado?"),
          Flexible(
            child: Scrollbar(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Text(
                  "$_message",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ),
          TextFormField(
            initialValue: destinationPhone,
            keyboardType: TextInputType.phone,
            onChanged: (value) {
              setState(() {
                destinationPhone = value;
              });
            },
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Enviar'),
          onPressed: () {
            customer.contacted = true;
            customer.updatedAt = DateTime.now();

            _portfolioProvider.updateContact(customer);
            String _url =
                "https://api.whatsapp.com/send?phone=${destinationPhone}&text=$_message";
            try {
              launchUrl(_url);
            } catch (e) {
              print("It wasn't possible to launch whatsapp in your mobile");
            }

            Navigator.of(context).pop();
          },
        ),
      ],
    );

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return confirmateAlertDialog;
      },
    );
  }
}
