class Client {
  String idClient;
  String name;
  String email;
  Client({required this.idClient, required this.name, required this.email});
  Client.fromMap(Map map)
    : idClient = map['id_cliente'],
      name = map['nome'],
      email = map['email'];
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
  String name;
  double unitValue;
  int quantity;

  Item({
    required this.idItem,
    required this.name,
    required this.quantity,
    required this.unitValue,
  });
}

class ItemList {
  List<Item> itensList;
  ItemList({required this.itensList});
  ItemList.fromListMapStringDynamic(List<Map<String, dynamic>> itemList)
    : itensList = itemList
          .map(
            (item) => Item(
              idItem: item['id_produto'] as String,
              name: item['nome'] as String,
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
  ItemList itensList;

  Sale({
    required this.idSale,
    required this.createdAt,
    required this.status,
    required this.client,
    required this.payment,
    required this.itensList,
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
              itensList: ItemList.fromListMapStringDynamic(
                venda['itens'] as List<Map<String, dynamic>>,
              ),
            ),
          )
          .toList();

  void printSales() {
    for (var venda in this.salesList) {
      print(
        '[ID-VENDA : ${venda.idSale}] [ID-USUARIO : ${venda.client.idClient}][MÉTODO-PAGAMENTO : ${venda.payment.method}] \n[PRODUTOS : ${venda.itensList.itensList.map((item) => 'ID: ${item.idItem} || NOME : ${item.name} || QUANTIDADE: ${item.quantity}] [VALOR UNITARIO ${item.unitValue}')}]\n',
      );
    }
  }
}
