class ltcl_aunit_test definition final for testing
  duration short
  risk level harmless.

  private section.
    methods:
      package_without_errors_test for testing raising cx_static_check.
"      package_unknown_test for testing raising cx_static_check.

endclass.


class ltcl_aunit_test implementation.

  method package_without_errors_test.

    DATA(aunit_test) = new ZCL_AUNIT_TESTRUN( ).
    DATA(abap_ci_summary) = aunit_test->get_test_run_result( '$TMP' ).

    cl_aunit_assert=>assert_equals( EXP = `TESTRUN_OK`  ACT = abap_ci_summary-test_result  MSG = '' ).

  endmethod.

"  method package_unknown_test.

"    DATA(aunit_test) = new ZCL_AUNIT_TESTRUN( ).
"    DATA(abap_ci_summary) = aunit_test->get_test_run_result( 'UNKNOWN' ).
"
"    cl_aunit_assert=>assert_differs( EXP = `TESTRUN_OK`  ACT = abap_ci_summary-test_result  MSG = '' ).

"  endmethod.

endclass.
