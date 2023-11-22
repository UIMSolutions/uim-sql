
module langs.sql.sqlparsers.builders.join;

import lang.sql;

@safe:
/**
 * Builds the JOIN statement parts (within FROM).
 * This class : the builder for the JOIN statement parts (within FROM). 
 * You can overwrite all functions to achieve another handling.
 *
 

 
 *   */
class JoinBuilder {

    auto build(parsedSql) {
        if (parsedSql == "CROSS") {
            return ", ";
        }
        if (parsedSql == "JOIN") {
            return " INNER JOIN ";
        }
        if (parsedSql == "LEFT") {
            return " LEFT JOIN ";
        }
        if (parsedSql == "RIGHT") {
            return " RIGHT JOIN ";
        }
        if (parsedSql == "STRAIGHT_JOIN") {
            return " STRAIGHT_JOIN ";
        }
        // TODO: add more
        throw new UnsupportedFeatureException(parsedSql);
    }
}
