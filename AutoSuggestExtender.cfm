<cfsilent><!---
LICENSE INFORMATION:
====================

Copyright 2008, Dominic Watson
 
Licensed under the Apache License, Version 2.0 (the "License"); you may not 
use this file except in compliance with the License. 

You may obtain a copy of the License at 

	http://www.apache.org/licenses/LICENSE-2.0 
	
Unless required by applicable law or agreed to in writing, software distributed
under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR 
CONDITIONS OF ANY KIND, either express or implied. See the License for the 
specific language governing permissions and limitations under the License.

USAGE:
======

This custom tag can be used in place of a cfinput tag and will accept all the attributes of the cfinput tag.
Additionally, this tag also takes the following arguments for controlling the behaviour of the autosuggest widget:

	* delimChar (default="") - Allows a list of values to be built up in the text box
	* typeAhead (default="false") - If true, the first selection will automatically appear in the text box
	* forceSelection - If true, forces the input to match one of the items in the autosuggest list
	* maxResultsDisplayed (default="10") - Maximum number of auto-suggestions to show
	* useShadow (default="true") - Whether or not to show a drop shadow on the suggestion list
	* prehighlightClassName - css classname for the preselected item in the suggestion list
	* highlightClassName - css classname for the mouseover selected item in the suggestion list
	* autoHighlight - Whether or not to automatically highlight the first suggestion
	* animVert - Whether or not to animate the appearance of the suggestion list vertically
	* animHoriz - Whether or not to animate the appearance of the suggestion list horizontally
	* animSpeed - Speed of animation
	* queryMatchContains (default = "false") - If true, suggestion list will contain strings that *contain* the search string. If false, the results will all *start* with the search string.  
	* queryMatchSubset (default = "false") - If true, suggestion list will contain strings that are contained within the search string
	* queryMatchCase (default = "false") - If true, suggestion matching is case sensitive

BUG REPORTS & FEEDBACK:
=======================

Please feedback and report bugs on riaforge:

	http://betterautosuggest.riaforge.org/
	
Or leave a comment on my blog:

	http://fusion.dominicwatson.co.uk/2008/04/better-autosuggesting-widget.html

--->
</cfsilent>
<!--- Only run in start mode --->
<cfif thisTag.ExecutionMode EQ 'Start'>
	<cfsilent>
	<!--- BetterAutoSuggest attributes --->
		<cfparam name="attributes.delimChar" default="">
		<cfparam name="attributes.typeAhead" default="false">
		<cfparam name="attributes.maxResultsDisplayed" default="10">
		<cfparam name="attributes.useShadow" default="true">
		<cfparam name="attributes.prehighlightClassName" default="yui-ac-prehighlight">
		<cfparam name="attributes.highlightClassName" default="yui-ac-highlight">
		<cfparam name="attributes.forceSelection" default="false">
		<cfparam name="attributes.autoHighlight" default="true">
		<cfparam name="attributes.animVert" default="true">
		<cfparam name="attributes.animHoriz" default="false">
		<cfparam name="attributes.animSpeed" default="0.3">
		<cfparam name="attributes.onfocus" default="">
		<cfparam name="attributes.queryMatchContains" default="false">
		<cfparam name="attributes.queryMatchSubset" default="false">
		<cfparam name="attributes.queryMatchCase" default="false">	
		
	<!--- validation --->
		<cfif not IsSimpleValue(attributes.delimChar) or Len(attributes.delimChar) GT 1>
			<cfthrow message="The delimiter passed to the betterAutoSuggest tag is invalid. At this time, a maximum of one delimiter character is supported." type="BetterAutoSuggest">
			
		<cfelseif not IsBoolean(attributes.typeAhead)>
			<cfthrow message="Invalid value for typeAhead attribute. Expected: boolean" type="BetterAutoSuggest">
		
		<cfelseif not IsBoolean(attributes.useShadow)>
			<cfthrow message="Invalid value for useShadow attribute. Expected: boolean" type="BetterAutoSuggest">
	
		<cfelseif not IsBoolean(attributes.forceSelection)>
			<cfthrow message="Invalid value for forceSelection attribute. Expected: boolean" type="BetterAutoSuggest">
		
		<cfelseif not IsBoolean(attributes.autoHighlight)>
			<cfthrow message="Invalid value for autoHighlight attribute. Expected: boolean" type="BetterAutoSuggest">
		
		<cfelseif not IsBoolean(attributes.animVert)>
			<cfthrow message="Invalid value for animVert attribute. Expected: boolean" type="BetterAutoSuggest">
		
		<cfelseif not IsBoolean(attributes.animHoriz)>
			<cfthrow message="Invalid value for animHoriz attribute. Expected: boolean" type="BetterAutoSuggest">
	
		<cfelseif not IsBoolean(attributes.queryMatchContains)>
			<cfthrow message="Invalid value for queryMatchContains attribute. Expected: boolean" type="BetterAutoSuggest">
		
		<cfelseif not IsBoolean(attributes.queryMatchContains)>
			<cfthrow message="Invalid value for queryMatchContains attribute. Expected: boolean" type="BetterAutoSuggest">
		
		<cfelseif not IsBoolean(attributes.queryMatchCase)>
			<cfthrow message="Invalid value for queryMatchCase attribute. Expected: boolean" type="BetterAutoSuggest">
		
		<cfelseif not IsNumeric(attributes.maxResultsDisplayed)>
			<cfthrow message="Invalid value for maxResultsDisplayed attribute. Expected: number" type="BetterAutoSuggest">
	
		<cfelseif not IsNumeric(attributes.animSpeed) or attributes.animSpeed LTE 0>
			<cfthrow message="Invalid value for maxResults attribute. Expected: number greater than zero" type="BetterAutoSuggest">
			
		<cfelseif not IsSimpleValue(attributes.prehighlightClassName)>
			<cfthrow message="Invalid value for prehighlightClassName attribute. Expected: string" type="BetterAutoSuggest">
	
		<cfelseif not IsSimpleValue(attributes.highlightClassName)>
			<cfthrow message="Invalid value for highlightClassName attribute. Expected: string" type="BetterAutoSuggest">
		
		<cfelseif not IsDefined('attributes.name')>
			<cfthrow message="'Name' attribute required" type="BetterAutoSuggest">	
		</cfif>
	</cfsilent>

