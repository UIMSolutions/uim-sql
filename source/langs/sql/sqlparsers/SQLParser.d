module langs.sql.sqlparsers.sqlparser;

import lang.sql;

@safe:

// A pure PHP SQL (non validating) parser w/ focus on MySQL dialect of SQL
class SqlParser {

    $parsed;

    private $options;

    /**
     * Constructor. It simply calls the parse() function.
     * Use the variable $parsed to get the output.
     *
     * @param bool calcPositions True, if the output should contain [position], false otherwise.
     * @param array $options
     */
    this(string sqlStatement = null, bool calcPositions = false, array $options = []) {
        this.options = new Options($options);

        if (sqlStatement !is null) {
            this.parse(sqlStatement, calcPositions);
        }
    }

    /**
     * It parses the given SQL statement and generates a detailled
     * output array for every part of the statement. The method can
     * also generate [position] fields within the output, which hold
     * the character position for every statement part. The calculation
     * of the positions needs some time, if you don"t need positions in
     * your application, set the parameter to false.
     *
     * @param boolean calcPositions True, if the output should contain [position], false otherwise.
     *
     * @return array An associative array with all meta information about the SQL statement.
     */
    auto parse(string sqlStatement, bool calcPositions = false) {

        auto myProcessor = new DefaultProcessor(this.options);
        auto queries = $processor.process(sqlStatement);

        // calc the positions of some important tokens
        if (calcPositions) {
            $calculator = new PositionCalculator();
            queries = $calculator.setPositionsWithinSQL(sqlStatement, queries);
        }

        // store the parsed queries
        this.parsed = queries;
        return this.parsed;
    }

    /**
     * Add a custom auto to the parser.  no return value
     *
     * @param String $token The name of the auto to add
     *
     * @return null
     */
    auto addCustomFunction($token) {
        SqlParserConstants::getInstance().addCustomFunction($token);
    }

    /**
     * Remove a custom auto from the parser.  no return value
     *
     * @param String $token The name of the auto to remove
     *
     * @return null
     */
    auto removeCustomFunction($token) {
        SqlParserConstants::getInstance().removeCustomFunction($token);
    }

    /**
     * Returns the list of custom functions
     *
     * @return array Returns an array of all custom functions
     */
    auto getCustomFunctions() {
        return SqlParserConstants::getInstance().getCustomFunctions();
    }
}
