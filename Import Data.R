
setwd("C:\\Users\\dludwin\\OneDrive\\Docs\\Research\\Exchanges\\") 

#Sample of every table
write.csv(Benefits_Cost_Sharing_PUF[sample(nrow(Benefits_Cost_Sharing_PUF), 1500), ],"PUF\\Benefits_Cost_Sharing.csv", row.names = TRUE)
write.csv(Business_Rules_PUF[sample(nrow(Business_Rules_PUF), 500), ],"PUF\\Business_Rules.csv", row.names = TRUE)
write.csv(Network_PUF[sample(nrow(Network_PUF), 500), ],"PUF\\Network.csv", row.names = TRUE)
write.csv(Plan_Attributes_PUF[sample(nrow(Plan_Attributes_PUF), 1000), ],"PUF\\Plan_Attributes20.csv", row.names = TRUE)
write.csv(Plan_ID_Crosswalk_PUF[sample(nrow(Plan_ID_Crosswalk_PUF), 1500), ],"PUF\\Plan_ID_Crosswalk.csv", row.names = TRUE)
write.csv(Rate_PUF[sample(nrow(Rate_PUF), 1500), ],"PUF\\Rate_PUF.csv", row.names = TRUE)
write.csv(Service_Area_PUF[sample(nrow(Service_Area_PUF), 1500), ],"PUF\\Service_Area.csv", row.names = TRUE)



#Attributes had a bunch of different number of vars
write.csv(Plan_Attributes21[sample(nrow(Plan_Attributes21), 1000), ],"PUF\\Plan_Attributes21.csv", row.names = TRUE)
write.csv(Plan_Attributes20[sample(nrow(Plan_Attributes20), 1000), ],"PUF\\Plan_Attributes20.csv", row.names = TRUE)
write.csv(Plan_Attributes15[sample(nrow(Plan_Attributes15), 1000), ],"PUF\\Plan_Attributes15.csv", row.names = TRUE)
write.csv(Plan_Attributes16[sample(nrow(Plan_Attributes16), 1000), ],"PUF\\Plan_Attributes16.csv", row.names = TRUE)

write.csv(Plan_Attributes15[sample(nrow(Plan_Attributes15), 100), ],"PUF\\Plan_Attributes15b.csv", row.names = TRUE)
write.csv(Plan_Attributes[sample(nrow(Plan_Attributes), 100), ],"PUF\\Plan_Attributes.csv", row.names = TRUE)



write.csv(Service_Area15[sample(nrow(Service_Area15), 100), ],"PUF\\Service_Area15.csv", row.names = TRUE)


# Service Area
Service_Area21<-read.csv("PUF/2021/Service_Area_PUF.csv")
Service_Area20<-read.csv("PUF/2020/Service_Area_PUF.csv")
Service_Area19<-read.csv("PUF/2019/Service_Area_PUF.csv")
Service_Area18<-read.csv("PUF/2018/Service_Area_PUF.csv")
Service_Area17<-read.csv("PUF/2017/Service_Area_PUF.csv")
Service_Area16<-read.csv("PUF/2016/Service_Area_PUF.csv")
Service_Area15<-read.csv("PUF/2015/Service_Area_PUF.csv")
Service_Area14<-read.csv("PUF/2014/Service_Area_PUF.csv")


Service_Area<-rbind(Service_Area21,Service_Area20)
Service_Area<-rbind(Service_Area,Service_Area19)
Service_Area<-rbind(Service_Area,Service_Area18)
Service_Area<-rbind(Service_Area,Service_Area17)

Service_Area$VersionNum<-0
Service_Area$IssuerId2<-0
Service_Area$StateCode2<- ""
Service_Area$RowNumber<-0

Service_Area<-rbind(Service_Area,Service_Area16)