<!--- output the javascript function --->
	<cfoutput>
		<script type="text/javascript">
			addAutoSuggestFunctionality#attributes.name# = function(autoId){
				if(ColdFusion.objectCache[autoId]){
					var autoObj = ColdFusion.objectCache[autoId];
					
					<cfif len(trim(attributes.delimChar))>
						autoObj.delimChar = '#attributes.delimChar#';
					</cfif>	
					autoObj.typeAhead = #attributes.typeAhead#;
					autoObj.maxResultsDisplayed = #attributes.maxResultsDisplayed#;
					autoObj.useShadow = #attributes.useShadow#;
					autoObj.prehighlightClassName = '#attributes.prehighlightClassName#';
					autoObj.highlightClassName = '#attributes.highlightClassName#';
					autoObj.forceSelection = #attributes.forceSelection#;
					autoObj.autoHighlight = #attributes.autoHighlight#;
					autoObj.animVert = #attributes.animVert#;
					autoObj.animHoriz = #attributes.animHoriz#;
					autoObj.animSpeed = #NumberFormat(attributes.animSpeed,'0.0')#;
					
					if(autoObj.dataSource){
						autoObj.dataSource.queryMatchContains = #attributes.queryMatchContains#;
						autoObj.dataSource.queryMatchSubset = #attributes.queryMatchSubset#;
						autoObj.dataSource.queryMatchCase = #attributes.queryMatchCase#;
					}
				}
				
				// ensures this code only gets executed once:
				document.getElementById(autoId).onfocus = '#attributes.onfocus#';
			}
		</script>
	</cfoutput>
	
	<!--- output the cfinput --->	
	<cfsilent>
		<cfset variables.cfinputArgs = StructNew()>
		<cfset variables.ignoreArgs = "delimiter,alwaysShowList,typeAhead,useShadow,maxResults,showloadingicon,prehighlightClass,highlightClass,forceSelection,autoHighlight,animVert,animHoriz,animSpeed,alwaysShowContainer">
		
		<cfloop collection="#attributes#" item="variables.attribute">
			<cfif not ListFindNoCase(variables.ignoreArgs, variables.attribute)>
				<cfset variables.cfinputArgs[variables.attribute] = attributes[variables.attribute]>
			</cfif>
		</cfloop>
		<cfset variables.cfinputArgs.onfocus = ListAppend(variables.cfinputArgs.onfocus, 'addAutoSuggestFunctionality#attributes.name#(this.id)', ';')>
	</cfsilent>
	<cfinput attributeCollection="#variables.cfinputArgs#">
</cfif>