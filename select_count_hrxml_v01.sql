SELECT 
	count(id) 
FROM salesforce.account 
WHERE 
	talent_hrxml__c != '' 
    AND SystemModstamp > '2016-01-01 00:00:01' 
    AND SystemModstamp < '2017-07-21 15:00:00' 
    AND RecordTypeId = '01224000000FFqQAAW' 
