SELECT 
	count(id) 
--    sfid, 
--    name, 
--    createddate, 
--    systemmodstamp, 
--    talent_hrxml_last_modified_date__c, 
--    isDeleted, 
--    talent_ownership__c, 
--    recordtypeid, 
--    Talent_HRXML__c, 
--    Talent_HRXML2__c, 
--    Talent_HRXML3__c 
FROM salesforce.account 
WHERE 
	talent_hrxml__c != '' 
    AND SystemModstamp > '2016-01-01 00:00:01' 
    AND SystemModstamp < '2017-07-21 15:00:00' 
    AND RecordTypeId = '01224000000FFqQAAW' 
-- ORDER BY SystemModstamp DESC