module langs.sql.sqlparsers.builders.database;

import lang.sql;

@safe:

/**
 * Builds the database within the SHOW statement.
 * This class : the builder for a database within SHOW statement. 
 * You can overwrite all functions to achieve another handling. */
class DatabaseBuilder : ISqlBuilder {

    string build(Json parsedSQL) {
        if (parsedSQL["expr_type"] !.isExpressionType(DATABASE) {
            return "";
        }
        return parsedSQL["base_expr"];
    }
}
