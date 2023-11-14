
/**
 * CollationBuilder.php
 *
 * Builds the collation expression part of CREATE TABLE. */

module lang.sql.parsers.builders;

import lang.sql;

@safe:

/**
 * This class : the builder for the collation statement part of CREATE TABLE. 
 * You can overwrite all functions to achieve another handling. */
class CollationBuilder : ISqlBuilder {

    protected auto buildOperator($parsed) {
        auto myBuilder = new OperatorBuilder();
        return myBuilder.build($parsed);
    }

    protected auto buildConstant($parsed) {
        auto myBuilder = new ConstantBuilder();
        return myBuilder.build($parsed);
    }

    protected auto buildReserved($parsed) {
        auto myBuilder = new ReservedBuilder();
        return myBuilder.build($parsed);
    }

    auto build(array $parsed) {
        if ($parsed["expr_type"] != ExpressionType::COLLATE) {
            return "";
        }
        auto mySql = "";
        foreach (key, myValue; $parsed["sub_tree"]) {
            auto oldSqlLength = mySql.length;
            mySql  ~= this.buildReserved(myValue);
            mySql  ~= this.buildOperator(myValue);
            mySql  ~= this.buildConstant(myValue);

            if (oldSqlLength == mySql.length) { // No change
                throw new UnableToCreateSQLException('CREATE TABLE options collation subtree', $k, myValue, 'expr_type');
            }

            mySql  ~= " ";
        }
        return substr(mySql, 0, -1);
    }
}
