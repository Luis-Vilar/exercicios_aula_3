import 'package:exercicio_aula_3/db/data.dart';
import 'package:exercicio_aula_3/sales.class.dart';

void main(List<String> arguments) {
  ListSales listaVendas = ListSales.fromApi(listaPedidos);
  listaVendas.printSales();
}
