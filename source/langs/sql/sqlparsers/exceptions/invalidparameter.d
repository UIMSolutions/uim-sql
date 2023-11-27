module langs.sql.sqlparsers.exceptions.invalidparameter;

import lang.sql;

@safe:

// This exception will occur in the parser, if the given SQL statement is not a String type. 
class InvalidParameterException : InvalidArgumentException {

  protected _argument;

  this(anArgument) {
    _argument = anArgument;
    super("no SQL string to parse: \n" ~ _argument, 10);
  }

  auto argument() {
    return _argument;
  }
}
