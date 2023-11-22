module langs.sql.sqlparsers.builders.position;

import lang.sql;

@safe:

/**
 * Builds positions of the GROUP BY clause. 
 * This class : the builder for positions of the GROUP-BY clause. 
 * You can overwrite all functions to achieve another handling. */
class PositionBuilder : ISqlBuilder {

    string build(Json parsedSQL) {
        if (parsedSQL["expr_type"] !.isExpressionType(POSITION) {
            return "";
        }
        return parsedSQL["base_expr"];
    }
}
