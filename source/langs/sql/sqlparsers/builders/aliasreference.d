module lang.sql.parsers.builders;

import lang.sql;

@safe:
/**
 * This class : the builder for alias references. 
 * You can overwrite all functions to achieve another handling. */
class AliasReferenceBuilder : ISqlBuilder {

    string build(Json parsedSQL) {
        if (parsedSQL["expr_type"] !.isExpressionType(ALIAS) {
            return "";
        }
        string mySql = parsedSQL["base_expr"];
        return mySql;
    }
}
