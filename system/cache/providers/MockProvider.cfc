﻿<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldbox.org | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Author 	    :	Luis Majano
Description :
	A mock cache provider that keeps cache data in a simple map for testing 
	and assertions

----------------------------------------------------------------------->
<cfcomponent hint="A mock cache provider" 
			 output="false" 
			 implements="coldbox.system.cache.IColdboxApplicationCache"
			 extends="coldbox.system.cache.providers.AbstractCacheBoxProvider">
	
	<!--- init --->
    <cffunction name="init" output="false" access="public" returntype="any" hint="Simple Constructor">
    	<cfscript>
    		super.init();
			
			instance.cache = {};
			
			return this;
		</cfscript>
    </cffunction>

	<!--- configure --->
    <cffunction name="configure" output="false" access="public" returntype="void" hint="This method makes the cache ready to accept elements and run">
    	<cfscript>
    		instance.cache 	 = {};
			instance.enabled = true;
		</cfscript>
    </cffunction>
	
	<!--- shutdown --->
    <cffunction name="shutdown" output="false" access="public" returntype="void" hint="Shutdown command issued when CacheBox is going through shutdown phase">
    </cffunction>

<!------------------------------------------- CACHE OPERATIONS ------------------------------------------>

	<!--- getKeys --->
    <cffunction name="getKeys" output="false" access="public" returntype="array" hint="Returns a list of all elements in the cache, whether or not they are expired.">
   		<cfreturn structKeyList(instance.cache)>
    </cffunction>
	
	<!--- get --->
    <cffunction name="get" output="false" access="public" returntype="any" hint="Get an object from the cache and updates stats">
    	<cfargument name="objectKey" type="any" required="true" hint="The object key"/>
    	<cfreturn instance.cache[ arguments.objectKey ]>
	</cffunction>
	
	<!--- lookup --->
	<cffunction name="lookup" access="public" output="false" returntype="boolean" hint="Check if an object is in cache, if not found it records a miss.">
		<cfargument name="objectKey" type="any" required="true" hint="The key of the object to lookup.">
		<cfreturn structKeyExists(instance.cache, arguments.objectKey)>
	</cffunction>	
	
	<!--- lookup --->
	<cffunction name="lookupValue" access="public" output="false" returntype="boolean" hint="Check if an object is in cache, if not found it records a miss.">
		<cfargument name="objectValue" type="any" required="true" hint="The value of the object to lookup.">
		<cfreturn instance.cache.containsValue( arguments.objectValue )>
	</cffunction>	
	
	<!--- Set --->
	<cffunction name="set" access="public" output="false" returntype="boolean" hint="sets an object in cache.">
		<!--- ************************************************************* --->
		<cfargument name="objectKey" 	type="any"  required="true" hint="The object cache key">
		<cfargument name="object"		type="any" 	required="true" hint="The object to cache">
		<cfset instance.cache[ arguments.objectKey ] = arguments.object>
		<cfreturn true>
	</cffunction>
	
	<!--- getSize --->
    <cffunction name="getSize" output="false" access="public" returntype="numeric" hint="Get the number of elements in the cache">
    	<cfreturn structCount(instance.cache)>
    </cffunction>

	<!--- reap --->
    <cffunction name="reap" output="false" access="public" returntype="void" hint="Reap the caches for expired objects and expiries">
    </cffunction>

	<!--- clearAll --->
    <cffunction name="clearAll" output="false" access="public" returntype="void" hint="Clear all the cache elements from the cache">
    	<cfset instance.cache = {}>
    </cffunction>

	<!--- Clear Key --->
	<cffunction name="clearKey" access="public" output="false" returntype="boolean" hint="Clears an object from the cache by using its cache key. Returns false if object was not removed or did not exist anymore">
		<cfargument name="objectKey" type="string" required="true" hint="The key the object was stored under.">
		<cfreturn structDelete(instance.cache, arguments.objectKey, true)>
	</cffunction>
	
	<!--- expireAll --->
    <cffunction name="expireAll" output="false" access="public" returntype="void" hint="Expire all the elments in the cache">
    </cffunction>
	
	<!--- Expire Key --->
	<cffunction name="expireKey" access="public" output="false" returntype="boolean" hint="Expires an object from the cache by using its cache key. Returns false if object was not removed or did not exist anymore">
		<cfargument name="objectKey" type="string" required="true" hint="The key the object was stored under.">
	</cffunction>
	
