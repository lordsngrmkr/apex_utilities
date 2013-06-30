// DynamicQuery
// ------------
//
// This class is useful for creating dynamic SOQL queries.
// Queries are built piece by piece via methods named after the SOQL
// clauses they build. Clauses may be added to the query in any order.
// Use the 'execute' method to run the query, once it's built.
// All query-building methods return 'this' so they are chainable.
//
// Example usage:
// List<User> users =
//   new DynamicQuery('User').sel('Id').whr('Name LIKE \'Nathan%\'').execute();
// 
// ------------------------------------------------------------------
//  Author          Date        Description
// ------------------------------------------------------------------
//  Nathan Wallace  06/29/2013  Create

public class DynamicQuery {

  /* ~ Instance Variables ~ */
  
  private String   table;
  private String[] groups,
                   havings,
                   selections,
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
    selections = new List<String>();
    withs      = new List<String>();
    wheres     = new List<String>();
    groups     = new List<String>();
    havings    = new List<String>();
    orders     = new List<String>();
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
   * @param  selector  string that will be interpolated into the SELECT clause of the query, comma separated from other selections
   * @return this DynamicQuery instance
   */
  public DynamicQuery sel(String selection) {
    selections.add(selection);
    return this;
  }
  public DynamicQuery sel(List<String> selections) {
    this.selections.addAll(selections);
    return this;
  }
	public DynamicQuery sel(Set<String> selections) {
		return sel(new List<String>(selections));
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
    wheres.add(field + ' IN (' + String.join(strCollection,',') + ')');
    return this;
  }
  public DynamicQuery whrin(String field, Set<Object> collection) {
    return this.whrin(field, new List<Object>(collection));
  }
  public DynamicQuery whrin(String field, List<String> collection) {
    wheres.add(field + ' IN (\'' + String.join(collection,'\',\'') + '\')');
    return this;
  }
  public DynamicQuery whrin(String field, Set<String> collection) {
    return this.whrin(field, new List<String>(collection));
  }
  // TODO whrin with set<obj> does not typecast correctly -- must overload for each supported type of set
  // TODO overload this method for Date objects (don't get treated correctly when casted to Object then String)

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
   * Add a order clauses to the query.
   *
   * @param  orderClause string to insert after 'ORDER BY' in the query; should be field or fields list with optional sort direction
   * @return this DynamicQuery instance
   */
  public DynamicQuery ord(String orderClause) {
		orders.add(orderClause);
    return this;
  }
	public DynamicQuery ord(List<String> orderClauses) {
		orders.addAll(orderClauses);
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
    String query = 'SELECT ';
		query += selections.isEmpty() ? 'Id' : String.join(selections,',');
		query += ' FROM ' + table;
    if (!wheres.isEmpty())  query += ' WHERE ('    + String.join(wheres, ') AND (') + ')';
    if (!withs.isEmpty())   query += ' WITH ('     + String.join(withs,  ') AND (') + ')';
    if (!groups.isEmpty())  query += ' GROUP BY '  + String.join(groups, ',');
    if (!havings.isEmpty()) query += ' HAVING ('   + String.join(havings,') AND (') + ')';
    if (!orders.isEmpty())  query += ' ORDER BY '  + String.join(orders, ',');
    if (limits  != null)    query += ' LIMIT '     + limits;
    if (offsets != null)    query += ' OFFSET '    + offsets;
    return query;
  }

  class MalformattedQueryException extends Exception {}

  /* ~ Unit Tests ~ */

  @isTest static void testConstructor() {
    DynamicQuery q = new DynamicQuery('table');
    System.assert(q.generateQuery().contains('FROM table'));
  }

  @istest static void testSelectConstruction() {
    DynamicQuery q = new DynamicQuery('table');
    q.sel('field');
    String result = q.generateQuery().substringBetween('SELECT ', ' FROM');
    System.assert(result.contains('field'));
  }

  @istest static void testSelectListConstruction() {
    List<String> fields = new List<String> {'field_a','field_b','field_c'};
    DynamicQuery q = new DynamicQuery('table').sel(fields);
    String result = q.generateQuery().substringBetween('SELECT ', ' FROM');
    System.assert(result.contains('field_a'), q.generateQuery() + ', fields: ' + fields + ', selections: ' + q.selections);
    System.assert(result.contains('field_b'), q.generateQuery());
    System.assert(result.contains('field_c'), q.generateQuery());
  }

