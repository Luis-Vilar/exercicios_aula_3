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
      '[ID-VENDA : ${venda.idSale}] [ID-USUARIO : ${venda.client.idClient}][MÉTODO-PAGAMENTO : ${venda.payment.method}] \n[PRODUTOS : ${venda.itensList.itens.map((item) =>'ID: ${item.idItem} || NOME : ${item.name} || QUANTIDADE: ${item.quantity}] [VALOR UNITARIO ${item.unitValue}')}]\n',
    );
  }
}
