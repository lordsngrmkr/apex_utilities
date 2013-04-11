// SObjectHelpers
// --------------
// A collection of miscellaneous helper methods for sObjects
// ---------------------------------------------------------
// 

public class SObjectHelpers {

	/**
	 * Returns the list of Strings for with the picklist select options
	 */
	public static List<String> getPicklistStrings(Schema.DescribeFieldResult fieldDesc) {
		List<String> strs = new List<String>();
		for (Schema.PicklistEntry p : fieldDesc.getPicklistValues()) {
			strs.add(p.getValue());
		}
		return strs;
	}
}
