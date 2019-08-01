/*******************************************************************************
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 *******************************************************************************/
package org.apache.ofbiz.base.util.collections.test;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.math.BigDecimal;
import org.apache.ofbiz.base.lang.SourceMonitored;
import org.apache.ofbiz.base.test.GenericTestCaseBase;
import org.apache.ofbiz.base.util.Debug;
import org.apache.ofbiz.base.util.collections.FlexibleMapAccessor;
import org.apache.ofbiz.base.util.string.FlexibleStringExpander;

@SourceMonitored

public class FlexibleMapAccessorTests extends GenericTestCaseBase {

    private static final Locale localeToTest = new  Locale("en", "US");

    private static FlexibleMapAccessor<?> fmaEmpty = FlexibleMapAccessor.getInstance("");

    private static FlexibleMapAccessor<?> fmaNull = FlexibleMapAccessor.getInstance(null);

    public FlexibleMapAccessorTests(String name) {
        super(name);
    }

    private static <T> void fmaTest(String label, String getText, String fseText, T var, String value) {
        fmaTest(new FmaTestData(label, getText, getText, fseText, null, var, value));
    }

    private class FmaTestData<T> {
      public final String label;
      public final String getText;
      public final String putText;
      public final String fseText;
      public final Locale locale;
      public final T var;
      public final String value;
      public FmaTestData(String label, String getText, String putText, String fseText, Locale locale, T var, String value) {
        this.label = label;
        this.getText = getText;
        this.putText = putText;
        this.fseText = fseText;
        this.locale = locale;
        this.var = var;
        this.value = value;
      }
    }

    private static <T> void fmaTest(FmaTestData<T> d) {
        Map<String, Object> testMap = new  HashMap<String, Object>();
        FlexibleMapAccessor<T> fmaGet = FlexibleMapAccessor.getInstance(getText);
        FlexibleMapAccessor<T> fmaPut = FlexibleMapAccessor.getInstance(d.putText);
        fmaTestGeneral(d, fmaGet, fmaPut);
        FlexibleStringExpander fse = FlexibleStringExpander.getInstance(d.fseText);
        fmaTestFse(d, fmaGet, fmaPut);
    }

    private static <T> void fmaTestGeneral(FmaTestData<T> d, FlexibleMapAccessor<T> fmaGet, FlexibleMapAccessor<T> fmaPut) {
        assertEquals(d.label + ":get-original-name", d.getText, fmaGet.getOriginalName());
        assertEquals(d.label + ":get-isEmpty", false, fmaGet.isEmpty());
        assertEquals(d.label + ":get-instance-equals", fmaGet, FlexibleMapAccessor.getInstance(d.getText));
        assertEquals(d.label + ":toString", d.getText, fmaGet.toString());
        assertNotEquals(d.label + ":get-not-equals-empty", fmaEmpty, fmaGet);
        assertNotEquals(d.label + ":get-not-equals-null", fmaNull, fmaGet);
        assertNotEquals(d.label + ":empty-not-equals-get", fmaGet, fmaEmpty);
        assertNotEquals(d.label + ":null-not-equals-get", fmaGet, fmaNull);
        assertNotEquals(d.label + ":get-not-equals-other", fmaGet, FlexibleMapAccessorTests.class);
        assertEquals(d.label + ":get-toString", d.getText, fmaGet.toString());
        FlexibleMapAccessor<T> fmaGetAscending = FlexibleMapAccessor.getInstance("+" + d.getText);
        assertEquals(d.label + ":get-ascending-toString", "+" + d.getText, fmaGetAscending.toString());
        assertTrue(d.label + ":get-ascending-isAscending", fmaGetAscending.getIsAscending());
        FlexibleMapAccessor<T> fmaGetDescending = FlexibleMapAccessor.getInstance("-" + d.getText);
        assertEquals(d.label + ":get-descending-toString", "-" + d.getText, fmaGetDescending.toString());
        assertFalse(d.label + ":get-decending-isAscending", fmaGetDescending.getIsAscending());
        assertEquals(d.label + ":put-toString", d.putText, fmaPut.toString());
        assertEquals(d.label + ":put-original-name", d.putText, fmaPut.getOriginalName());
        assertEquals(d.label + ":put-isEmpty", false, fmaPut.isEmpty());
        assertEquals(d.label + ":put-instance-equals", fmaPut, FlexibleMapAccessor.getInstance(d.putText));
        assertNotEquals(d.label + ":put-not-equals-other", fmaPut, FlexibleMapAccessorTests.class);
    }

