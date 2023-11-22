module langs.sql.sqlparsers.builders.create.tables.fulltextindex;

import lang.sql;

@safe:

/**
 * Builds index key part of a CREATE TABLE statement. 
 * This class : the builder for the index key part of a CREATE TABLE statement. 
 *  */
class FulltextIndexBuilder : IBuilder {

    protected auto buildReserved(Json parsedSql) {
        auto myBuilder = new ReservedBuilder();
        return myBuilder.build(parsedSql);
    }

    protected auto buildConstant(Json parsedSql) {
        auto myBuilder = new ConstantBuilder();
        return myBuilder.build(parsedSql);
    }
    
    protected auto buildIndexKey(Json parsedSql) {
        if (parsedSql["expr_type"] !.isExpressionType(INDEX) {
            return "";
        }
        return parsedSql["base_expr"];
    }
    
    protected auto buildColumnList(Json parsedSql) {
        auto myBuilder = new ColumnListBuilder();
        return myBuilder.build(parsedSql);
    }
    
    string build(Json parsedSql) {
        if (parsedSql["expr_type"] !.isExpressionType(FULLTEXT_IDX) { 
            return "";
        }
        string mySql = "";
        foreach (myKey, myValue; parsedSql["sub_tree"]) {
            size_t oldSqlLength = mySql.length;
            mySql ~= this.buildReserved(myValue);
            mySql ~= this.buildColumnList(myValue);
            mySql ~= this.buildConstant(myValue);
            mySql ~= this.buildIndexKey(myValue);

            if (oldSqlLength == mySql.length) { // No change
                throw new UnableToCreateSQLException("CREATE TABLE fulltext-index key subtree", myKey, myValue, "expr_type");
            }

            mySql ~= " ";
        }
        return substr(mySql, 0, -1);
    }
}
