module lang.sql.parsers.builders;

import lang.sql;

@safe:
class AliasBuilder : ISqlBuilder {

  auto hasAlias(parsed) {
    return ("alias" in parsed);
  }

  string build(array $parsed) {
    if (!isset($parsed["alias"]) || $parsed["alias"] == false) {
      return "";
    }

    string mySql = "";
    if ($parsed["alias"]["as"]) {
      mySql ~= " AS";
    }
    mySql ~= " " ~ $parsed["alias"]["name"];
    return mySql;
  }
}
