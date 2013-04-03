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

	public DynamicQuery(String table) {
		if (String.isEmpty(table)) throw new MalformattedQueryException('Table name cannot be blank');
		table = table;
		selectors = new List<String>();
		wheres = new List<String>();
		orders = new List<String>();
	}

	public List<sObject> execute() {
		String query = generateQuery();
		System.debug('DynamicQuery generated query: ' + query);
		try {
			return Database.query(query);
		} catch (Exception e) {
			throw new MalformattedQueryException(e.getMessage());
		}
	}

	public DynamicQuery sel(String selector) {
		selectors.add(selector);
		return this;
	}
	public DynamicQuery sel(List<String> selectors) {
		selectors.addAll(selectors);
		return this;
	}

	public DynamicQuery whr(String whereClause) {
		wheres.add(whereClause);
		return this;
	}
	public DynamicQuery whr(List<String> whereClauses) {
		wheres.addAll(whereClauses);
		return this;
	}

	public DynamicQuery wth(String withClause) {
		withs.add(withClause);
		return this;
	}
	public DynamicQuery wth(List<String> withClauses) {
		withs.addAll(withClauses);
		return this;
	}

	public DynamicQuery grp(String groupClause) {
		groups.add(groupClause);
		return this;
	}
	public DynamicQuery grp(List<String> groupClauses) {
		groups.addAll(groupClauses);
		return this;
	}

	public DynamicQuery hvg(String havingClause) {
		havings.add(havingClause);
		return this;
	}
	public DynamicQuery hvg(List<String> havingClauses) {
		havings.addAll(havingClauses);
		return this;
	}

	public DynamicQuery lim(Integer recordsLimit) {
		limits = recordsLimit;
		return this;
	}

	public DynamicQuery off(Integer recordsOffset) {
		offsets = recordsOffset;
		return this;
	}

	private String generateQuery() {
		String query = 'SELECT ' + join(selectors,',') + ' FROM ' + table;
		if (!wheres.isEmpty())  query += ' WHERE ('   + join(wheres, ') AND (') + ')';
		if (!withs.isEmpty())   query += ' WITH ('    + join(withs,  ') AND (') + ')';
		if (!groups.isEmpty())  query += ' GROUP BY ' + join(groups, ',');
		if (!havings.isEmpty()) query += ' HAVING ('  + join(havings,') AND (') + ')';
		if (!orders.isEmpty())  query += ' ORDER BY ' + join(orders, ' THEN ');
		if (limits  != null)    query += ' LIMIT '    + limits;
		if (offsets != null)    query += ' OFFSET '   + offsets;
		return query;
	}

	class MalformattedQueryException extends Exception {}

	/* ~ Helpers ~ */
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
