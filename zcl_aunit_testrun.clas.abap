class zcl_aunit_testrun definition
  public
  final
  create public .

  public section.
    methods:
      main importing package_name         type string
           returning value(response_data) type if_aunit_adt_types=>ty_run_config_response,
      get_test_run_result importing package_name           type string
                          returning value(abap_ci_summary) type zst_abap_ci_summary.

  protected section.
  private section.
endclass.



class zcl_aunit_testrun implementation.

  method main.
    data(test_run) = new cl_aunit_adt_res_test_runs( ).
    data request_data type  if_aunit_adt_types=>ty_run_config_request.
    data object_sets  type if_adt_tools_core_types=>ty_object_sets.
    data object_set like line of object_sets.
    data object_reference type if_adt_tools_core_types=>ty_object_reference.
    object_reference-uri = `/sap/bc/adt/vit/wb/object_type/devck/object_name/` && package_name.


    append object_reference to object_set-object_references.
    append object_set to object_sets.
    request_data-object_sets = object_sets.
    request_data-object_sets[ 1 ]-kind = 'inclusive'.

    test_run->execute_tests( exporting request_data = request_data
                             importing response_data = response_data ).


  endmethod.

  method get_test_run_result.

    data(test_run_result) = main( package_name ).
    abap_ci_summary-package_name = package_name.
    "TODO Count test_run_results-programs-tests...
    "abap_ci_summary-num_success = lines( test_run_result-programs ).

    data(num_errors) = 0.

    num_errors = lines( test_run_result-alerts ).


    loop at test_run_result-programs assigning field-symbol(<program>).
        loop at <program>-test_classes assigning field-symbol(<test_class>).
           loop at <test_class>-test_methods  assigning field-symbol(<test_method>).
              num_errors = num_errors + lines( <test_method>-alerts ).
           endloop.
        endloop.
    endloop.
    abap_ci_summary-num_errors = num_errors.

    case abap_ci_summary-num_errors.
      when 0.
        abap_ci_summary-test_result = 'TESTRUN_OK'.
      when others.
        abap_ci_summary-test_result  = 'TESTRUN_FAILED'.
    endcase.
  endmethod.

endclass.
