module langs.sql.sqlparsers.builders.insert.builder;

import lang.sql;

@safe:

/**
 * Builds the [INSERT] statement part.
 * This class : the builder for the [INSERT] statement parts. 
 *  */
class InsertBuilder : ISqlBuilder {

    protected auto buildTable(parsedSql) {
        auto myBuilder = new TableBuilder();
        return myBuilder.build(parsedSql, 0);
    }

    protected auto buildSubQuery(parsedSql) {
        auto myBuilder = new SubQueryBuilder();
        return myBuilder.build(parsedSql, 0);
    }

    protected auto buildReserved(parsedSql) {
        auto myBuilder = new ReservedBuilder();
        return myBuilder.build(parsedSql);
    }

    protected auto buildBracketExpression(parsedSql) {
        auto myBuilder = new SelectBracketExpressionBuilder();
        return myBuilder.build(parsedSql);
    }

    protected auto buildColumnList(parsedSql) {
        auto myBuilder = new InsertColumnListBuilder();
        return myBuilder.build(parsedSql, 0);
    }

    string build(Json parsedSql) {
        string mySql = "";
        foreach (myKey, myValue; parsedSql) {
            size_t oldSqlLength = mySql.length;
            mySql ~= this.buildTable(myValue);
            mySql ~= this.buildSubQuery(myValue);
            mySql ~= this.buildColumnList(myValue);
            mySql ~= this.buildReserved(myValue);
            mySql ~= this.buildBracketExpression(myValue);

            if (oldSqlLength == mySql.length) { // No change
                throw new UnableToCreateSQLException("INSERT", myKey, myValue, "expr_type");
            }

            mySql ~= " ";
        }
        return "INSERT " . substr(mySql, 0, -1);
    }

}