    private static <T> void fmaTestFse(FmaTestData<T> d, FlexibleMapAccessor<T> fmaGet, FlexibleMapAccessor<T> fmaPut, FlexibleStringExpander fse) {
        if (d.locale == null) {
            assertNull(d.label + ":get-initial", fmaGet.get(testMap));
            fmaPut.put(testMap, d.var);
            assertFalse(d.label + ":testMap-not-empty", testMap.isEmpty());
            assertEquals(d.label + ":get", d.var, fmaGet.get(testMap));
            assertEquals(d.label, d.value, fse.expandString(testMap));
            assertEquals(d.label + ":remove", d.var, fmaGet.remove(testMap));
            assertNull(d.label + ":remove-not-exist", fmaGet.remove(testMap));
        } else {
            fmaPut.put(testMap, d.var);
            assertFalse(d.label + ":testMap-not-empty", testMap.isEmpty());
            assertEquals(d.label + ":get", d.value, fmaGet.get(testMap, d.locale));
            // BUG: fmaGet modifies testMap, even tho it shouldn't
            assertEquals(d.label + ":get", d.value, fmaGet.get(testMap, null));
            assertEquals(d.label, d.value, fse.expandString(testMap, d.locale));
        }
        testMap.clear();
        fmaPut.put(testMap, null);
        assertFalse(d.label + ":testMap-not-empty-put-null", testMap.isEmpty());
        if (d.locale == null) {
            assertNull(d.label + ":get-put-null", fmaGet.get(testMap));
        }
        testMap.clear();
        Exception caught = null;
        try {
            fmaPut.put(null, d.var);
        } catch (Exception e) {
            caught = e;
        } finally {
            assertNotNull(d.label + ":put-null-map", caught);
            assertTrue(d.label + ":put-null-map-isEmpty", testMap.isEmpty());
        }
        Set<FlexibleMapAccessor<?>> set = new  HashSet<FlexibleMapAccessor<?>>();
        assertFalse(d.label + ":not-in-set", set.contains(fmaGet));
        set.add(fmaGet);
        assertTrue(d.label + ":in-set", set.contains(fmaGet));
    }

    private static void fmaEmptyTest(String label, String text) {
        FlexibleMapAccessor<Class<?>> fma = FlexibleMapAccessor.getInstance(text);
        assertTrue(label + ":isEmpty", fma.isEmpty());
        Map<String, Object> testMap = new  HashMap<String, Object>();
        assertNull(label + ":get", fma.get(null));
        assertNull(label + ":get", fma.get(testMap));
        assertTrue(label + ":map-isEmpty-initial", testMap.isEmpty());
        fma.put(testMap, FlexibleMapAccessorTests.class);
        assertTrue(label + ":map-isEmpty-map", testMap.isEmpty());
        fma.put(null, FlexibleMapAccessorTests.class);
        assertTrue(label + ":map-isEmpty-null", testMap.isEmpty());
        assertSame(label + ":same-null", fmaNull, fma);
        assertSame(label + ":same-empty", fmaEmpty, fma);
        assertEquals(label + ":original-name", "", fma.getOriginalName());
        assertNull(label + ":remove", fma.remove(testMap));
        assertNotNull(label + ":toString", fma.toString());
    }

    public void testFlexibleMapAccessor() {
        fmaEmptyTest("fmaEmpty", "");
        fmaEmptyTest("fmaNull", null);
        fmaEmptyTest("fma\"null\"", "null");
        fmaTest("UEL auto-vivify Map", "parameters.var", "Hello ${parameters.var}!", "World", "Hello World!");
        fmaTest("UEL auto-vivify List", "parameters.someList[0]", "parameters.someList[+0]", "Hello ${parameters.someList[0]}!", null, "World", "Hello World!");
        fmaTest("fse", "para${'meter'}s.var", "Hello ${parameters.var}!", "World", "Hello World!");
        fmaTest("foo", "'The total is ${total?currency(USD)}.'", "total", "The total is ${total?currency(USD)}.", localeToTest, new  BigDecimal("12345678.90"), "The total is $12,345,678.90.");
        assertTrue("containsNestedExpression method returns true", FlexibleMapAccessor.getInstance("Hello ${parameters.var}!").containsNestedExpression());
        assertFalse("containsNestedExpression method returns false", FlexibleMapAccessor.getInstance("Hello World!").containsNestedExpression());
    }

    public static class ThrowException {

        public Object getValue() throws Exception {
            throw new  Exception();
        }

        public void setValue(Object value) throws Exception {
            throw new  Exception();
        }
    }

    @SuppressWarnings("serial")
    public static class CantRemoveMap<K, V> extends HashMap<K, V> {

        @Override
        public V get(Object key) {
            return super.get(key);
        }

        @Override
        public V put(K key, V value) {
            if (value == null) {
                throw new  IllegalArgumentException();
            }
            return super.put(key, value);
        }
    }

    public void testVerbosityAndErrors() {
        boolean isVerbose = Debug.isOn(Debug.VERBOSE);
        try {
            Debug.set(Debug.VERBOSE, true);
            Map<String, Object> testMap = new  CantRemoveMap<String, Object>();
            testMap.put("throwException", new  ThrowException());
            assertNull("no var", FlexibleMapAccessor.getInstance("var").get(testMap));
            Object result = FlexibleMapAccessor.getInstance("throwException.value").get(testMap);
            assertNull("get null var", result);
            FlexibleMapAccessor.getInstance("throwException.value").put(testMap, this);
            FlexibleMapAccessor.getInstance("throwException").remove(testMap);
            assertNotNull("not removed", testMap.get("throwException"));
        } finally {
            Debug.set(Debug.VERBOSE, isVerbose);
        }
    }
}

