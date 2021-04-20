prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_200200 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>14876153841056134
,p_default_application_id=>100
,p_default_id_offset=>0
,p_default_owner=>'CLOUDIFY_CONSULT'
);
end;
/
 
prompt APPLICATION 100 - SEND SMS PLUGIN - GHANA
--
-- Application Export:
--   Application:     100
--   Name:            SEND SMS PLUGIN - GHANA
--   Date and Time:   23:18 Tuesday April 20, 2021
--   Exported By:     CLOUDIFY_CONSULT
--   Flashback:       0
--   Export Type:     Component Export
--   Manifest
--     PLUGIN: 51379051657104272465
--   Manifest End
--   Version:         20.2.0.00.20
--   Instance ID:     9274545110561108
--

begin
  -- replace components
  wwv_flow_api.g_mode := 'REPLACE';
end;
/
prompt --application/shared_components/plugins/process_type/send_sms_ghana_plugin_arkesel
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(51379051657104272465)
,p_plugin_type=>'PROCESS TYPE'
,p_name=>'SEND_SMS_GHANA_PLUGIN_ARKESEL'
,p_display_name=>'SEND_SMS_GHANA'
,p_supported_ui_types=>'DESKTOP'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_PROC:APEX_APPL_AUTOMATION_ACTIONS'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'-- =============================================================================',
'--',
'--  Author: ASAMOAH RICHMOND - richmond@cloudifyhub.com - cloudifyhub.com',
'--  Date: 20.04.2021',
'--  This plug-in lets users send sms to Ghana Contacts Only. V1',
'--  ',
'--',
'--  ',
'--',
'--  ',
'--',
'-- =============================================================================',
'',
'function send_sms',
'  ( p_process in apex_plugin.t_process',
'  , p_plugin   in apex_plugin.t_plugin',
'  )',
'return apex_plugin.t_process_exec_result ',
'as',
'    l_result                 apex_plugin.t_process_exec_result;',
'',
'    -- general attributes',
'   l_api_key         p_process.attribute_01%type := p_process.attribute_01;',
'   l_contact             p_process.attribute_02%type := p_process.attribute_02;',
'   l_message         p_process.attribute_03%type := p_process.attribute_03;',
'   l_sender_id               p_process.attribute_04%type := p_process.attribute_04;',
' ',
' ',
'',
'   l_response_clob   CLOB;',
'   l_clob CLOB;',
'   l_msg varchar2(100);',
'   l_code varchar2(100);',
'   l_balance NUMBER;',
'   ',
'   ',
'   ',
'',
'BEGIN',
'',
'if l_contact is null then',
'',
'        ',
'  l_result.success_message:=''CONTACT CANNOT BE EMPTY'';',
'  RETURN l_result;',
'',
'ELSIF l_sender_id is null then',
'',
'     l_result.success_message:=''SENDER ID CANNOT BE NULL'';',
'  RETURN l_result;',
'  ',
'END IF;',
'',
'        l_clob := apex_web_service.make_rest_request(',
'        p_url => ''https://sms.arkesel.com/sms/api?action=send-sms&api_key=''||l_api_key||''&to=''||l_contact||''&from=''||l_sender_id||''&sms=''||l_message||'''',',
'        p_http_method => ''GET'');',
'',
'        SELECT JSON_VALUE (l_clob, ''$.message'')',
'        INTO l_msg',
'        FROM DUAL;',
'',
'        SELECT JSON_VALUE (l_clob, ''$.code'')',
'        INTO l_code',
'        FROM DUAL;',
'',
'        SELECT JSON_VALUE (l_clob, ''$.balance'')',
'        INTO l_balance',
'        FROM DUAL;',
'   ',
' if l_code = ''ok'' then',
' ',
'  l_result.success_message:=''Balance ''||l_balance||'' - ''||l_msg;',
'',
'  RETURN l_result;',
'  else',
'  l_result.success_message:=l_msg;',
'',
'  RETURN l_result;',
'  END IF;',
'    ',
'        EXCEPTION',
'        when others then',
'         l_result.success_message:=''ERROR WHILES SENDING SMS'';',
'',
'  RETURN l_result;',
' ',
'',
'end send_sms;'))
,p_api_version=>2
,p_execution_function=>'send_sms'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_version_identifier=>'1.0'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(51379132388611297702)
,p_plugin_id=>wwv_flow_api.id(51379051657104272465)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Api Key'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(51380593373274776770)
,p_plugin_id=>wwv_flow_api.id(51379051657104272465)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Contact'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_default_value=>'contact starts with 233'
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(51379257858855310578)
,p_plugin_id=>wwv_flow_api.id(51379051657104272465)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'Message'
,p_attribute_type=>'TEXTAREA'
,p_is_required=>false
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(51379195195732675206)
,p_plugin_id=>wwv_flow_api.id(51379051657104272465)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_prompt=>'Sender ID'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_is_translatable=>false
);
end;
/
prompt --application/end_environment
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false));
commit;
end;
/
set verify on feedback on define on
prompt  ...done
