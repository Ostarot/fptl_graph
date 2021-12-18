//{Constant, Parallel, Take, Function, Sequential, Scheme, Condition}

class FPTLNode {

  late int id;
  late String type;
  late int? from;
  late int? to;
  late String? name;
  late String? valueType;
  late String? value;
  late int? line;
  late int? column;
  late bool complex;
  late List? children;

  late String str;

  FPTLNode(node) {
    id = node['id'];
    type = node['type'];
    from = node['from'];
    to = node['to'];
    name = node['name'];
    valueType = node['valueType'];
    value = node['value'];
    line = node['line'];
    column = node['column'];
    complex = node['complex'] == 1;
    children = node['children'];

    String fromTo = from == null
        ? (to == null ? "" : "[, $to]")
        : (to == null ? "[$from,]" : "[$from, $to]");

    String lnCn = line != null && column != null ? '\nLine: $line Column: $column' : '';

    str = "$type$fromTo Id=$id"
        "${name == null ? '' : '\n$name'}"
        "${valueType == null ? '' : '\n$valueType'}"
        "${value == null ? '' : '\n$value'}"
        "$lnCn"
        "${children == null ? '' : '\n$children'}"
    ;
  }
}
