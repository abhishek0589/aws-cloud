
fields @timestamp, @message
| filter @message like /(?i)error/
| sort @timestamp desc
| limit 10000


fields @timestamp, @message
| parse @message "[*] *" as loggingType, loggingMessage
| filter @loggingType = "ERROR"
| sort @timestamp desc
| limit 10000


2022-09-20 23:39:18.070 ERROR 73f9d048-62d5-4bf1-8014-c404b46fb4d5 --- [ main] c.l.p.s.i.m.MediaMapper : The following record has invalid columns: Thumb_Mobile, D75720005-alt1-Thumb_Mobile, NULL, null, null, null



fields @timestamp, @message
| filter @message like /(?i)error/
| sort @timestamp desc
| limit 10000


fields @timestamp, @message
| filter @message like /(?i)error/
| stats count(*) as exceptionCount by bin(1h)
| sort @timestamp desc
| limit 10000


fields @timestamp, @message
| filter @message like /Trying to consumer benefits for request BenefitConsumeRequest/
| filter @message like /16fa7268-14ba-461f-8b19-a48b8fb27d1e/
| PARSE @message "hybrisUserId='*', userPromoGroups=[*]" as hybrisUserId, userPromoGroups
| DISPLAY @timestamp, hybrisUserId, userPromoGroups
| sort @timestamp desc 


fields @timestamp, @message
| parse @message "* * * *" as ldate, ltime, llevel, lmessage
#| filter @lmessage like /(?i)error|unable|exception|fail/
#| stats count(*) as exceptionCount by bin(1h)
| sort @timestamp desc
| limit 10000




fields @timestamp, @message
| filter @message like /(?i)error|unable|exception|fail/
#| stats count(*) as exceptionCount by bin(1h)
| sort @timestamp desc
| limit 10000



2022-09-20 22:19:50.215 ERROR f6d81177-cd6e-4290-a5d3-d59c9910dc4f --- [           main] .p.s.i.m.BadgesAndGroupsMapper : Could not parse date. Unknown format: 05/02/2022 12:00:00 PST.





fields @timestamp, @message
#| filter @message like /(?i)Unknown format/
#| filter strcontains(@message, "Unknown format")
| parse @message "* * * *" as ldate, ltime, llevel, lmessage
| display llevel, lmessage
| filter llevel = "ERROR"
#| filter strcontains(@lmessage, "Unknown format")
#| stats count(*) as exceptionCount by bin(1h)
| sort @timestamp desc
| limit 10000



fields @timestamp, @message
#| filter @message like /(?i)Unknown format/
#| filter strcontains(@message, "Unknown format")
| parse @message "* * * * : *" as ldate, ltime, llevel, lclass, lcmessage
| display llevel, substr(lcmessage, 0, 30)
| filter llevel = "ERROR"
| filter lcmessage like /(?i)parse/
#| filter strcontains(@lmessage, "Unknown format")
#| stats count(*) as exceptionCount by bin(1h)
| sort @timestamp desc
| limit 10000



fields @timestamp, @message
| parse @message "* * * * : *" as ldate, ltime, llevel, lclass, lmessage
| display llevel, substr(lmessage, 0, 40) as error_message
| filter llevel = "ERROR"
| stats count(*) as error_count by error_message | sort error_count desc
| sort @timestamp desc
| limit 10000



fields @timestamp, @message
| filter @message like /(?i)error|(?i)exception|(?i)fail|(?i)unable|(?i)deny|(?i)denied|(?i)could not/
| display llevel, substr(lmessage, 0, 40) as error_message
| stats count(*) as error_count by error_message | sort error_count desc
| sort @timestamp desc
| limit 10000


fields @timestamp, @message
| parse @message "* * * * : *" as ldate, ltime, llevel, lclass, lcmessage
| display substr(lcmessage, 0, 35) as error_message
| filter llevel = "ERROR"
| stats count(*) as error_count by ldate, @logStream, error_message | sort error_count desc
| display ldate, error_message, error_count, @logStream
| sort @ldate desc
| limit 10000





