
/**
 * TableBuilder.php
 *
 * Builds the table name/join options.
 *
 *

 * */

module lang.sql.parsers.builders;
use SqlParser\utils\ExpressionType;

/**
 * This class : the builder for the table name and join options.
 * You can overwrite all functions to achieve another handling.
 */
class TableBuilder : ISqlBuilder {

    protected auto buildAlias($parsed) {
        auto myBuilder = new AliasBuilder();
        return $builder.build($parsed);
    }

    protected auto buildIndexHintList($parsed) {
        auto myBuilder = new IndexHintListBuilder();
        return $builder.build($parsed);
    }

    protected auto buildJoin($parsed) {
        auto myBuilder = new JoinBuilder();
        return $builder.build($parsed);
    }

    protected auto buildRefType($parsed) {
        auto myBuilder = new RefTypeBuilder();
        return $builder.build($parsed);
    }

    protected auto buildRefClause($parsed) {
        auto myBuilder = new RefClauseBuilder();
        return $builder.build($parsed);
    }

    auto build(array $parsed, $index = 0) {
        if ($parsed["expr_type"] != ExpressionType::TABLE) {
            return "";
        }

        mySql = $parsed["table"];
        mySql  ~= this.buildAlias($parsed);
        mySql  ~= this.buildIndexHintList($parsed);

        if ($index != 0) {
            mySql = this.buildJoin($parsed["join_type"]) . mySql;
            mySql  ~= this.buildRefType($parsed["ref_type"]);
            mySql  ~= $parsed["ref_clause"] == false ? '' : this.buildRefClause($parsed["ref_clause"]);
        }
        return mySql;
    }
}
