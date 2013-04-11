// StringHelpers
// -------------
// A collection of miscellaneous helper methods for Strings
// --------------------------------------------------------
//

public class StringHelpers {

	/* ~ Lorem Ipsum ~ */

	public static final String loremSentence = 'Lorem ipsum dolor sit amet, mei detracto pericula an, tation alterum cu vim.';
	public static final String loremParagraph = 'Lorem ipsum dolor sit amet, mei detracto pericula an, tation alterum cu vim. ' +
		'Vim an autem malorum, noster fuisset verterem vix te, his magna altera mucius at. Cum tritani ' +
		'platonem id, expetendis definitionem ei sit, mea ne cibo gloriatur persequeris. Ex purto unum eos, ' +
		'an mazim blandit quo. Ad prima dicant labores eos, at case ullamcorper mel, detracto nominavi cum eu.';

	/* ~ Join ~ */

	/**
	 * Transforms a List of Strings into a single String separated by a specified
	 * joining String.
	 */
	public static String join(List<String> strList, String joiningStr) {
		Iterator<String> it = strList.iterator();
		String returnString = '';
		while (it.hasNext()) {
			returnString += it.next();
			if (it.hasNext()) {
				returnString += joiningStr;
			}
		}
		return returnString;
	}

	/* ~ Pluralize ~ */

	private static final Map<String,String> abnormalPlurals = new Map<String,String> {
		'person' => 'people',
		'Person' => 'People'
	};
	/**
	 * Takes a string and pluralizes that string if the count integer is not 1.
	 * Uses map abnormalPlurals to define abnormal pluralizations.  Otherwise
	 * just adds an 's'.
	 */
	public static String pluralize(String str, Integer count) {
		String ret = str;
		if (count != 1) {
			if (abnormalPlurals.containsKey(str)) {
				ret = abnormalPlurals.get(str);
			} else if (str.endsWith('x')) {
				ret = str + 'es';
			} else if (str.endsWith('y')) {
				ret = str.removeEnd('y')  + 'ies';
			} else {
				ret = str + 's';
			}
		}
		return ret;
	}
	
	/* ~ Cleaning ~ */

	/**
	 * Takes a string and removes any non-alpha-numeric characters.
	 * Useful for validating Id parameters from URLs.
	 */
	public static String cleanAlphaNum(String str) {
		return str.replaceAll('[^a-zA-Z0-9]','');
	}

	/**
	 * Takes a list of strings and removes any string that is only whitespace.
	 * Note: Does not trim whitespace off of non-blank strings.
	 */
	public static List<String> removeBlankStrings(List<String> strs) {
		List<String> ret = new List<String>();
		for (String s : strs) {
			if (s != null) {
				String compare = s.replaceAll('\\s','');
				if (compare != '') {
					ret.add(s);
				}
			}
		}
		return ret;
	}

	/* ~ Unit Tests ~ */

	@isTest static void testJoin() {
		List<String> strs = new List<String> {'A', 'B', 'C'};
		Test.startTest();
		System.assert(join(strs, ', ') == 'A, B, C');
		Test.stopTest();
	}

	@isTest static void testPluralize() {
		Test.startTest();
		System.assert(pluralize('Test', 1) == 'Test');
		System.assert(pluralize('Test', 2) == 'Tests');
		System.assert(pluralize('Box', 1) == 'Box');
		System.assert(pluralize('Box', 2) == 'Boxes');
		System.assert(pluralize('Company', 1) == 'Company');
		System.assert(pluralize('Company', 2) == 'Companies');
		System.assert(pluralize('Person', 1) == 'Person');
		System.assert(pluralize('Person', 2) == 'People');
		Test.stopTest();
	}

	@isTest static void testCleanAlphaNum() {
		String clean = 'ABC123';
		String unclean = 'A BC_123\'()*';
		Test.startTest();
		System.assert(cleanAlphaNum(clean) == 'ABC123');
		System.assert(cleanAlphaNum(unclean) == 'ABC123');
		Test.stopTest();
	}

	@isTest static void testRemoveBlankStrings() {
		List<String> strs = new List<String> {null, 'a', '', ' ', '    ', '\t', '\n', ' \t  \n '};
		Test.startTest();
		System.assert(removeBlankStrings(strs) == new String[] {'a'});
		Test.stopTest();
	}
}
