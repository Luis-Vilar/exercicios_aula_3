class Client {
  String idClient;
  String nameClient;
  String emailClient;
  Client({required this.idClient, required this.nameClient, required this.emailClient});
  Client.fromMap(Map map)
    : idClient = map['id_cliente'],
      nameClient = map['nome'],
      emailClient = map['email'];
}

class Payment {
  String method;
  int installment;
  bool confirmed;

  Payment({
    required this.method,
    required this.installment,
    required this.confirmed,
  });

  Payment.fomMap(Map map)
    : method = map['metodo'],
      installment = map['parcelas'],
      confirmed = map['confirmado'];
}

class Item {
  String idItem;
  String nameItem;
  double unitValue;
  int quantity;

  Item({
    required this.idItem,
    required this.nameItem,
    required this.quantity,
    required this.unitValue,
  });
}

class ItemList {
  List<Item> itemList;
  ItemList({required this.itemList});
  ItemList.fromListMapStringDynamic(List<Map<String, dynamic>> itemList)
    : itemList = itemList
          .map(
            (item) => Item(
              idItem: item['id_produto'] as String,
              nameItem: item['nome'] as String,
              quantity: item['quantidade'] as int,
              unitValue: (item['preco_unitario'] as num).toDouble(),
            ),
          )
          .toList();
}

class Sale {
  String idSale;
  String createdAt;
  String status; //todo : implement enum
  Client client;
  Payment payment;
  ItemList itemList;

  Sale({
    required this.idSale,
    required this.createdAt,
    required this.status,
    required this.client,
    required this.payment,
    required this.itemList,
  });
}

class ListSales {
  List<Sale> salesList;

  ListSales({required this.salesList});

  ListSales.fromApi(List<Map<String, Object>> list)
    : salesList = list
          .map(
            (venda) => Sale(
              idSale: venda['id_pedido'] as String,
              createdAt: venda['data_criacao'] as String,
              status: venda['status'] as String,
              client: Client.fromMap(venda['cliente'] as Map),
              payment: Payment.fomMap(venda['pagamento'] as Map),
              itemList: ItemList.fromListMapStringDynamic(
                venda['itens'] as List<Map<String, dynamic>>,
              ),
            ),
          )
          .toList();

  void printSales() {
    for (var venda in salesList) {
      print(
        '[ID-VENDA : ${venda.idSale}] [ID-USUARIO : ${venda.client.idClient}][MÉTODO-PAGAMENTO : ${venda.payment.method}] \n[PRODUTOS : ${venda.itemList.itemList.map((item) => 'ID: ${item.idItem} || NOME : ${item.nameItem} || QUANTIDADE: ${item.quantity}] [VALOR UNITARIO ${item.unitValue}')}]\n',
      );
    }
  }
}