#rename unmatching column
names(Service_Area15)[names(Service_Area15) == 'DentalOnly'] <- 'DentalOnlyPlan'
names(Service_Area14)[names(Service_Area14) == 'DentalOnly'] <- 'DentalOnlyPlan'

Service_Area<-rbind(Service_Area,Service_Area15)
Service_Area<-rbind(Service_Area,Service_Area14)

rm(Service_Area14)
rm(Service_Area15)
rm(Service_Area16)
rm(Service_Area17)
rm(Service_Area18)
rm(Service_Area19)
rm(Service_Area20)
rm(Service_Area21)


#Some service areas are the entire state. Expand
SA_ExpandState<-sqldf('SELECT sa.*, fp.FIPS
                      FROM Service_Area sa
                      INNER JOIN StateFIPS fp
                        on sa.StateCode = fp.StateAbbr
                      WHERE sa.CoverEntireState = "Yes"
                      ')

SA_ExpandState$County<-SA_ExpandState$FIPS

SA_ExpandState = subset(SA_ExpandState, select = -c(FIPS) )

Service_Area_ex<-rbind(SA_ExpandState, Service_Area[Service_Area$CoverEntireState != "Yes", ])






# Rate
Rate<-read.csv("PUF/2021/Rate_PUF.csv")
Rate20<-read.csv("PUF/2020/Rate_PUF.csv")
Rate19<-read.csv("PUF/2019/Rate_PUF.csv")
Rate18<-read.csv("PUF/2018/Rate_PUF.csv")
Rate17<-read.csv("PUF/2017/Rate_PUF.csv")
Rate16<-read.csv("PUF/2016/Rate_PUF.csv")
Rate15<-read.csv("PUF/2015/Rate_PUF.csv")
Rate14<-read.csv("PUF/2014/Rate_PUF.csv")


Rate18$VersionNum<-0
Rate18$IssuerId2<-0
Rate18$RowNumber<-0

Rate17$VersionNum<-0
Rate17$IssuerId2<-0
Rate17$RowNumber<-0


Rate<-rbind(Rate,Rate20)
Rate<-rbind(Rate,Rate19)
Rate<-rbind(Rate,Rate18)
Rate<-rbind(Rate,Rate17)
Rate<-rbind(Rate,Rate16)
Rate<-rbind(Rate,Rate15)
Rate<-rbind(Rate,Rate14)


rm(Rate17)
rm(Rate18)

save(Rate, file = "Rate.RData")
#load("Rate.rdata")

# Plan_Attributes

Plan_Attributes21<-read.csv("PUF/2021/Plan_Attributes_PUF.csv")
Plan_Attributes20<-read.csv("PUF/2020/Plan_Attributes_PUF.csv")
Plan_Attributes19<-read.csv("PUF/2019/Plan_Attributes_PUF.csv")
Plan_Attributes18<-read.csv("PUF/2018/Plan_Attributes_PUF.csv")
Plan_Attributes17<-read.csv("PUF/2017/Plan_Attributes_PUF.csv")
Plan_Attributes16<-read.csv("PUF/2016/Plan_Attributes_PUF.csv")
Plan_Attributes15<-read.csv("PUF/2015/Plan_Attributes_PUF.csv")
Plan_Attributes14<-read.csv("PUF/2014/Plan_Attributes_PUF.csv")


names(Plan_Attributes21)[names(Plan_Attributes21) == 'PlanEffictiveDate'] <- 'PlanEffectiveDate'
names(Plan_Attributes20)[names(Plan_Attributes20) == 'PlanEffictiveDate'] <- 'PlanEffectiveDate'
names(Plan_Attributes19)[names(Plan_Attributes19) == 'PlanEffictiveDate'] <- 'PlanEffectiveDate'
names(Plan_Attributes18)[names(Plan_Attributes18) == 'PlanEffictiveDate'] <- 'PlanEffectiveDate'
names(Plan_Attributes17)[names(Plan_Attributes17) == 'PlanEffictiveDate'] <- 'PlanEffectiveDate'
names(Plan_Attributes16)[names(Plan_Attributes16) == 'PlanEffictiveDate'] <- 'PlanEffectiveDate'
names(Plan_Attributes15)[names(Plan_Attributes15) == 'PlanEffictiveDate'] <- 'PlanEffectiveDate'
names(Plan_Attributes14)[names(Plan_Attributes14) == 'PlanEffictiveDate'] <- 'PlanEffectiveDate'


#21
Plan_Attributes21$TIN<-""
Plan_Attributes21$HPID<-""
Plan_Attributes21$DesignType<-""

#20
Plan_Attributes20$IssuerMarketPlaceMarketingName<-""


Plan_Attributes<-rbind(Plan_Attributes21,Plan_Attributes20)

#19
Plan_Attributes19$IssuerMarketPlaceMarketingName<-""

Plan_Attributes<-rbind(Plan_Attributes,Plan_Attributes19)

#18
Plan_Attributes18$IssuerMarketPlaceMarketingName<-""

Plan_Attributes<-rbind(Plan_Attributes,Plan_Attributes18)

#17
Plan_Attributes17$IssuerMarketPlaceMarketingName<-""
Plan_Attributes17$DesignType<-""

Plan_Attributes<-rbind(Plan_Attributes,Plan_Attributes17)

#16
Plan_Attributes16$IssuerMarketPlaceMarketingName<-""
Plan_Attributes16$DesignType<-""
Plan_Attributes16$PlanVariantMarketingName<-""
Plan_Attributes16$SBCHavingSimplefractureDeductible<-""
Plan_Attributes16$SBCHavingSimplefractureCopayment<-""
Plan_Attributes16$SBCHavingSimplefractureCoinsurance<-""
Plan_Attributes16$SBCHavingSimplefractureLimit<-""



Plan_Attributes$BenefitPackageId<-0
Plan_Attributes$IssuerId2<-""
Plan_Attributes$StateCode2<-""
Plan_Attributes$VersionNum<-0
Plan_Attributes$RowNumber<-0

Plan_Attributes<-rbind(Plan_Attributes,Plan_Attributes16)

#15
Plan_Attributes$EHBPercentPremiumS4<-""
Plan_Attributes$MEHBInnTier1FamilyMOOP<-""
Plan_Attributes$MEHBInnTier2FamilyMOOP<-""
Plan_Attributes$MEHBOutOfNetFamilyMOOP<-""
Plan_Attributes$MEHBCombInnOonFamilyMOOP<-""
Plan_Attributes$DEHBInnTier1FamilyMOOP<-""
Plan_Attributes$DEHBInnTier2FamilyMOOP<-""
Plan_Attributes$DEHBOutOfNetFamilyMOOP<-""
Plan_Attributes$DEHBCombInnOonFamilyMOOP<-""
Plan_Attributes$TEHBInnTier1FamilyMOOP<-""
Plan_Attributes$TEHBInnTier2FamilyMOOP<-""
Plan_Attributes$TEHBOutOfNetFamilyMOOP<-""
Plan_Attributes$TEHBCombInnOonFamilyMOOP<-""
Plan_Attributes$MEHBDedInnTier1Family<-""
Plan_Attributes$MEHBDedInnTier2Family<-""
Plan_Attributes$MEHBDedOutOfNetFamily<-""
Plan_Attributes$MEHBDedCombInnOonFamily<-""
Plan_Attributes$DEHBDedInnTier1Family<-""
Plan_Attributes$DEHBDedInnTier2Family<-""
Plan_Attributes$DEHBDedOutOfNetFamily<-""
Plan_Attributes$DEHBDedCombInnOonFamily<-""
Plan_Attributes$TEHBDedInnTier1Family<-""
Plan_Attributes$TEHBDedInnTier2Family<-""
Plan_Attributes$TEHBDedOutOfNetFamily<-""
Plan_Attributes$TEHBDedCombInnOonFamily<-""





Plan_Attributes15$CompositeRatingOffered<-""
Plan_Attributes15$EHBPercentTotalPremium<-""
Plan_Attributes15$MEHBInnTier1FamilyPerPersonMOOP<-""
Plan_Attributes15$MEHBInnTier1FamilyPerGroupMOOP<-""
Plan_Attributes15$MEHBInnTier2FamilyPerPersonMOOP<-""
Plan_Attributes15$MEHBInnTier2FamilyPerGroupMOOP<-""
Plan_Attributes15$MEHBOutOfNetFamilyPerPersonMOOP<-""
Plan_Attributes15$MEHBOutOfNetFamilyPerGroupMOOP<-""
Plan_Attributes15$MEHBCombInnOonFamilyPerPersonMOOP<-""
Plan_Attributes15$MEHBCombInnOonFamilyPerGroupMOOP<-""
Plan_Attributes15$DEHBInnTier1FamilyPerPersonMOOP<-""
Plan_Attributes15$DEHBInnTier1FamilyPerGroupMOOP<-""
Plan_Attributes15$DEHBInnTier2FamilyPerPersonMOOP<-""
Plan_Attributes15$DEHBInnTier2FamilyPerGroupMOOP<-""
Plan_Attributes15$DEHBOutOfNetFamilyPerPersonMOOP<-""
Plan_Attributes15$DEHBOutOfNetFamilyPerGroupMOOP<-""
Plan_Attributes15$DEHBCombInnOonFamilyPerPersonMOOP<-""
Plan_Attributes15$DEHBCombInnOonFamilyPerGroupMOOP<-""
Plan_Attributes15$TEHBInnTier1FamilyPerPersonMOOP<-""
Plan_Attributes15$TEHBInnTier1FamilyPerGroupMOOP<-""
Plan_Attributes15$TEHBInnTier2FamilyPerPersonMOOP<-""
Plan_Attributes15$TEHBInnTier2FamilyPerGroupMOOP<-""
Plan_Attributes15$TEHBOutOfNetFamilyPerPersonMOOP<-""
Plan_Attributes15$TEHBOutOfNetFamilyPerGroupMOOP<-""
Plan_Attributes15$TEHBCombInnOonFamilyPerPersonMOOP<-""
Plan_Attributes15$TEHBCombInnOonFamilyPerGroupMOOP<-""
Plan_Attributes15$MEHBDedInnTier1FamilyPerPerson<-""
Plan_Attributes15$MEHBDedInnTier1FamilyPerGroup<-""
Plan_Attributes15$MEHBDedInnTier2FamilyPerPerson<-""
Plan_Attributes15$MEHBDedInnTier2FamilyPerGroup<-""
Plan_Attributes15$MEHBDedOutOfNetFamilyPerPerson<-""
Plan_Attributes15$MEHBDedOutOfNetFamilyPerGroup<-""
Plan_Attributes15$MEHBDedCombInnOonFamilyPerPerson<-""
Plan_Attributes15$MEHBDedCombInnOonFamilyPerGroup<-""
Plan_Attributes15$DEHBDedInnTier1FamilyPerPerson<-""
Plan_Attributes15$DEHBDedInnTier1FamilyPerGroup<-""
Plan_Attributes15$DEHBDedInnTier2FamilyPerPerson<-""
Plan_Attributes15$DEHBDedInnTier2FamilyPerGroup<-""
Plan_Attributes15$DEHBDedOutOfNetFamilyPerPerson<-""
Plan_Attributes15$DEHBDedOutOfNetFamilyPerGroup<-""
Plan_Attributes15$DEHBDedCombInnOonFamilyPerPerson<-""
Plan_Attributes15$DEHBDedCombInnOonFamilyPerGroup<-""
Plan_Attributes15$TEHBDedInnTier1FamilyPerPerson<-""
Plan_Attributes15$TEHBDedInnTier1FamilyPerGroup<-""
Plan_Attributes15$TEHBDedInnTier2FamilyPerPerson<-""
Plan_Attributes15$TEHBDedInnTier2FamilyPerGroup<-""
Plan_Attributes15$TEHBDedOutOfNetFamilyPerPerson<-""
Plan_Attributes15$TEHBDedOutOfNetFamilyPerGroup<-""
Plan_Attributes15$TEHBDedCombInnOonFamilyPerPerson<-""
Plan_Attributes15$TEHBDedCombInnOonFamilyPerGroup<-""
Plan_Attributes15$PlanVariantMarketingName<-""
Plan_Attributes15$SBCHavingSimplefractureDeductible<-""
Plan_Attributes15$SBCHavingSimplefractureCopayment<-""
Plan_Attributes15$SBCHavingSimplefractureCoinsurance<-""
Plan_Attributes15$SBCHavingSimplefractureLimit<-""
Plan_Attributes15$DesignType<-""
Plan_Attributes15$IssuerMarketPlaceMarketingName<-""


Plan_Attributes<-rbind(Plan_Attributes,Plan_Attributes15)



Plan_Attributes14$CompositeRatingOffered<-""
Plan_Attributes14$EHBPercentTotalPremium<-""
Plan_Attributes14$MEHBInnTier1FamilyPerPersonMOOP<-""
Plan_Attributes14$MEHBInnTier1FamilyPerGroupMOOP<-""
Plan_Attributes14$MEHBInnTier2FamilyPerPersonMOOP<-""
Plan_Attributes14$MEHBInnTier2FamilyPerGroupMOOP<-""
Plan_Attributes14$MEHBOutOfNetFamilyPerPersonMOOP<-""
Plan_Attributes14$MEHBOutOfNetFamilyPerGroupMOOP<-""
Plan_Attributes14$MEHBCombInnOonFamilyPerPersonMOOP<-""
Plan_Attributes14$MEHBCombInnOonFamilyPerGroupMOOP<-""
Plan_Attributes14$DEHBInnTier1FamilyPerPersonMOOP<-""
Plan_Attributes14$DEHBInnTier1FamilyPerGroupMOOP<-""
Plan_Attributes14$DEHBInnTier2FamilyPerPersonMOOP<-""
Plan_Attributes14$DEHBInnTier2FamilyPerGroupMOOP<-""
Plan_Attributes14$DEHBOutOfNetFamilyPerPersonMOOP<-""
Plan_Attributes14$DEHBOutOfNetFamilyPerGroupMOOP<-""
Plan_Attributes14$DEHBCombInnOonFamilyPerPersonMOOP<-""
Plan_Attributes14$DEHBCombInnOonFamilyPerGroupMOOP<-""
Plan_Attributes14$TEHBInnTier1FamilyPerPersonMOOP<-""
Plan_Attributes14$TEHBInnTier1FamilyPerGroupMOOP<-""
Plan_Attributes14$TEHBInnTier2FamilyPerPersonMOOP<-""
Plan_Attributes14$TEHBInnTier2FamilyPerGroupMOOP<-""
Plan_Attributes14$TEHBOutOfNetFamilyPerPersonMOOP<-""
Plan_Attributes14$TEHBOutOfNetFamilyPerGroupMOOP<-""
Plan_Attributes14$TEHBCombInnOonFamilyPerPersonMOOP<-""
Plan_Attributes14$TEHBCombInnOonFamilyPerGroupMOOP<-""
Plan_Attributes14$MEHBDedInnTier1FamilyPerPerson<-""
Plan_Attributes14$MEHBDedInnTier1FamilyPerGroup<-""
Plan_Attributes14$MEHBDedInnTier2FamilyPerPerson<-""
Plan_Attributes14$MEHBDedInnTier2FamilyPerGroup<-""
Plan_Attributes14$MEHBDedOutOfNetFamilyPerPerson<-""
Plan_Attributes14$MEHBDedOutOfNetFamilyPerGroup<-""
Plan_Attributes14$MEHBDedCombInnOonFamilyPerPerson<-""
Plan_Attributes14$MEHBDedCombInnOonFamilyPerGroup<-""
Plan_Attributes14$DEHBDedInnTier1FamilyPerPerson<-""
Plan_Attributes14$DEHBDedInnTier1FamilyPerGroup<-""
Plan_Attributes14$DEHBDedInnTier2FamilyPerPerson<-""
Plan_Attributes14$DEHBDedInnTier2FamilyPerGroup<-""
Plan_Attributes14$DEHBDedOutOfNetFamilyPerPerson<-""
Plan_Attributes14$DEHBDedOutOfNetFamilyPerGroup<-""
Plan_Attributes14$DEHBDedCombInnOonFamilyPerPerson<-""
Plan_Attributes14$DEHBDedCombInnOonFamilyPerGroup<-""
Plan_Attributes14$TEHBDedInnTier1FamilyPerPerson<-""
Plan_Attributes14$TEHBDedInnTier1FamilyPerGroup<-""
Plan_Attributes14$TEHBDedInnTier2FamilyPerPerson<-""
Plan_Attributes14$TEHBDedInnTier2FamilyPerGroup<-""
Plan_Attributes14$TEHBDedOutOfNetFamilyPerPerson<-""
Plan_Attributes14$TEHBDedOutOfNetFamilyPerGroup<-""
Plan_Attributes14$TEHBDedCombInnOonFamilyPerPerson<-""
Plan_Attributes14$TEHBDedCombInnOonFamilyPerGroup<-""
Plan_Attributes14$PlanVariantMarketingName<-""
Plan_Attributes14$SBCHavingSimplefractureDeductible<-""
Plan_Attributes14$SBCHavingSimplefractureCopayment<-""
Plan_Attributes14$SBCHavingSimplefractureCoinsurance<-""
Plan_Attributes14$SBCHavingSimplefractureLimit<-""
Plan_Attributes14$DesignType<-""
Plan_Attributes14$IssuerMarketPlaceMarketingName<-""

Plan_Attributes<-rbind(Plan_Attributes,Plan_Attributes14)


rm(Plan_Attributes14)
rm(Plan_Attributes15)
rm(Plan_Attributes16)
rm(Plan_Attributes17)
rm(Plan_Attributes18)
rm(Plan_Attributes19)
rm(Plan_Attributes20)
rm(Plan_Attributes21)


#Other Impport

SAHIE_Processed <- read.csv("PUF/SAHIE Processed.txt")
names(SAHIE_Processed)[names(SAHIE_Processed) == 'Income.Category'] <- 'Income'
names(SAHIE_Processed)[names(SAHIE_Processed) == 'Race.Category'] <- 'Race'
names(SAHIE_Processed)[names(SAHIE_Processed) == 'Sex.Category'] <- 'Sex'
names(SAHIE_Processed)[names(SAHIE_Processed) == 'Total.Population'] <- 'Total_Population'
names(SAHIE_Processed)[names(SAHIE_Processed) == 'Insured.Estimate'] <- 'Insured_Estimate'



StateFIPS <- read.csv("PUF/StateFIPS.csv")

#RatingAreas <- read.csv("PUF\\Rating Area Crosswalk by Year.txt")
RatingAreas <- read.csv("PUF\\Rating Area Crosswalk by Year - Updated 2021.csv")





Issuer_Names<-sqldf('
    SELECT IssuerId, IssuerMarketPlaceMarketingName 
      ,count(*) as NumRows
      ,count(distinct BusinessYear) as NumYears
    FROM RateAnalysisTable 
    GROUP BY IssuerId, IssuerMarketPlaceMarketingName
  ')
