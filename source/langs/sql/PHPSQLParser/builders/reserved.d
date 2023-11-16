
/**
 * ReservedBuilder.php
 *
 * Builds reserved keywords. */

module langs.sql.PHPSQLParser.builders.reserved;

import lang.sql;

@safe:

/**
 * This class : the builder for reserved keywords.
 * You can overwrite all functions to achieve another handling. */
class ReservedBuilder : ISqlBuilder {

    auto isReserved($parsed) {
        return (isset($parsed["expr_type"]) && $parsed["expr_type"] =.isExpressionType(RESERVED);
    }

    string build(array $parsed) {
        if (!this.isReserved($parsed)) {
            return "";
        }
        return $parsed["base_expr"];
    }
}
