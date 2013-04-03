public class TestUnit {

	/* ~ Test methods ~ */

	public static void start() {
		Test.startTest();
	}

	public static void stop() {
		Test.stopTest();
	}

	/* ~ Generic assertions ~ */

	public static void assert(Boolean expr) {
		TestUnit.assert(expr, 'No failure message given');
	}

	public static void assert(Boolean expr, String message) {
		System.assert(expr, message);
	}

	public static void assertNull(Object a) {
		System.assert(a == null, 'Expected null, but found: ' + a);
	}

	public static void assertNotNull(Object a) {
		System.assert(a != null, 'Expected not null, but found: ' + a);
	}

	public static void assertEqual(Object a, Object b) {
		System.assert(a == b, 'Expected equal, but found: ' + a + ' != ' + b);
	}

	public static void assertNotEqual(Object a, Object b) {
		System.assert(a != b, 'Expected not equal, but found: ' + a + ' == ' + b);
	}

	/* ~ Long comparisons ~ */

	public static void assertLessThan(Long a, Long b) {
		System.assert(a < b, 'Expected less than, but found: ' + a + ' >= ' + b);
	}

	public static void assertLessThanOrEqual(Long a, Long b) {
		System.assert(a <= b, 'Expected less than or equal, but found: ' + a + ' > ' + b);
	}

	public static void assertGreaterThan(Long a, Long b) {
		System.assert(a > b, 'Expected greater than, but found: ' + a + ' <= ' + b);
	}

	public static void assertGreaterThanOrEqual(Long a, Long b) {
		System.assert(a >= b, 'Expected greater than or equal, but found: ' + a + ' < ' + b);
	}

	/* ~ Decimal comparisons ~ */

	public static void assertLessThan(Decimal a, Decimal b) {
		System.assert(a < b, 'Expected less than, but found: ' + a + ' >= ' + b);
	}

	public static void assertLessThanOrEqual(Decimal a, Decimal b) {
		System.assert(a <= b, 'Expected less than or equal, but found: ' + a + ' > ' + b);
	}

	public static void assertGreaterThan(Decimal a, Decimal b) {
		System.assert(a > b, 'Expected greater than, but found: ' + a + ' <= ' + b);
	}

	public static void assertGreaterThanOrEqual(Decimal a, Decimal b) {
		System.assert(a >= b, 'Expected greater than or equal, but found: ' + a + ' < ' + b);
	}

	/* ~ Date/Datetime comparisons ~ */

	public static void assertLessThan(Datetime a, Datetime b) {
		System.assert(a < b, 'Expected less than, but found: ' + a + ' >= ' + b);
	}

	public static void assertLessThanOrEqual(Datetime a, Datetime b) {
		System.assert(a <= b, 'Expected less than or equal, but found: ' + a + ' > ' + b);
	}

	public static void assertGreaterThan(Datetime a, Datetime b) {
		System.assert(a > b, 'Expected greater than, but found: ' + a + ' <= ' + b);
	}

	public static void assertGreaterThanOrEqual(Datetime a, Datetime b) {
		System.assert(a >= b, 'Expected greater than or equal, but found: ' + a + ' < ' + b);
	}

	/* ~ Time comparisons ~ */

	public static void assertLessThan(Time a, Time b) {
		System.assert(a < b, 'Expected less than, but found: ' + a + ' >= ' + b);
	}

	public static void assertLessThanOrEqual(Time a, Time b) {
		System.assert(a <= b, 'Expected less than or equal, but found: ' + a + ' > ' + b);
	}

	public static void assertGreaterThan(Time a, Time b) {
		System.assert(a > b, 'Expected greater than, but found: ' + a + ' <= ' + b);
	}

	public static void assertGreaterThanOrEqual(Time a, Time b) {
		System.assert(a >= b, 'Expected greater than or equal, but found: ' + a + ' < ' + b);
	}

	/* ~ String comparisons ~ */

	public static void assertLessThan(String a, String b) {
		System.assert(a.compareTo(b) < 0, 'Expected less than, but found: ' + a + ' >= ' + b);
	}

	public static void assertLessThanOrEqual(String a, String b) {
		System.assert(a.compareTo(b) <= 0, 'Expected less than or equal, but found: ' + a + ' > ' + b);
	}

	public static void assertGreaterThan(String a, String b) {
		System.assert(a.compareTo(b) > 0, 'Expected greater than, but found: ' + a + ' <= ' + b);
	}

	public static void assertGreaterThanOrEqual(String a, String b) {
		System.assert(a.compareTo(b) >= 0, 'Expected greater than or equal, but found: ' + a + ' < ' + b);
	}

	/* ~ Comparable comparisons ~ */

	public static void assertEqual(Comparable a, Comparable b) {
		System.assert(a.compareTo(b) == 0, 'Expected equal, but found ' + a + ' != ' + b);
	}

	public static void assertNotEqual(Comparable a, Comparable b) {
		System.assert(a.compareTo(b) != 0, 'Expected not equal, but found: ' + a + ' == ' + b);
	}

	public static void assertLessThan(Comparable a, Comparable b) {
		System.assert(a.compareTo(b) < 0, 'Expected less than, but found: ' + a + ' >= ' + b);
	}

	public static void assertLessThanOrEqual(Comparable a, Comparable b) {
		System.assert(a.compareTo(b) <= 0, 'Expected less than or equal, but found: ' + a + ' > ' + b);
	}

	public static void assertGreaterThan(Comparable a, Comparable b) {
		System.assert(a.compareTo(b) > 0, 'Expected greater than, but found: ' + a + ' <= ' + b);
	}

	public static void assertGreaterThanOrEqual(Comparable a, Comparable b) {
		System.assert(a.compareTo(b) >= 0, 'Expected greater than or equal, but found: ' + a + ' < ' + b);
	}

	/* ~ Shorthand ~ */
	public static void assertE  (Object     a, Object     b) { TestUnit.assertEqual(a,b);              }
	public static void assertNE (Object     a, Object     b) { TestUnit.assertNotEqual(a,b);           }
	public static void assertLT (Long       a, Long       b) { TestUnit.assertLessThan(a,b);           }
	public static void assertLTE(Long       a, Long       b) { TestUnit.assertLessThanOrEqual(a,b);    }
	public static void assertGT (Long       a, Long       b) { TestUnit.assertGreaterThan(a,b);        }
	public static void assertGTE(Long       a, Long       b) { TestUnit.assertGreaterThanOrEqual(a,b); }
	public static void assertLT (Decimal    a, Decimal    b) { TestUnit.assertLessThan(a,b);           }
	public static void assertLTE(Decimal    a, Decimal    b) { TestUnit.assertLessThanOrEqual(a,b);    }
	public static void assertGT (Decimal    a, Decimal    b) { TestUnit.assertGreaterThan(a,b);        }
	public static void assertGTE(Decimal    a, Decimal    b) { TestUnit.assertGreaterThanOrEqual(a,b); }
	public static void assertLT (Datetime   a, Datetime   b) { TestUnit.assertLessThan(a,b);           }
	public static void assertLTE(Datetime   a, Datetime   b) { TestUnit.assertLessThanOrEqual(a,b);    }
	public static void assertGT (Datetime   a, Datetime   b) { TestUnit.assertGreaterThan(a,b);        }
	public static void assertGTE(Datetime   a, Datetime   b) { TestUnit.assertGreaterThanOrEqual(a,b); }
	public static void assertLT (Time       a, Time       b) { TestUnit.assertLessThan(a,b);           }
	public static void assertLTE(Time       a, Time       b) { TestUnit.assertLessThanOrEqual(a,b);    }
	public static void assertGT (Time       a, Time       b) { TestUnit.assertGreaterThan(a,b);        }
	public static void assertGTE(Time       a, Time       b) { TestUnit.assertGreaterThanOrEqual(a,b); }
	public static void assertLT (String     a, String     b) { TestUnit.assertLessThan(a,b);           }
	public static void assertLTE(String     a, String     b) { TestUnit.assertLessThanOrEqual(a,b);    }
	public static void assertGT (String     a, String     b) { TestUnit.assertGreaterThan(a,b);        }
	public static void assertGTE(String     a, String     b) { TestUnit.assertGreaterThanOrEqual(a,b); }
	public static void assertE  (Comparable a, Comparable b) { TestUnit.assertEqual(a,b);              }
	public static void assertNE (Comparable a, Comparable b) { TestUnit.assertNotEqual(a,b);           }
	public static void assertLT (Comparable a, Comparable b) { TestUnit.assertLessThan(a,b);           }
	public static void assertLTE(Comparable a, Comparable b) { TestUnit.assertLessThanOrEqual(a,b);    }
	public static void assertGT (Comparable a, Comparable b) { TestUnit.assertGreaterThan(a,b);        }
	public static void assertGTE(Comparable a, Comparable b) { TestUnit.assertGreaterThanOrEqual(a,b); }

	/* ~ Integer Type Conversions ~ */
	public static void assertLessThan          (Long    a, Integer b) { TestUnit.assertLessThan((Long) a, (Long) b);           }
	public static void assertLessThan          (Integer a, Long    b) { TestUnit.assertLessThan((Long) a, (Long) b);           }
	public static void assertLessThan          (Integer a, Integer b) { TestUnit.assertLessThan((Long) a, (Long) b);           }
	public static void assertLT                (Long    a, Integer b) { TestUnit.assertLessThan((Long) a, (Long) b);           }
	public static void assertLT                (Integer a, Long    b) { TestUnit.assertLessThan((Long) a, (Long) b);           }
	public static void assertLT                (Integer a, Integer b) { TestUnit.assertLessThan((Long) a, (Long) b);           }
	public static void assertLessThanOrEqual   (Long    a, Integer b) { TestUnit.assertLessThanOrEqual((Long) a, (Long) b);    }
	public static void assertLessThanOrEqual   (Integer a, Long    b) { TestUnit.assertLessThanOrEqual((Long) a, (Long) b);    }
	public static void assertLessThanOrEqual   (Integer a, Integer b) { TestUnit.assertLessThanOrEqual((Long) a, (Long) b);    }
	public static void assertLTE               (Long    a, Integer b) { TestUnit.assertLessThanOrEqual((Long) a, (Long) b);    }
	public static void assertLTE               (Integer a, Long    b) { TestUnit.assertLessThanOrEqual((Long) a, (Long) b);    }
	public static void assertLTE               (Integer a, Integer b) { TestUnit.assertLessThanOrEqual((Long) a, (Long) b);    }
	public static void assertGreaterThan       (Long    a, Integer b) { TestUnit.assertGreaterThan((Long) a, (Long) b);        }
	public static void assertGreaterThan       (Integer a, Long    b) { TestUnit.assertGreaterThan((Long) a, (Long) b);        }
	public static void assertGreaterThan       (Integer a, Integer b) { TestUnit.assertGreaterThan((Long) a, (Long) b);        }
	public static void assertGT                (Long    a, Integer b) { TestUnit.assertGreaterThan((Long) a, (Long) b);        }
	public static void assertGT                (Integer a, Long    b) { TestUnit.assertGreaterThan((Long) a, (Long) b);        }
	public static void assertGT                (Integer a, Integer b) { TestUnit.assertGreaterThan((Long) a, (Long) b);        }
	public static void assertGreaterThanOrEqual(Long    a, Integer b) { TestUnit.assertGreaterThanOrEqual((Long) a, (Long) b); }
	public static void assertGreaterThanOrEqual(Integer a, Long    b) { TestUnit.assertGreaterThanOrEqual((Long) a, (Long) b); }
	public static void assertGreaterThanOrEqual(Integer a, Integer b) { TestUnit.assertGreaterThanOrEqual((Long) a, (Long) b); }
	public static void assertGTE               (Long    a, Integer b) { TestUnit.assertGreaterThanOrEqual((Long) a, (Long) b); }
	public static void assertGTE               (Integer a, Long    b) { TestUnit.assertGreaterThanOrEqual((Long) a, (Long) b); }
	public static void assertGTE               (Integer a, Integer b) { TestUnit.assertGreaterThanOrEqual((Long) a, (Long) b); }

	/* ~ Floating Point Type Conversions ~ */
	public static void assertLessThan          (Decimal a, Double  b) { TestUnit.assertLessThan((Decimal) a, (Decimal) b);           }
	public static void assertLessThan          (Double  a, Decimal b) { TestUnit.assertLessThan((Decimal) a, (Decimal) b);           }
	public static void assertLessThan          (Double  a, Double  b) { TestUnit.assertLessThan((Decimal) a, (Decimal) b);           }
	public static void assertLT                (Decimal a, Double  b) { TestUnit.assertLessThan((Decimal) a, (Decimal) b);           }
	public static void assertLT                (Double  a, Decimal b) { TestUnit.assertLessThan((Decimal) a, (Decimal) b);           }
	public static void assertLT                (Double  a, Double  b) { TestUnit.assertLessThan((Decimal) a, (Decimal) b);           }
	public static void assertLessThanOrEqual   (Decimal a, Double  b) { TestUnit.assertLessThanOrEqual((Decimal) a, (Decimal) b);    }
	public static void assertLessThanOrEqual   (Double  a, Decimal b) { TestUnit.assertLessThanOrEqual((Decimal) a, (Decimal) b);    }
	public static void assertLessThanOrEqual   (Double  a, Double  b) { TestUnit.assertLessThanOrEqual((Decimal) a, (Decimal) b);    }
	public static void assertLTE               (Decimal a, Double  b) { TestUnit.assertLessThanOrEqual((Decimal) a, (Decimal) b);    }
	public static void assertLTE               (Double  a, Decimal b) { TestUnit.assertLessThanOrEqual((Decimal) a, (Decimal) b);    }
	public static void assertLTE               (Double  a, Double  b) { TestUnit.assertLessThanOrEqual((Decimal) a, (Decimal) b);    }
	public static void assertGreaterThan       (Decimal a, Double  b) { TestUnit.assertGreaterThan((Decimal) a, (Decimal) b);        }
	public static void assertGreaterThan       (Double  a, Decimal b) { TestUnit.assertGreaterThan((Decimal) a, (Decimal) b);        }
	public static void assertGreaterThan       (Double  a, Double  b) { TestUnit.assertGreaterThan((Decimal) a, (Decimal) b);        }
	public static void assertGT                (Decimal a, Double  b) { TestUnit.assertGreaterThan((Decimal) a, (Decimal) b);        }
	public static void assertGT                (Double  a, Decimal b) { TestUnit.assertGreaterThan((Decimal) a, (Decimal) b);        }
	public static void assertGT                (Double  a, Double  b) { TestUnit.assertGreaterThan((Decimal) a, (Decimal) b);        }
	public static void assertGreaterThanOrEqual(Decimal a, Double  b) { TestUnit.assertGreaterThanOrEqual((Decimal) a, (Decimal) b); }
	public static void assertGreaterThanOrEqual(Double  a, Decimal b) { TestUnit.assertGreaterThanOrEqual((Decimal) a, (Decimal) b); }
	public static void assertGreaterThanOrEqual(Double  a, Double  b) { TestUnit.assertGreaterThanOrEqual((Decimal) a, (Decimal) b); }
	public static void assertGTE               (Decimal a, Double  b) { TestUnit.assertGreaterThanOrEqual((Decimal) a, (Decimal) b); }
	public static void assertGTE               (Double  a, Decimal b) { TestUnit.assertGreaterThanOrEqual((Decimal) a, (Decimal) b); }
	public static void assertGTE               (Double  a, Double  b) { TestUnit.assertGreaterThanOrEqual((Decimal) a, (Decimal) b); }

	/* ~ Unit Tests ~ */

	@isTest static void testGenericAssertions() {
		TestUnit.start();
		TestUnit.assert(true);
		TestUnit.assert(true, 'Error message');
		TestUnit.assertNull(null);
		TestUnit.assertNotNull('');
		TestUnit.assertEqual('', '');
		TestUnit.assertNotEqual('', ' ');
		TestUnit.stop();
	}

	@isTest static void testLongComparisons() {
		Long one = 1;
		Long alsoOne = 1;
		Long two = 2;
		TestUnit.start();
		TestUnit.assertE(one, alsoOne);
		TestUnit.assertNE(one, two);
		TestUnit.assertLT(one, two);
		TestUnit.assertLTE(one, two);
		TestUnit.assertLTE(one, alsoOne);
		TestUnit.assertGT(two, one);
		TestUnit.assertGTE(two, one);
		TestUnit.assertGTE(one, alsoOne);
		TestUnit.stop();
	}

	@isTest static void testDecimalComparisons() {
		Decimal one = 1.0;
		Decimal alsoOne = 1.0;
		Decimal two = 2.0;
		TestUnit.start();
		TestUnit.assertE(one, alsoOne);
		TestUnit.assertNE(one, two);
		TestUnit.assertLT(one, two);
		TestUnit.assertLTE(one, two);
		TestUnit.assertLTE(one, alsoOne);
		TestUnit.assertGT(two, one);
		TestUnit.assertGTE(two, one);
		TestUnit.assertGTE(one, alsoOne);
		TestUnit.stop();
	}

	@isTest static void testDateComparisons() {
		Date today = Date.today();
		Date alsoToday = today;
		Date tomorrow = today.addDays(1);
		TestUnit.start();
		TestUnit.assertE(today, alsoToday);
		TestUnit.assertNE(today, tomorrow);
		TestUnit.assertLT(today, tomorrow);
		TestUnit.assertLTE(today, tomorrow);
		TestUnit.assertLTE(today, alsoToday);
		TestUnit.assertGT(tomorrow, today);
		TestUnit.assertGTE(tomorrow, today);
		TestUnit.assertGTE(today, alsoToday);
		TestUnit.stop();
	}

	@isTest static void testDatetimeComparisons() {
		Datetime now = Datetime.now();
		Datetime alsoNow = now;
		Datetime tomorrow = now.addDays(1);
		TestUnit.start();
		TestUnit.assertE(now, alsoNow);
		TestUnit.assertNE(now, tomorrow);
		TestUnit.assertLT(now, tomorrow);
		TestUnit.assertLTE(now, tomorrow);
		TestUnit.assertLTE(now, alsoNow);
		TestUnit.assertGT(tomorrow, now);
		TestUnit.assertGTE(tomorrow, now);
		TestUnit.assertGTE(now, alsoNow);
		TestUnit.stop();
	}

	@isTest static void testTimeComparisons() {
		Time now = Datetime.now().time();
		Time alsoNow = now;
		Time later = now.addHours(1);
		TestUnit.start();
		TestUnit.assertE(now, alsoNow);
		TestUnit.assertNE(now, later);
		TestUnit.assertLT(now, later);
		TestUnit.assertLTE(now, later);
		TestUnit.assertLTE(now, alsoNow);
		TestUnit.assertGT(later, now);
		TestUnit.assertGTE(later, now);
		TestUnit.assertGTE(now, alsoNow);
		TestUnit.stop();
	}

	@isTest static void testStringComparisons() {
		String a = 'a';
		String alsoA = 'a';
		String b = 'b';
		TestUnit.start();
		TestUnit.assertE(a, alsoA);
		TestUnit.assertNE(a, b);
		TestUnit.assertLT(a, b);
		TestUnit.assertLTE(a, b);
		TestUnit.assertLTE(a, alsoA);
		TestUnit.assertGT(b, a);
		TestUnit.assertGTE(b, a);
		TestUnit.assertGTE(a, alsoA);
		TestUnit.stop();
	}

	@isTest static void testComparableComparisons() {
		MyComparable one = new MyComparable(1);
		MyComparable alsoOne = new MyComparable(1);
		MyComparable two = new MyComparable(2);
		TestUnit.start();
		TestUnit.assertE(one, alsoOne);
		TestUnit.assertNE(one, two);
		TestUnit.assertLT(one, two);
		TestUnit.assertLTE(one, two);
		TestUnit.assertLTE(one, alsoOne);
		TestUnit.assertGT(two, one);
		TestUnit.assertGTE(two, one);
		TestUnit.assertGTE(one, alsoOne);
		TestUnit.stop();
	}

	@isTest static void testIntegerTypeConversions() {
		Integer one = 1;
		Integer alsoOne = 1;
		Integer two = 2;
		Long oneLong = 1;
		Long twoLong = 2;
		TestUnit.start();
		// both args Integers
		TestUnit.assertEqual(one, alsoOne);
		TestUnit.assertNotEqual(one, two);
		TestUnit.assertLessThan(one, two);
		TestUnit.assertLessThanOrEqual(one, two);
		TestUnit.assertLessThanOrEqual(one, alsoOne);
		TestUnit.assertGreaterThan(two, one);
		TestUnit.assertGreaterThanOrEqual(two, one);
		TestUnit.assertGreaterThanOrEqual(one, alsoOne);
		// first arg Integer
		TestUnit.assertEqual(one, oneLong);
		TestUnit.assertNotEqual(one, twoLong);
		TestUnit.assertLessThan(one, twoLong);
		TestUnit.assertLessThanOrEqual(one, twoLong);
		TestUnit.assertLessThanOrEqual(one, oneLong);
		TestUnit.assertGreaterThan(two, oneLong);
		TestUnit.assertGreaterThanOrEqual(two, oneLong);
		TestUnit.assertGreaterThanOrEqual(one, oneLong);
		// second arg Integer
		TestUnit.assertEqual(oneLong, one);
		TestUnit.assertNotEqual(oneLong, two);
		TestUnit.assertLessThan(oneLong, two);
		TestUnit.assertLessThanOrEqual(oneLong, two);
		TestUnit.assertLessThanOrEqual(oneLong, one);
		TestUnit.assertGreaterThan(twoLong, one);
		TestUnit.assertGreaterThanOrEqual(twoLong, one);
		TestUnit.assertGreaterThanOrEqual(oneLong, one);
		TestUnit.stop();
	}

	@isTest static void testFloatTypeConversions() {
		Double one = 1.0;
		Double alsoOne = 1.0;
		Double two = 2.0;
		Decimal oneDecimal = 1.0;
		Decimal twoDecimal = 2.0;
		TestUnit.start();
		// both args Doubles
		TestUnit.assertEqual(one, alsoOne);
		TestUnit.assertNotEqual(one, two);
		TestUnit.assertLessThan(one, two);
		TestUnit.assertLessThanOrEqual(one, two);
		TestUnit.assertLessThanOrEqual(one, alsoOne);
		TestUnit.assertGreaterThan(two, one);
		TestUnit.assertGreaterThanOrEqual(one, alsoOne);
		// first arg Double
		TestUnit.assertEqual(one, oneDecimal);
		TestUnit.assertNotEqual(one, twoDecimal);
		TestUnit.assertLessThan(one, twoDecimal);
		TestUnit.assertLessThanOrEqual(one, twoDecimal);
		TestUnit.assertLessThanOrEqual(one, oneDecimal);
		TestUnit.assertGreaterThan(two, oneDecimal);
		TestUnit.assertGreaterThanOrEqual(one, oneDecimal);
		// second arg Double
		TestUnit.assertEqual(oneDecimal, one);
		TestUnit.assertNotEqual(oneDecimal, two);
		TestUnit.assertLessThan(oneDecimal, two);
		TestUnit.assertLessThanOrEqual(oneDecimal, two);
		TestUnit.assertLessThanOrEqual(oneDecimal, one);
		TestUnit.assertGreaterThan(twoDecimal, one);
		TestUnit.assertGreaterThanOrEqual(twoDecimal, one);
		TestUnit.assertGreaterThanOrEqual(oneDecimal, one);
		TestUnit.stop();
	}

	@isTest static void testIntegerTypeConversionsShorthand() {
		Integer one = 1;
		Integer alsoOne = 1;
		Integer two = 2;
		Long oneLong = 1;
		Long twoLong = 2;
		TestUnit.start();
		// both args Integers
		TestUnit.assertE(one, alsoOne);
		TestUnit.assertNE(one, two);
		TestUnit.assertLT(one, two);
		TestUnit.assertLTE(one, two);
		TestUnit.assertLTE(one, alsoOne);
		TestUnit.assertGT(two, one);
		TestUnit.assertGTE(two, one);
		TestUnit.assertGTE(one, alsoOne);
		// first arg Integer
		TestUnit.assertE(one, oneLong);
		TestUnit.assertNE(one, twoLong);
		TestUnit.assertLT(one, twoLong);
		TestUnit.assertLTE(one, twoLong);
		TestUnit.assertLTE(one, oneLong);
		TestUnit.assertGT(two, oneLong);
		TestUnit.assertGTE(two, oneLong);
		TestUnit.assertGTE(one, oneLong);
		// second arg Integer
		TestUnit.assertE(oneLong, one);
		TestUnit.assertNE(oneLong, two);
		TestUnit.assertLT(oneLong, two);
		TestUnit.assertLTE(oneLong, two);
		TestUnit.assertLTE(oneLong, one);
		TestUnit.assertGT(twoLong, one);
		TestUnit.assertGTE(twoLong, one);
		TestUnit.assertGTE(oneLong, one);
		TestUnit.stop();
	}

	@isTest static void testFloatTypeConversionsShorthand() {
		Double one = 1.0;
		Double alsoOne = 1.0;
		Double two = 2.0;
		Decimal oneDecimal = 1.0;
		Decimal twoDecimal = 2.0;
		TestUnit.start();
		// both args Doubles
		TestUnit.assertE(one, alsoOne);
		TestUnit.assertNE(one, two);
		TestUnit.assertLT(one, two);
		TestUnit.assertLTE(one, two);
		TestUnit.assertLTE(one, alsoOne);
		TestUnit.assertGT(two, one);
		TestUnit.assertGTE(two, one);
		TestUnit.assertGTE(one, alsoOne);
		// first arg Double
		TestUnit.assertE(one, oneDecimal);
		TestUnit.assertNE(one, twoDecimal);
		TestUnit.assertLT(one, twoDecimal);
		TestUnit.assertLTE(one, twoDecimal);
		TestUnit.assertLTE(one, oneDecimal);
		TestUnit.assertGT(two, oneDecimal);
		TestUnit.assertGTE(two, oneDecimal);
		TestUnit.assertGTE(one, oneDecimal);
		// second arg Double
		TestUnit.assertE(oneDecimal, one);
		TestUnit.assertNE(oneDecimal, two);
		TestUnit.assertLT(oneDecimal, two);
		TestUnit.assertLTE(oneDecimal, two);
		TestUnit.assertLTE(oneDecimal, one);
		TestUnit.assertGT(twoDecimal, one);
		TestUnit.assertGTE(twoDecimal, one);
		TestUnit.assertGTE(oneDecimal, one);
		TestUnit.stop();
	}

	public class MyComparable implements Comparable {
		public Integer v;
		public MyComparable(Integer value) { v = value; }
		public Integer compareTo(Object compareTo) {
			MyComparable other = (MyComparable) compareTo;
			if (v < other.v) return -1;
			else if (v > other.v) return 1;
			else return 0;
		}
	}

	@isTest static void testMyComparable() {
		MyComparable one = new MyComparable(1);
		MyComparable alsoOne = new MyComparable(1);
		MyComparable two = new MyComparable(2);
		Test.startTest();
		System.assert(one.compareTo(two) < 0);
		System.assert(one.compareTo(alsoOne) == 0);
		System.assert(two.compareTo(one) > 0);
		Test.stopTest();
	}
}

