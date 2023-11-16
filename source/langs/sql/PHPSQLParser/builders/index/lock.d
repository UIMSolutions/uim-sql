
/**
 * IndexLockBuilder.php
 *
 * Builds index lock part of a CREATE INDEX statement.
 */

module langs.sql.PHPSQLParser.builders.index.lock;

import lang.sql;

@safe:

/**
 * This class : the builder for the index lock of CREATE INDEX statement. 
 * You can overwrite all functions to achieve another handling. */
class IndexLockBuilder : ISqlBuilder {

    protected auto buildReserved($parsed) {
        auto myBuilder = new ReservedBuilder();
        return myBuilder.build($parsed);
    }

    protected auto buildConstant($parsed) {
        auto myBuilder = new ConstantBuilder();
        return myBuilder.build($parsed);
    }
    
    protected auto buildOperator($parsed) {
        auto myBuilder = new OperatorBuilder();
        return myBuilder.build($parsed);
    }
    
    string build(array $parsed) {
        if ($parsed["expr_type"] != ExpressionType::INDEX_LOCK) {
            return "";
        }

        string mySql = "";
        foreach (myKey, myValue; $parsed["sub_tree"]) {
            auto oldSqlLength = mySql.length;
            mySql  ~= this.buildReserved(myValue);
            mySql  ~= this.buildConstant(myValue);
            mySql  ~= this.buildOperator(myValue);

            if (oldSqlLength == mySql.length) { // No change
                throw new UnableToCreateSQLException('CREATE INDEX lock subtree', $k, myValue, "expr_type");
            }

            mySql  ~= " ";
        }
        return substr(mySql, 0, -1);
    }
}
