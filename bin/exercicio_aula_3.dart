import 'package:exercicio_aula_3/db/data.dart';
import 'package:exercicio_aula_3/exercicio_aula_3.dart';

void main(List<String> arguments) {
  Iterable<Sales> vendas = listaPedidos.map(
    (venda) => Sales(
      idSale: venda['id_pedido'] as String,
      createdAt: venda['data_criacao'] as String,
      status: venda['status'] as String,
      client: Client.fromApi(venda['cliente'] as Map),
      payment: Payment.fomApi(venda['pagamento'] as Map),
      itensList: ItemList.fromApi(venda['itens'] as List<Map<String, dynamic>>),
    ),
  );

  for (var venda in vendas) {
    print(
      'Email : ${venda.client.email} Produtos Comprados : ${venda.itensList.itens.length} Pagamento : ${venda.payment.method}',
    );
  }
}
