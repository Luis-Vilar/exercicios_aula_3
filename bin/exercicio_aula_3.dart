import 'package:exercicio_aula_3/db/data.dart';
import 'package:exercicio_aula_3/exercicio_aula_3.dart';

void main(List<String> arguments) {
  ListSales listaVendas = ListSales.fromApi(listaPedidos);
  listaVendas.printSales();
}
