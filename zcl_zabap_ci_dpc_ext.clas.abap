class zcl_zabap_ci_dpc_ext definition
  public
  inheriting from zcl_zabap_ci_dpc
  create public .

public section.
methods /iwbep/if_mgw_appl_srv_runtime~get_entity
         redefinition .

protected section.
private section.
endclass.



class zcl_zabap_ci_dpc_ext implementation.

method /iwbep/if_mgw_appl_srv_runtime~get_entity.

    data:  abapcisummaryentity type zst_abap_ci_summary.

       data:
          ordernumber type vbeln.

    read table it_key_tab into data(ls_key_tab) with key name = 'PackageName'.

    data(aunit_testrun) = new zcl_aunit_testrun( ).
    abapcisummaryentity  = aunit_testrun->get_test_run_result( exporting package_name = ls_key_tab-value ).

    copy_data_to_ref(
              exporting
                is_data = abapcisummaryentity
              changing
                cr_data = er_entity    ).
  endmethod.
endclass.
