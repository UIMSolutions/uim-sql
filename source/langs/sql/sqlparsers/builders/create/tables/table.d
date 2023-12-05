module langs.sql.sqlparsers.builders.create.tables.table;

import lang.sql;

@safe:
/**
 * Builds the CREATE TABLE statement
 * This class : the builder for the CREATE TABLE statement. You can overwrite
 * all functions to achieve another handling.   */
class CreateTableBuilder : ISqlBuilder {

  string build(Json parsedSql) {
    string mySql = parsedSql["name"].get!string;
   mySql ~= this.buildCreateTableDefinition(parsedSql);
   mySql ~= this.buildCreateTableOptions(parsedSql);
   mySql ~= this.buildCreateTableSelectOption(parsedSql);
    return mySql;
  }

  protected string buildCreateTableDefinition(Json parsedSql) {
    auto myBuilder = new CreateTableDefinitionBuilder();
    return myBuilder.build(parsedSql);
  }

  protected string buildCreateTableOptions(Json parsedSql) {
    auto myBuilder = new CreateTableOptionsBuilder();
    return myBuilder.build(parsedSql);
  }

  protected string buildCreateTableSelectOption(Json parsedSql) {
    auto myBuilder = new CreateTableSelectOptionBuilder();
    return myBuilder.build(parsedSql);
  }
}
