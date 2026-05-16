class Client {
  String idClient;
  String name;
  String email;
  Client({required this.idClient, required this.name, required this.email});
  Client.fromApi(Map map)
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

  Payment.fomApi(Map map)
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
  List<Item> itens;
  ItemList({required this.itens});
  ItemList.fromApi(List<Map<String,dynamic>> itemList)
    : itens = itemList.map(
        (item) => Item(
          idItem: item['id_produto'] as String,
          name: item['nome'] as String,
          quantity: item['quantidade'] as int,
          unitValue: (item['preco_unitario'] as num).toDouble(),
        ),
      ).toList();
}

class Sales {
  String idSale;
  String createdAt;
  String status; //todo : implement enum
  Client client;
  Payment payment;
  ItemList itensList;

  Sales({
    required this.idSale,
    required this.createdAt,
    required this.status,
    required this.client,
    required this.payment,
    required this.itensList,
  });
}
