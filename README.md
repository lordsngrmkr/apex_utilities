Apex Utilities
==============

An assortment of useful helper utilites for Apex development

DynamicQuery *
--------------

Class that simplifies incrementally building dynamic SOQL queries.
 * Still in development

TestUnit
--------

Contains a number wrappers around `System.assert` that provides sensible
error messages so you don't have to manually add your own on every `assert`.

SortByField *
-------------

Contains a method to dynamically sort a list of sObjects by the value of a
specified field.
 * Almost universally useless - SOQL `ORDER BY` is faster and simpler.
 This is useful only as a demonstration of dynamic Apex.

StringHelpers
-------------

A collection of miscellaneous helper methods for Strings

SObjectHelpers
--------------

A collection of miscellaneous helper methods for sObjects

CountQueries
------------

A bash script which parses debug logs to count the number of times each
distinct SOQL query in the log executes, and then attempt to locate the
file where that query is found.  Useful for debugging governor limit
errors.

    Usage:
		```bash
		./count_queries.sh [debug log file] [path to src directory]
		```

