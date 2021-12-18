//{Constant, Parallel, Take, Function, Sequential, Scheme, Condition}

class Constant {

  int id, line, column;
  String type, valueType;
  String value; //сделать double????

  Constant(this.id, this.type, this.line, this.column, this.valueType, this.value);

  @override
  String toString(){
    return 'id=$id $type $value';
  }
}

class Parallel {
  int id, complex; //complex {0,1}
  String type;
  List children; //2 всегда, один из них - свой ид

  Parallel(this.id, this.type, this.complex, this.children);

  @override
  String toString(){
    return 'id=$id $type $complex\n $children';
  }
}

class Take {
  int id, line, column, from, to;
  String type;

  Take(this.id, this.type, this.line, this.column, this.from, this.to);

  @override
  String toString(){
    return 'id=$id $type';
  }
}

class Function1 {
  int id, line, column, complex;
  String type, name;

  Function1(this.id, this.type, this.line, this.column, this.complex, this.name);

  @override
  String toString(){
    return 'id=$id $type $complex $name';
  }
}

class Sequential {
  int id, complex; //complex {0,1}
  String type;
  List children; //list?? length=1

  Sequential(this.id, this.type, this.complex, this.children);

  @override
  String toString(){
    return 'id=$id $type $complex\n $children';
  }
}

class Scheme {
  int id, complex;
  String type, name;
  List children;

  Scheme(this.id, this.type, this.complex, this.name, this.children);

  @override
  String toString(){
    return 'id=$id $type $complex\n $children';
  }
}

class Condition {
  int id, complex; //complex {0,1}
  String type;
  List children; //list?? length=3

  Condition(this.id, this.type, this.complex, this.children);

  @override
  String toString(){
    return 'id=$id $type $complex\n $children';
  }
}
