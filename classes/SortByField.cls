public class SortByField {
	/*
		 Destructively sorts a list of sObjects, sorted by the value of the specified field
		 Throws: SortingException
	*/
	public static void sortByField(List<sObject> objs, String fieldName) {
		if (objs.size() < 2) return;
		Schema.sObjectField field = objs.getsObjectType().getDescribe().fields.getMap().get(fieldName);
		if (field == null) throw new SortingException('No such field ' + fieldName);
		Schema.DescribeFieldResult fieldDesc = field.getDescribe();
		if (!fieldDesc.isSortable()) throw new SortingException('Type not sortable: ' + fieldDesc.getType());
		quicksortByField(objs, 0, objs.size()-1, field, fieldDesc.gettype());
	}
	public class SortingException extends Exception {}
	/* Implements quicksort on the list of sObjects given */
	private static void quicksortByField(List<sObject> a, Integer lo0, Integer hi0, Schema.sObjectField field, Schema.DisplayType type) {
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
	private static Integer compareFields(sObject a, sObject b, Schema.sObjectField field, Schema.DisplayType type) {
		if (type == Schema.DisplayType.Email ||
				type == Schema.DisplayType.Id ||
				type == Schema.DisplayType.Phone ||
				type == Schema.DisplayType.Picklist ||
				type == Schema.DisplayType.Reference ||
				type == Schema.DisplayType.String ||
				type == Schema.DisplayType.URL) {
			// compareTo method does the same thing as the compare methods defined below for Numbers and Time
			return String.valueOf(a.get(field)).toLowerCase().compareTo(String.valueOf(b.get(field)).toLowerCase());
		} else if (type == Schema.DisplayType.Currency ||
				type == Schema.DisplayType.Double ||
				type == Schema.DisplayType.Integer ||
				type == Schema.DisplayType.Percent) {
			return compareNumbers(Double.valueOf(a.get(field)), Double.valueOf(b.get(field)));
		} else if (type == Schema.DisplayType.Date ||
				type == Schema.DisplayType.DateTime ||
				type == Schema.DisplayType.Time) {
			return compareTime(Datetime.valueOf(a.get(field)), Datetime.valueOf(b.get(field)));
		} else {
			throw new SortingException('Type not sortable: ' + type);
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
}

