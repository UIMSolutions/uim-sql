
/**
 * ExplainProcessor.php
 *
 * This file : the processor for the EXPLAIN statements.
 */

module lang.sql.parsers.processors;
use SqlParser\utils\ExpressionType;

/**
 * This class processes the EXPLAIN statements.
 */
class ExplainProcessor : AbstractProcessor {

    protected auto isStatement($keys, $needle = "EXPLAIN") {
        $pos = array_search($needle, $keys);
        if (isset($keys[$pos + 1])) {
            return in_array($keys[$pos + 1], array('SELECT', 'DELETE', 'INSERT', 'REPLACE', 'UPDATE'), true);
        }
        return false;
    }

    // TODO: refactor that function
    auto process($tokens, $keys = array()) {

        $base_expr = "";
        $expr = array();
        $currCategory = "";

        if (this.isStatement($keys)) {
            foreach ($tokens as $token) {

                $trim = trim($token);
                $base_expr  ~= $token;

                if ($trim == '') {
                    continue;
                }

                $upper = strtoupper($trim);

                switch ($upper) {

                case 'EXTENDED':
                case 'PARTITIONS':
                    return array('expr_type' => ExpressionType::RESERVED, 'base_expr' => $token);
                    break;

                case 'FORMAT':
                    if ($currCategory == '') {
                        $currCategory = $upper;
                        $expr[] = array('expr_type' => ExpressionType::RESERVED, 'base_expr' => $trim);
                    }
                    // else?
                    break;

                case '=':
                    if ($currCategory == 'FORMAT') {
                        $expr[] = array('expr_type' => ExpressionType::OPERATOR, 'base_expr' => $trim);
                    }
                    // else?
                    break;

                case 'TRADITIONAL':
                case 'JSON':
                    if ($currCategory == 'FORMAT') {
                        $expr[] = array('expr_type' => ExpressionType::RESERVED, 'base_expr' => $trim);
                        return array('expr_type' => ExpressionType::EXPRESSION, 'base_expr' => trim($base_expr),
                                     'sub_tree' => $expr);
                    }
                    // else?
                    break;

                default:
                // ignore the other stuff
                    break;
                }
            }
            return empty($expr) ? null : $expr;
        }

        foreach ($tokens as $token) {

            $trim = trim($token);

            if ($trim == '') {
                continue;
            }

            switch ($currCategory) {

            case 'TABLENAME':
                $currCategory = 'WILD';
                $expr[] = array('expr_type' => ExpressionType::COLREF, 'base_expr' => $trim,
                                'no_quotes' => this.revokeQuotation($trim));
                break;

            case '':
                $currCategory = 'TABLENAME';
                $expr[] = array('expr_type' => ExpressionType::TABLE, 'table' => $trim,
                                'no_quotes' => this.revokeQuotation($trim), 'alias' => false, 'base_expr' => $trim);
                break;

            default:
                break;
            }
        }
        return empty($expr) ? null : $expr;
    }
}

?>
