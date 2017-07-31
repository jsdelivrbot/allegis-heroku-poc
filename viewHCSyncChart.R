hcsfdata = read.csv("/tmp/HC_SF_Event_Log_Result.csv");

hcsfdata$sf_timestamp = substr(hcsfdata$sf_timestamp,1,19);
hcsfdata$synced_at = substr(hcsfdata$synced_at,1,19);

dtAxis = strptime(hcsfdata$synced_at,"%Y-%m-%d %H:%M:%S", tz = "UTC");
# dtAxis = seq(length(hcsfdata$synced_at));

hcsfdata$sfdiff = as.numeric(difftime(hcsfdata$talent_hrxml_last_modified_date__c,hcsfdata$talent_profile_last_modified_date__c,tz="UTC",units="secs"));
hcsfdata$hcdiff = as.numeric(difftime(hcsfdata$synced_at,hcsfdata$sf_timestamp,tz="UTC",units="secs"));

par(mfrow=c(2,2))

max_ylim = 30;
numdiffbuckets = 10;

plot(dtAxis, hcsfdata$sfdiff, xaxt="n", type="h", col=rgb(0,0,1,1/2), 
     ylim=c(0,max_ylim), 
     main = "Heroku Connect Sync [by Time]", 
     ylab = "Seconds", 
     xlab = "UTC Time"
#     xlab = "Events"
     );

# now label every hour on the time axis
r <- as.POSIXct(round(range(dtAxis), "hours"))
axis.POSIXct(1, at = seq(r[1], r[2], by = "6 hours"), format = "%H")

# add day labels to axis
s <- as.POSIXct(round(range(dtAxis), "days"))
axis.POSIXct(1, at = seq(s[1], s[2], by = "days"), format = "%D")

# add line for Heroku Connect diff data to plot
lines(dtAxis, hcsfdata$hcdiff, type="h", col=rgb(1,0,0,1/2))

# Plot events, not by time
plot(rev(hcsfdata$sfdiff), type="l", col=rgb(0,0,1,1/2), ylim=c(0,max_ylim),
    main = "Heroku Connect Sync [by Event]", 
    ylab = "Seconds", 
    xlab = "Event"
);
lines(rev(hcsfdata$hcdiff), type="l", col=rgb(1,0,0,1/2));

# PLot histograms of HC and SF diff numbers
mindiff=min(min(hcsfdata$hcdiff),min(hcsfdata$sfdiff))
maxdiff=max(max(hcsfdata$hcdiff),max(hcsfdata$sfdiff))

hist(hcsfdata$hcdiff, numdiffbuckets, freq=FALSE, col="red")
hist(hcsfdata$sfdiff, numdiffbuckets, freq=FALSE, col="blue")
