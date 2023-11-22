module langs.sql.sqlparsers.builders.refclause;

import lang.sql;

@safe:

/**
 * Builds reference clauses within a JOIN.
 * This class : the references clause within a JOIN.
 * You can overwrite all functions to achieve another handling.
 */
class RefClauseBuilder : ISqlBuilder {

    protected auto buildInList(parsedSql) {
        auto myBuilder = new InListBuilder();
        return myBuilder.build(parsedSql);
    }

    protected auto buildColRef(parsedSql) {
        auto myBuilder = new ColumnReferenceBuilder();
        return myBuilder.build(parsedSql);
    }

    protected auto buildOperator(parsedSql) {
        auto myBuilder = new OperatorBuilder();
        return myBuilder.build(parsedSql);
    }

    protected auto buildFunction(parsedSql) {
        auto myBuilder = new FunctionBuilder();
        return myBuilder.build(parsedSql);
    }

    protected auto buildConstant(parsedSql) {
        auto myBuilder = new ConstantBuilder();
        return myBuilder.build(parsedSql);
    }

    protected auto buildBracketExpression(parsedSql) {
        auto myBuilder = new SelectBracketExpressionBuilder();
        return myBuilder.build(parsedSql);
    }

    protected auto buildColumnList(parsedSql) {
        auto myBuilder = new ColumnListBuilder();
        return myBuilder.build(parsedSql);
    }

    protected auto buildSubQuery(parsedSql) {
        auto myBuilder = new SubQueryBuilder();
        return myBuilder.build(parsedSql);
    }

    string build(Json parsedSql) {
        if (parsedSql.isEmpty) { return ""; }

        string mySql = "";
        foreach (myKey, myValue; parsedSql) {
            size_t oldSqlLength = mySql.length;
            mySql ~= this.buildColRef(myValue);
            mySql ~= this.buildOperator(myValue);
            mySql ~= this.buildConstant(myValue);
            mySql ~= this.buildFunction(myValue);
            mySql ~= this.buildBracketExpression(myValue);
            mySql ~= this.buildInList(myValue);
            mySql ~= this.buildColumnList(myValue);
            mySql ~= this.buildSubQuery(myValue);

            if (oldSqlLength == mySql.length) { // No change
                throw new UnableToCreateSQLException("expression ref_clause", myKey, myValue, "expr_type");
            }

            mySql ~= " ";
        }
        return substr(mySql, 0, -1);
    }
}