fields @timestamp, @message | filter @message like /Trying to consumer benefits for request BenefitConsumeRequest/ | filter @message like /6a570eab-e564-436c-af35-2abb3eead601|50396cfd-5ad6-4e52-b14f-ea6f807186e6|f3b0b101-87bc-443b-80c4-88c8c4c9caad|bfe14c98-8a7c-4ece-9e54-deae37f418a0/ | PARSE @message "hybrisUserId='', userPromoGroups=[]" as hybrisUserId, userPromoGroups | DISPLAY @timestamp, hybrisUserId, userPromoGroups | sort @timestamp desc



fields @timestamp, @message | filter @message like /Trying to consumer benefits for request BenefitConsumeRequest/ | filter @message like /6a570eab-e564-436c-af35-2abb3eead601|50396cfd-5ad6-4e52-b14f-ea6f807186e6|f3b0b101-87bc-443b-80c4-88c8c4c9caad|bfe14c98-8a7c-4ece-9e54-deae37f418a0/ | PARSE @message "hybrisUserId='', userPromoGroups=[]" as hybrisUserId, userPromoGroups | DISPLAY @timestamp, hybrisUserId, userPromoGroups | sort @timestamp desc

filter @message like /NOT_FOUND/ | parse @message "Request source [*] :: Returning * response for *" as sourceApp, notFound, resource | fields strcontains(resource, "getbenefits for user") as @getBenefits, strcontains(resource, "fetching user promo groups") as @promoGroups, strcontains(resource, "finding Preferences for user") as @preferences | stats sum(@getBenefits) as getBenefitsCount, sum(@promoGroups) as promoGroupsCount, sum(@preferences) as preferencesCount by sourceApp

https://us-west-2.console.aws.amazon.com/cloudwatch/home?region=us-west-2#logsV2:logs-insights$3FqueryDetail$3D$257E$2528end$257E0$257Estart$257E-3600$257EtimeType$257E$2527RELATIVE$257Eunit$257E$2527seconds$257EeditorString$257E$2527fields*20*40timestamp*2c*20*40message*0a*7c*20sort*20*40timestamp*20desc*0a*7c*20limit*2020$257EisLiveTail$257Efalse$257EqueryId$257E$2527b26ee799-6d21-4c2e-9cc0-04bac56451f6$257Esource$257E$2528$257E$2527*2fecs*2finventory-acc-api*2fprod$2529$2529


fields @timestamp, @message | filter @message like /v1/ | sort @timestamp desc

fields @timestamp, @message | filter @message like /\/v1\/levi\/inventory\?countryCode/ | parse @message "countryCode=*&itemId=*&itemType=*&location=*&offset=*status=*bytes-sent=*duration=*" as country, item, type, location,offset, statys, bytes, duration | sort @timestamp desc





GATEWAY-

fields @timestamp, @message
| filter @message like /Verifying/
| parse @message "(*) * API Key: * *" as request_id, ltime, api_key, lmessage
| sort @timestamp desc
| stats count(*) as count by api_key, bin(1w)
| limit 10000



fields @timestamp, @message
| filter @message like /Verifying/
| parse @message "(*) * API Key: * *" as request_id, ltime, api_key, lmessage
| display substr(api_key, 34,6) as api_key_substr
| sort @timestamp desc
| stats count(*) as count by api_key_substr, bin(1d)
| limit 10000



fields @timestamp, @message
| parse @message "* Finished upserting * *" as lmessage, records, rmessage
| stats sum(records) by bin(1h)
| sort @timestamp desc
| limit 10000








Kafka Connect JDBC connector


fields @timestamp, @message
| filter @message like /About to send /
| parse @message "[* * About to send * *" as ldate, ltime, mcount, rm1
| display ldate, mcount
| stats sum(mcount) by bin(1h)
| sort @timestamp desc
| limit 10000
