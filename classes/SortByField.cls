public class SortByField {

	public class SortingException extends Exception {}

	private enum SortType {STRING_TYPE, NUM_TYPE, TIME_TYPE}

	/*
	Destructively sorts a list of sObjects, sorted by the value of the specified field
	Throws: SortingException
	*/
	public static void sortByField(List<sObject> objs, String fieldName) {
		if (objs.size() < 2) return;
		Schema.sObjectField field = objs.getsObjectType().getDescribe().fields.getMap().get(fieldName);
		if (field == null) throw new SortingException('No such field ' + fieldName);
		Schema.DescribeFieldResult fieldDesc = field.getDescribe();
		Schema.DisplayType dispType = fieldDesc.getType();
		if (!fieldDesc.isSortable()) throw new SortingException('Type not sortable: ' + dispType);
		SortType type = SortByField.findSortType(dispType);
		quicksortByField(objs, 0, objs.size()-1, field, type);
	}
	private static SortType findSortType(Schema.DisplayType type) {
		if (type == Schema.DisplayType.Email ||
				type == Schema.DisplayType.Id ||
				type == Schema.DisplayType.Phone ||
				type == Schema.DisplayType.Picklist ||
				type == Schema.DisplayType.Reference ||
				type == Schema.DisplayType.String ||
				type == Schema.DisplayType.URL) {
			return SortType.STRING_TYPE;
		} else if (type == Schema.DisplayType.Currency ||
				type == Schema.DisplayType.Double ||
				type == Schema.DisplayType.Integer ||
				type == Schema.DisplayType.Percent) {
			return SortType.NUM_TYPE;
		} else if (type == Schema.DisplayType.Date ||
				type == Schema.DisplayType.DateTime ||
				type == Schema.DisplayType.Time) {
			return SortType.TIME_TYPE;
		} else {
			throw new SortingException('Type not sortable: ' + type);
		}
	}
	/* Implements quicksort on the list of sObjects given */
	private static void quicksortByField(List<sObject> a, Integer lo0, Integer hi0, Schema.sObjectField field, SortType type) {
		Integer lo = lo0;
		Integer hi = hi0;
		if (lo >= hi) {
			return;
		} else if (lo == hi - 1) {
			if (compareFields(a[lo], a[hi], field, type) > 0) {
				sObject o = a[lo];
				a[lo]     = a[hi];
				a[hi]     = o;
			}
			return;
		}
		sObject pivot = a[(lo + hi) / 2];
		a[(lo + hi) / 2] = a[hi];
		a[hi] = pivot;
		while (lo < hi) {
			while (compareFields(a[lo], pivot, field, type) < 1 && lo < hi) { lo++; }
			while (compareFields(pivot, a[hi], field, type) < 1 && lo < hi) { hi--; }
			if (lo < hi) {
				sObject o = a[lo];
				a[lo]     = a[hi];
				a[hi]     = o;
			}
		}
		a[hi0] = a[hi];
		a[hi]  = pivot;
		quicksortByField(a, lo0, lo-1, field, type);
		quicksortByField(a, hi+1, hi0, field, type);
	}
	/* Determines the type of primitive the field represents, then returns the appropriate comparison */
	private static Integer compareFields(sObject a, sObject b, Schema.sObjectField field, SortType type) {
		if (type == SortType.STRING_TYPE) {
			// compareTo method does the same thing as the compare methods defined below for Numbers and Time
			return String.valueOf(a.get(field)).toLowerCase().compareTo(String.valueOf(b.get(field)).toLowerCase());
		} else if (type == SortType.NUM_TYPE) {
			return compareNumbers(Double.valueOf(a.get(field)), Double.valueOf(b.get(field)));
		} else {
			return compareTime(Datetime.valueOf(a.get(field)), Datetime.valueOf(b.get(field)));
		}
	}
	private static Integer compareNumbers(Double a, Double b) {
		if      (a < b) { return -1; }
		else if (a > b) { return  1; }
		else            { return  0; }
	}
	private static Integer compareTime(Datetime a, Datetime b) {
		if      (a < b) { return -1; }
		else if (a > b) { return  1; }
		else            { return  0; }
	}

	/* ~ Unit Tests ~ */

	@isTest static void testSortByString() {
		List<Account> accs = insertTestAccounts();
		Test.startTest();
		sortByField(accs, 'Name');
		Test.stopTest();
		Boolean sorted = true;
		for (Integer i = 1; i < accs.size(); i++) {
			if (accs[i].Name.compareTo(accs[i-1].Name) < 0)
				sorted = false;
		}
		System.assert(sorted);
	}

	@isTest static void testSortByNumber() {
		List<Account> accs = insertTestAccounts();
		Test.startTest();
		sortByField(accs, 'AnnualRevenue');
		Test.stopTest();
		Boolean sorted = true;
		for (Integer i = 1; i < accs.size(); i++) {
			if (accs[i].AnnualRevenue < accs[i-1].AnnualRevenue)
				sorted = false;
		}
		System.assert(sorted);
	}

	@isTest static void testSortByDate() {
		List<Account> accs = insertTestAccounts();
		Test.startTest();
		sortByField(accs, 'CreatedDate');
		Test.stopTest();
		Boolean sorted = true;
		for (Integer i = 1; i < accs.size(); i++) {
			if (accs[i].CreatedDate < accs[i-1].CreatedDate)
				sorted = false;
		}
		System.assert(sorted);
	}

	private static List<Account> insertTestAccounts() {
		Account a_1 = new Account(
			Name = 'AAA',
			AnnualRevenue = 2
		);
		insert a_1;
		Account a_2 = new Account(
			Name = 'BBB',
			AnnualRevenue = 3
		);
		insert a_2;
		Account a_3 = new Account(
			Name = 'CCC',
			AnnualRevenue = 1
		);
		insert a_3;
		return new List<Account> {a_1, a_2, a_3};
	}
}
