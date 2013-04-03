Apex Utilities
==============

An assortment of useful helper utilites in Apex

TestUnit
--------

Contains a number wrappers around `System.assert` that provides sensible
error messages so you don't have to manually add your own on every `assert`.

DynamicQuery *
--------------

Class that simplifies incrementally building dynamic SOQL queries.
 * Still in development

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

