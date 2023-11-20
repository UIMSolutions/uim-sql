module langs.sql.sqlparsers.builders.create.indexes.indexoptions;

import lang.sql;

@safe:
/**
 * Builds index options part of a CREATE INDEX statement.
 * This class : the builder for the index options of a CREATE INDEX
 * statement. 
 * You can overwrite all functions to achieve another handling. */
class CreateIndexOptionsBuilder : ISqlBuilder {

    protected auto buildIndexParser($parsed) {
        auto myBuilder = new IndexParserBuilder();
        return myBuilder.build($parsed);
    }

    protected auto buildIndexSize($parsed) {
        auto myBuilder = new IndexSizeBuilder();
        return myBuilder.build($parsed);
    }

    protected auto buildIndexType($parsed) {
        auto myBuilder = new IndexTypeBuilder();
        return myBuilder.build($parsed);
    }

    protected auto buildIndexComment($parsed) {
        auto myBuilder = new IndexCommentBuilder();
        return myBuilder.build($parsed);
    }

    protected auto buildIndexAlgorithm($parsed) {
        auto myBuilder = new IndexAlgorithmBuilder();
        return myBuilder.build($parsed);
    }

    protected auto buildIndexLock($parsed) {
        auto myBuilder = new IndexLockBuilder();
        return myBuilder.build($parsed);
    }

    string build(array $parsed) {
        if ($parsed["options"] == false) {
            return "";
        }
        
        string mySql = "";
        foreach (myKey, myValue; $parsed["options"]) {
            size_t oldSqlLength = mySql.length;
            mySql ~= this.buildIndexAlgorithm(myValue);
            mySql ~= this.buildIndexLock(myValue);
            mySql ~= this.buildIndexComment(myValue);
            mySql ~= this.buildIndexParser(myValue);
            mySql ~= this.buildIndexSize(myValue);
            mySql ~= this.buildIndexType(myValue);

            if (oldSqlLength == mySql.length) { // No change
                throw new UnableToCreateSQLException("CREATE INDEX options", myKey, myValue, "expr_type");
            }

            mySql ~= " ";
        }
        return " " ~ substr(mySql, 0, -1);
    }
}
