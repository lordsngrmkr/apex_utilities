// DynamicQuery
// ------------
// This class is useful for creating dynamic SOQL queries.
// -------------------------------------------------------
// Nathan Wallace      04/02/2013  Create
// 

public class DynamicQuery {

	/* ~ Instance Variables ~ */
	
	private String   table;
	private String[] groups,
	                 havings,
	                 selectors,
	                 withs,
	                 wheres,
	                 orders;
	private Integer  limits,
	                 offsets;

	/* ~ Instance Methods ~ */

	/**
	 * Constructs a DynamicQuery object for querying the given database table.
	 * 
	 * @param  table  a string that must exactly match the name of the database table for querying
	 * @return the constructed DynamicQuery object
	 * @throws DynamicQuery.MalformattedQueryException if table is an empty string
	 */
	public DynamicQuery(String table) {
		if (String.isEmpty(table)) throw new MalformattedQueryException('Table name cannot be blank');
		this.table = table;
		selectors = new List<String>();
		withs     = new List<String>();
		wheres    = new List<String>();
		groups    = new List<String>();
		havings   = new List<String>();
		orders    = new List<String>();
	}

	/**
	 * Executes the query against the database.
	 *
	 * @return List<sObject> returned by the database for the query
	 * @throws DynamicQuery.MalformattedQueryException if anything goes wrong with the query
	 */
	public List<sObject> execute() {
		String query = generateQuery();
		System.debug('DynamicQuery generated query: ' + query);
		try {
			return Database.query(query);
		} catch (Exception e) {
			throw new MalformattedQueryException(e.getMessage());
		}
	}

	/**
	 * Add fields for selection to the query.
	 *
	 * @param  selector  string that will be interpolated into the SELECT clause of the query, comma separated from other selectors
	 * @return this DynamicQuery instance
	 */
	public DynamicQuery sel(String selector) {
		selectors.add(selector);
		return this;
	}
	public DynamicQuery sel(List<String> selectors) {
		selectors.addAll(selectors);
		return this;
	}

	/**
	 * Add where clauses to the query.
	 *
	 * @param  whereClause  string that will be interpolated into the WHERE clause of the query, AND-ed with other where clauses
	 * @return this DynamicQuery instance
	 */
	public DynamicQuery whr(String whereClause) {
		wheres.add(whereClause);
		return this;
	}
	public DynamicQuery whr(List<String> whereClauses) {
		wheres.addAll(whereClauses);
		return this;
	}

	/**
	 * Add where-in clauses to the query.
	 *
	 * @param  field       string representing the field that will be interpolated into the WHERE clause of the query, AND-ed with other where clauses
	 * @param  collection  collection to be referred to in a WHERE-IN clause
	 * @return this DynamicQuery instance
	 */
	public DynamicQuery whrin(String field, List<Object> collection) {
		List<String> strCollection = new List<String>();
		for (Object o : collection) strCollection.add(String.valueOf(o));
		wheres.add(field + ' IN (' + join(strCollection,',') + ')');
		return this;
	}
	public DynamicQuery whrin(String field, Set<Object> collection) {
		return this.whrin(field, new List<Object>(collection));
	}
	public DynamicQuery whrin(String field, List<String> collection) {
		wheres.add(field + ' IN (\'' + join(collection,'\',\'') + '\')');
		return this;
	}
	public DynamicQuery whrin(String field, Set<String> collection) {
		return this.whrin(field, new List<String>(collection));
	}

	/**
	 * Add with clauses to the query.
	 *
	 * @param  withClause  string that will be interpolated into the WITH clause of the query, AND-ed with other with clauses
	 * @return this DynamicQuery instance
	 */
	public DynamicQuery wth(String withClause) {
		withs.add(withClause);
		return this;
	}
	public DynamicQuery wth(List<String> withClauses) {
		withs.addAll(withClauses);
		return this;
	}

	/**
	 * Add group by clauses to the query.
	 *
	 * @param  groupClause  string that will be interpolated into the GROUP BY clause of the query, comma separated with other group clauses
	 * @return this DynamicQuery instance
	 */
	public DynamicQuery grp(String groupClause) {
		groups.add(groupClause);
		return this;
	}
	public DynamicQuery grp(List<String> groupClauses) {
		groups.addAll(groupClauses);
		return this;
	}

	/**
	 * Add having clauses to the query.
	 *
	 * @param  havingClause  string that will be interpolated into the HAVING clause of the query, AND-ed with other having clauses
	 * @return this DynamicQuery instance
	 */
	public DynamicQuery hvg(String havingClause) {
		havings.add(havingClause);
		return this;
	}
	public DynamicQuery hvg(List<String> havingClauses) {
		havings.addAll(havingClauses);
		return this;
	}

	/**
	 * Add a limit clause to the query. Destructively replaces any previously assigned limit.
	 *
	 * @param  recordsLimit  integer that will be interpolated into the LIMIT clause of the query
	 * @return this DynamicQuery instance
	 */
	public DynamicQuery lim(Integer recordsLimit) {
		limits = recordsLimit;
		return this;
	}

	/**
	 * Add an offset clause to the query. Destructively replaces any previously assigned offset.
	 *
	 * @param  recordsOffset  integer that will be interpolated into the OFFSET clause of the query
	 * @return this DynamicQuery instance
	 */
	public DynamicQuery off(Integer recordsOffset) {
		offsets = recordsOffset;
		return this;
	}

	/**
	 * Interpolate the existing clauses into a single string representing the database query.
	 *
	 * @return a string representing the combined database query
	 */
	private String generateQuery() {
		String query = 'SELECT ' + join(selectors,',') + ' FROM ' + table;
		if (!wheres.isEmpty())  query += ' WHERE '    + join(wheres, ' AND ');
		if (!withs.isEmpty())   query += ' WITH '     + join(withs,  ' AND ');
		if (!groups.isEmpty())  query += ' GROUP BY ' + join(groups, ',');
		if (!havings.isEmpty()) query += ' HAVING '   + join(havings,' AND ');
		if (!orders.isEmpty())  query += ' ORDER BY ' + join(orders, ' THEN ');
		if (limits  != null)    query += ' LIMIT '    + limits;
		if (offsets != null)    query += ' OFFSET '   + offsets;
		return query;
	}

	class MalformattedQueryException extends Exception {}

	/* ~ Helpers ~ */

	/**
	 * Join a list of strings together with a specified separator between them
	 *
	 * @param   strList     strings to join together
	 * @param   joiningStr  string with which to separate the strings in the list
	 * @return  result of concatenating the strings in the given list with separators between
	 */
	private static String join(List<String> strList, String joiningStr) {
		String returnString = '';
		if (strList != null) {
			Iterator<String> it = strList.iterator();
			while (it.hasNext()) {
				returnString += it.next();
				if (it.hasNext()) {
					returnString += joiningStr;
				}
			}
		}
		return returnString;
	}
}