<!------------------------------------------- ColdBox Application Cache Methods ------------------------------------------>

<!--- getViewCacheKeyPrefix --->
    <cffunction name="getViewCacheKeyPrefix" output="false" access="public" returntype="string" hint="Get the cached view key prefix">
    	<cfreturn "mock-">
    </cffunction>

	<!--- getEventCacheKeyPrefix --->
    <cffunction name="getEventCacheKeyPrefix" output="false" access="public" returntype="string" hint="Get the event cache key prefix">
    	<cfreturn "mock-">
    </cffunction>

	<!--- getHandlerCacheKeyPrefix --->
    <cffunction name="getHandlerCacheKeyPrefix" output="false" access="public" returntype="string" hint="Get the handler cache key prefix">
    	<cfreturn "mock-">
    </cffunction>

	<!--- getInterceptorCacheKeyPrefix --->
    <cffunction name="getInterceptorCacheKeyPrefix" output="false" access="public" returntype="string" hint="Get the interceptor cache key prefix">
    	<cfreturn "mock-">
    </cffunction>

	<!--- getPluginCacheKeyPrefix --->
    <cffunction name="getPluginCacheKeyPrefix" output="false" access="public" returntype="string" hint="Get the plugin cache key prefix">
    	<cfreturn "mock-">
    </cffunction>

	<!--- getCustomPluginCacheKeyPrefix --->
    <cffunction name="getCustomPluginCacheKeyPrefix" output="false" access="public" returntype="string" hint="Get the custom plugin cache key prefix">
   		<cfreturn "mock-">
    </cffunction>

	<!--- getColdbox --->
    <cffunction name="getColdbox" output="false" access="public" returntype="coldbox.system.web.Controller" hint="Get the coldbox application reference">
   		<cfreturn instance.coldbox>
    </cffunction>

	<!--- setColdbox --->
    <cffunction name="setColdbox" output="false" access="public" returntype="void" hint="Set the coldbox application reference">
    	<cfargument name="coldbox" type="coldbox.system.web.Controller" required="true" hint="The coldbox application reference"/>
    	<cfset instance.coldbox = arguments.coldbox>
	</cffunction>

	<!--- getEventURLFacade --->
    <cffunction name="getEventURLFacade" output="false" access="public" returntype="coldbox.system.cache.util.EventURLFacade" hint="Get the event caching URL facade utility">
    	<cfreturn instance.eventURLFacade>
    </cffunction>

	<!--- getItemTypes --->
	<cffunction name="getItemTypesCount" access="public" output="false" returntype="coldbox.system.cache.util.ItemTypeCount" hint="Get the item types counts of the cache. These are calculated according to the prefixes set.">
		<cfreturn createObject("component","coldbox.system.cache.util.ItemTypeCount")>
	</cffunction>
	
	<!--- Clear All the Events form the cache --->
	<cffunction name="clearAllEvents" access="public" output="false" returntype="void" hint="Clears all events from the cache.">
	</cffunction>
	
	<!--- Clear an event --->
	<cffunction name="clearEvent" access="public" output="false" returntype="void" hint="Clears all the event permutations from the cache according to snippet and querystring. Be careful when using incomplete event name with query strings as partial event names are not guaranteed to match with query string permutations">
		<!--- ************************************************************* --->
		<cfargument name="eventsnippet" type="string" 	required="true"  hint="The event snippet to clear on. Can be partial or full">
		<cfargument name="queryString" 	type="string" 	required="false" default="" hint="If passed in, it will create a unique hash out of it. For purging purposes"/>
		<!--- ************************************************************* --->
	</cffunction>
	
	<!--- clear View --->
	<cffunction name="clearView" output="false" access="public" returntype="void" hint="Clears all view name permutations from the cache according to the view name.">
		<!--- ************************************************************* --->
		<cfargument name="viewSnippet"  required="true" type="string" hint="The view name snippet to purge from the cache">
		<!--- ************************************************************* --->
	</cffunction>

	<!--- Clear All The Views from the Cache. --->
	<cffunction name="clearAllViews" access="public" output="false" returntype="void" hint="Clears all views from the cache.">
	</cffunction>
	
</cfcomponent>