  @isTest static void testWhereConstruction() {
    DynamicQuery q = new DynamicQuery('table');
    q.whr('field operator comparator');
    String result = q.generateQuery().substringAfter(' WHERE ');
    System.assert(result.contains('field operator comparator'));
  }

  @isTest static void testWhereListConstruction() {
    List<String> wheres = new List<String> { 'where_a', 'where_b', 'where_c' };
    DynamicQuery q = new DynamicQuery('table').whr(wheres);
    String result = q.generateQuery().substringAfter(' WHERE ');
    System.assert(result.contains('(where_a) AND (where_b) AND (where_c)'), result);
  }

  @isTest static void testWhereInConstructionStrings() {
    Set<String> collection = new Set<String> {'item_a', 'item_b', 'item_c'};
    DynamicQuery q = new DynamicQuery('table').whrin('field', collection);
    String result = q.generateQuery().substringAfter(' WHERE ');
    System.assert(result.contains('field IN ('));
    System.assert(result.contains('\'item_a\''));
    System.assert(result.contains('\'item_b\''));
    System.assert(result.contains('\'item_c\''));
  }

  @isTest static void testWhereInConstructionObjects() {
    Set<Object> collection = new Set<Object> {'item_a', 'item_b', 'item_c'};
    DynamicQuery q = new DynamicQuery('table').whrin('field', collection);
    String result = q.generateQuery().substringAfter(' WHERE ');
    System.assert(result.contains('field IN ('));
    System.assert(result.contains('item_a'));
    System.assert(result.contains('item_b'));
    System.assert(result.contains('item_c'));
    System.assert(!result.contains('\'item_\'')); // objects should not be quoted
  }

  @isTest static void testWithConstruction() {
    DynamicQuery q = new DynamicQuery('table').wth('with_a');
    String result = q.generateQuery();
    System.assert(result.contains(' WITH (with_a)'));
  }

  @isTest static void testWithListConstruction() {
    List<String> withs = new List<String> {'with_a','with_b','with_c'};
    DynamicQuery q = new DynamicQuery('table').wth(withs);
    String result = q.generateQuery();
    System.assert(result.contains(' WITH (with_a) AND (with_b) AND (with_c)'));
  }

  @isTest static void testGroupByConstruction() {
    DynamicQuery q = new DynamicQuery('table').grp('category');
    String result = q.generateQuery();
    System.assert(result.contains(' GROUP BY category'));
  }

  @isTest static void testGroupByListConstruction() {
    List<String> groupings = new List<String> {'category_a', 'category_b', 'category_c'};
    DynamicQuery q = new DynamicQuery('table').grp(groupings);
    String result = q.generateQuery();
    System.assert(result.contains(' GROUP BY category_a,category_b,category_c'));
  }

  @isTest static void testHavingConstruction() {
    DynamicQuery q = new DynamicQuery('table').hvg('having');
    String result = q.generateQuery();
    System.assert(result.contains(' HAVING (having)'));
  }

  @isTest static void testHavingListConstruction() {
    List<String> havings = new List<String> {'having_a','having_b','having_c'};
    DynamicQuery q = new DynamicQuery('table').hvg(havings);
    String result = q.generateQuery();
    System.assert(result.contains(' HAVING (having_a) AND (having_b) AND (having_c)'));
  }

  @isTest static void testLimitConstruction() {
    DynamicQuery q = new DynamicQuery('table').lim(1);
    String result = q.generateQuery();
    System.assert(result.contains(' LIMIT 1'));
  }

  @isTest static void testOffsetConstruction() {
    DynamicQuery q = new DynamicQuery('table').off(10);
    String result = q.generateQuery();
    System.assert(result.contains(' OFFSET 10'));
  }

  @isTest static void testExecute() {
    Integer count = [SELECT count() FROM Profile];
    List<Profile> result = new DynamicQuery('Profile').sel('Id').execute();
    System.assert(result.size() == count);
  }

  @isTest static void testTableRequired() {
    try {
      DynamicQuery q = new DynamicQuery('');
      System.assert(false, 'Expected to throw MalformattedQueryException, but saw none');
    } catch (MalformattedQueryException e) {} // pass!
  }

  @isTest static void testSelectionsDefaultToIdIfNotPresent() {
    DynamicQuery q = new DynamicQuery('table');
    String result = q.generateQuery().substringBetween('SELECT ', ' FROM');
    System.assert(result.contains('Id'));
  }
}