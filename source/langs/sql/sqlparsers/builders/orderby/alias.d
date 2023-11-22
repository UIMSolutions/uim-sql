module langs.sql.sqlparsers.builders.orderby.alias;

import lang.sql;

@safe:

/**
 * Builds an alias within an ORDER-BY clause.
 * This class : the builder for an alias within the ORDER-BY clause. 
 *  */
class OrderByAliasBuilder : ISqlBuilder {

    protected auto buildDirection(Json parsedSql) {
        auto myBuilder = new DirectionBuilder();
        return myBuilder.build(parsedSql);
    }

    string build(Json parsedSql) {
        if (parsedSql["expr_type"] !.isExpressionType(ALIAS) {
            return "";
        }
        return parsedSql["base_expr"] . this.buildDirection(parsedSql);
    }
}
