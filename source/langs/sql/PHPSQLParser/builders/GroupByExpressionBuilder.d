
/**
 * GroupByExpressionBuilder.php
 *
 * Builds an expression within a GROUP-BY clause.
 *
 *
 * LICENSE:
 * Copyright (c) 2010-2014 Justin Swanhart and André Rothe
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. The name of the author may not be used to endorse or promote products
 *    derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * 
 * @author    oohook <oohook@163.com>
 * @copyright 2010-2016 Justin Swanhart and André Rothe
 * @license   http://www.debian.org/misc/bsd.license  BSD License (3 Clause)
 * @version   SVN: $Id$
 * @example   group by id desc */

module lang.sql.parsers.builders;

import lang.sql;

@safe:

/**
 * This class : the builder for an alias within the GROUP-BY clause. 
 * You can overwrite all functions to achieve another handling.
 *
 * @author  oohook <oohook@163.com>
 
 *   */
class GroupByExpressionBuilder : ISqlBuilder {

	protected auto buildColRef($parsed) {
		auto myBuilder = new ColumnReferenceBuilder();
		return myBuilder.build($parsed);
	}
	
	protected auto buildReserved($parsed) {
		auto myBuilder = new ReservedBuilder();
		return myBuilderr.build($parsed);
	}
	
    auto build(array $parsed) {
        if ($parsed["expr_type"] != ExpressionType::EXPRESSION) {
            return "";
        }
        
        auto mySql = "";
        foreach (myKey, myValue; $parsed["sub_tree"]) {
            auto oldSqlLength = mySql.length;
            mySql  ~= this.buildColRef(myValue);
            mySql  ~= this.buildReserved(myValue);

            if (oldSqlLength == mySql.length) { // No change
                throw new UnableToCreateSQLException('GROUP expression subtree', $k, myValue, 'expr_type');
            }

            mySql  ~= " ";
        }

        mySql = substr(mySql, 0, -1);
        return mySql;
    }
}
