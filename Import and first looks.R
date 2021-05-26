library(sqldf)
install.packages("beepr")
library(beepr)
install.packages("tidyverse")
library(tidyverse)


setwd("C:\\Users\\dludwin\\OneDrive\\Docs\\Research\\Exchanges\\") 

SAHIE_Processed <- read.csv("PUF/SAHIE Processed.txt")
names(SAHIE_Processed)[names(SAHIE_Processed) == 'Income.Category'] <- 'Income'
names(SAHIE_Processed)[names(SAHIE_Processed) == 'Race.Category'] <- 'Race'
names(SAHIE_Processed)[names(SAHIE_Processed) == 'Sex.Category'] <- 'Sex'
names(SAHIE_Processed)[names(SAHIE_Processed) == 'Total.Population'] <- 'Total_Population'
names(SAHIE_Processed)[names(SAHIE_Processed) == 'Insured.Estimate'] <- 'Insured_Estimate'



StateFIPS <- read.csv("PUF/StateFIPS.csv")

RatingAreas <- read.csv("PUF\\Rating Area Crosswalk by Year.txt")

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

Service_Area<-rbind(Service_Area,Service_Area15)

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

# Plan_Attributes

Plan_Attributes21<-read.csv("PUF/2021/Plan_Attributes_PUF.csv")
Plan_Attributes20<-read.csv("PUF/2020/Plan_Attributes_PUF.csv")
Plan_Attributes19<-read.csv("PUF/2019/Plan_Attributes_PUF.csv")
Plan_Attributes18<-read.csv("PUF/2018/Plan_Attributes_PUF.csv")
Plan_Attributes17<-read.csv("PUF/2017/Plan_Attributes_PUF.csv")
Plan_Attributes16<-read.csv("PUF/2016/Plan_Attributes_PUF.csv")
Plan_Attributes15<-read.csv("PUF/2015/Plan_Attributes_PUF.csv")


names(Plan_Attributes21)[names(Plan_Attributes21) == 'PlanEffictiveDate'] <- 'PlanEffectiveDate'
names(Plan_Attributes20)[names(Plan_Attributes20) == 'PlanEffictiveDate'] <- 'PlanEffectiveDate'
names(Plan_Attributes19)[names(Plan_Attributes19) == 'PlanEffictiveDate'] <- 'PlanEffectiveDate'
names(Plan_Attributes18)[names(Plan_Attributes18) == 'PlanEffictiveDate'] <- 'PlanEffectiveDate'
names(Plan_Attributes17)[names(Plan_Attributes17) == 'PlanEffictiveDate'] <- 'PlanEffectiveDate'
names(Plan_Attributes16)[names(Plan_Attributes16) == 'PlanEffictiveDate'] <- 'PlanEffectiveDate'
names(Plan_Attributes15)[names(Plan_Attributes15) == 'PlanEffictiveDate'] <- 'PlanEffectiveDate'



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


rm(Plan_Attributes15)
rm(Plan_Attributes16)
rm(Plan_Attributes17)
rm(Plan_Attributes18)
rm(Plan_Attributes19)
rm(Plan_Attributes20)
rm(Plan_Attributes21)


#Just the standardcomponent level information from the plan attributes
Plan_Attributes_Stan<-sqldf('
  SELECT BusinessYear, StandardComponentId, StateCode, IssuerId, IssuerMarketPlaceMarketingName, DentalOnlyPlan, PlanMarketingName, HIOSProductId, NetworkId, ServiceAreaId, FormularyId, IsNewPlan, PlanType, MetalLevel, UniquePlanDesign, PlanEffectiveDate, PlanExpirationDate, OutOfServiceAreaCoverage, OutOfServiceAreaCoverageDescription, NationalNetwork, MarketCoverage
    , count(*) as NumRows
  FROM Plan_Attributes
  GROUP BY BusinessYear, StandardComponentId, StateCode, IssuerId, IssuerMarketPlaceMarketingName, DentalOnlyPlan, PlanMarketingName, HIOSProductId, NetworkId, ServiceAreaId, FormularyId, IsNewPlan, PlanType, MetalLevel, UniquePlanDesign, PlanEffectiveDate, PlanExpirationDate, OutOfServiceAreaCoverage, OutOfServiceAreaCoverageDescription, NationalNetwork, MarketCoverage 
  ')
beep()

#43970




#Creating mega table
RateAnalysisTable<-sqldf('
              SELECT
                  rt.BusinessYear, rt.StateCode, rt.IssuerId, rt.RateEffectiveDate, rt.RateExpirationDate, rt.PlanId, rt.RatingAreaId, rt.Tobacco, rt.IndividualRate, rt.FederalTIN
                  , pa.IssuerMarketPlaceMarketingName, pa.PlanMarketingName, pa.HIOSProductId, pa.NetworkId, pa.ServiceAreaId, pa.FormularyId, pa.IsNewPlan, pa.PlanType, pa.UniquePlanDesign, pa.PlanEffectiveDate, pa.PlanExpirationDate, pa.OutOfServiceAreaCoverage, pa.NationalNetwork 
              FROM Rate rt
              INNER JOIN Plan_Attributes_Stan pa
                on rt.PlanID = pa.StandardComponentId and rt.BusinessYear = pa.BusinessYear
              Where rt.Age = 40 and rt.IndividualRate>0 and pa.MetalLevel = "Silver" and pa.MarketCoverage = "Individual"
               and pa.DentalOnlyPlan = "No"
              ')
beep()

RateAnalysisTable$RatingAreaNum<-as.numeric(substr(RateAnalysisTable$RatingAreaId, 13, nchar(RateAnalysisTable$RatingAreaId)))

RateAnalysisTable$RatingAreaID2<-paste(RateAnalysisTable$StateCode,RateAnalysisTable$RatingAreaNum,sep="")

RateAnalysisTable$RatingAreaID2 = ifelse (RateAnalysisTable$RatingAreaNum < 10, paste(RateAnalysisTable$StateCode,RateAnalysisTable$RatingAreaNum,sep="0"), RateAnalysisTable$RatingAreaID2 )


#Exclude LA County
#Exlcude Mass and Alaska
RateAnalysisTable_cnty<-sqldf('
              SELECT rat.*
                , areas.fips_code, areas.county_name, areas.FIPS_REVISED
              From RateAnalysisTable rat
              INNER JOIN RatingAreas areas
                on rat.BusinessYear = areas.year and rat.RatingAreaID2 = areas.rating_area_id
              WHERE rat.StateCode not in ("MA", "AK")
              ')
beep()


RateAnalysisTable_cnty2<-sqldf('
              SELECT rat.*
              From RateAnalysisTable_cnty rat
              INNER JOIN Service_Area_ex sa
                on rat.BusinessYear = sa.BusinessYear and rat.IssuerId = sa.IssuerId and rat.ServiceAreaId = sa.ServiceAreaId
                and rat.FIPS_REVISED = sa.County
              ')
beep()



RateAnalysisTable_cnty3<-sqldf('
              SELECT rat.*
                , AHIE.Total_Population, AHIE.Insured_Estimate 
              From RateAnalysisTable_cnty2 rat
              INNER JOIN SAHIE_Processed AHIE
                on rat.FIPS_REVISED = AHIE.FIPS 
              ')
beep()



#By county
leastexpensive_yr<-sqldf('SELECT rt.BusinessYear, rt.StateCode, rt.RatingAreaId, rt.FIPS_REVISED, rt.county_name, min(rt.IndividualRate) as MinRate , count(*) as NumRows
                      FROM RateAnalysisTable_cnty3 rt
                      GROUP BY rt.BusinessYear, rt.StateCode, rt.RatingAreaId, rt.FIPS_REVISED, rt.county_name
                      ')
beep()

leastexpensive_yr_nm<-sqldf('SELECT le.*, rt.IssuerId, rt.PlanId
                      FROM leastexpensive_yr le
                      INNER JOIN RateAnalysisTable rt
                        on rt.IndividualRate = le.MinRate and rt.BusinessYear = le.BusinessYear
                        and rt.StateCode = le.StateCode and rt.RatingAreaId = le.RatingAreaId
                      ')

leastexpensive_yr_nm2<-sqldf('SELECT distinct *
                      FROM leastexpensive_yr_nm le
                      ')


  
leastexpensive_yr_nm3<-sqldf('
                SELECT rat.*
                  , AHIE.Total_Population, AHIE.Insured_Estimate 
                From leastexpensive_yr_nm2 rat
                INNER JOIN SAHIE_Processed AHIE
                  on rat.FIPS_REVISED = AHIE.FIPS 
                ')
  

leastexpensive_pln_cnty<-sqldf('
                SELECT IssuerId, PlanId, RatingAreaId, StateCode, county_name, FIPS_REVISED, Total_Population, Insured_Estimate 
                  , count(distinct BusinessYear) as NumYears, count(*) as numRows
                From leastexpensive_yr_nm3 le
                GROUP BY IssuerId, PlanId, RatingAreaId, StateCode, county_name, FIPS_REVISED, Total_Population, Insured_Estimate 
                 ')
beep()  


leastexpensive_pln_cnty2<-sqldf('
              SELECT pln.*
                , count(distinct case when le.BusinessYear = 2015 then 1 else null end) as Cheapest2015
                , count(distinct case when le.BusinessYear = 2016 then 1 else null end) as Cheapest2016
                , count(distinct case when le.BusinessYear = 2017 then 1 else null end) as Cheapest2017
                , count(distinct case when le.BusinessYear = 2018 then 1 else null end) as Cheapest2018
                , count(distinct case when le.BusinessYear = 2019 then 1 else null end) as Cheapest2019
                , count(distinct case when le.BusinessYear = 2020 then 1 else null end) as Cheapest2020
                , count(distinct case when le.BusinessYear = 2021 then 1 else null end) as Cheapest2021
              From leastexpensive_pln_cnty pln
              LEFT OUTER JOIN leastexpensive_yr_nm3 le
                on pln.PlanId = le.PlanId and pln.FIPS_REVISED = le.FIPS_REVISED
              GROUP BY pln.IssuerId, pln.PlanId, pln.RatingAreaId, pln.StateCode, pln.county_name, pln.FIPS_REVISED, pln.Total_Population, pln.Insured_Estimate 
              ')


leastexpensive_pln_cnty2<-sqldf('
              SELECT pln.*
                , Cheapest2015*Cheapest2016 as StayCheapest15_16
                , Cheapest2016*Cheapest2017 as StayCheapest16_17
                , Cheapest2017*Cheapest2018 as StayCheapest17_18
                , Cheapest2018*Cheapest2019 as StayCheapest18_19
                , Cheapest2019*Cheapest2020 as StayCheapest19_20
                , Cheapest2020*Cheapest2021 as StayCheapest20_21
              from leastexpensive_pln_cnty2 pln

              ')


summary_le<-sqldf('
              SELECT SUM(Cheapest2015) as Tot2015
, SUM(Cheapest2016) as Tot2016
, SUM(Cheapest2017) as Tot2017
, SUM(Cheapest2018) as Tot2018
, SUM(Cheapest2019) as Tot2019
,  SUM(StayCheapest15_16) as NumStay15_16
                , SUM(StayCheapest16_17) as NumStay16_17
                , SUM(StayCheapest17_18) as NumStay17_18
                , SUM(StayCheapest18_19) as NumStay18_19
                , SUM(StayCheapest19_20) as NumStay19_20


              from leastexpensive_pln_cnty2 pln

              ')




summary_le<-sqldf('
             SELECT SUM(Cheapest2015*Total_Population) as Tot2015
, SUM(Cheapest2016*Total_Population) as Tot2016
, SUM(Cheapest2017*Total_Population) as Tot2017
, SUM(Cheapest2018*Total_Population) as Tot2018
, SUM(Cheapest2019*Total_Population) as Tot2019
,  SUM(StayCheapest15_16*Total_Population) as NumStay15_16
, SUM(StayCheapest16_17*Total_Population) as NumStay16_17
, SUM(StayCheapest17_18*Total_Population) as NumStay17_18
, SUM(StayCheapest18_19*Total_Population) as NumStay18_19
, SUM(StayCheapest19_20*Total_Population) as NumStay19_20

              from leastexpensive_pln_cnty2 pln

              ')



summary_le<-sqldf('
             
SELECT SUM(Cheapest2015*Insured_Estimate) as Tot2015
, SUM(Cheapest2016*Insured_Estimate) as Tot2016
, SUM(Cheapest2017*Insured_Estimate) as Tot2017
, SUM(Cheapest2018*Insured_Estimate) as Tot2018
, SUM(Cheapest2019*Insured_Estimate) as Tot2019
,  SUM(StayCheapest15_16*Insured_Estimate) as NumStay15_16
, SUM(StayCheapest16_17*Insured_Estimate) as NumStay16_17
, SUM(StayCheapest17_18*Insured_Estimate) as NumStay17_18
, SUM(StayCheapest18_19*Insured_Estimate) as NumStay18_19
, SUM(StayCheapest19_20*Insured_Estimate) as NumStay19_20
              from leastexpensive_pln_cnty2 pln

              ')
write.csv(summary_le,"PUF\\summary_le.csv", row.names = TRUE)

tmp<-sqldf('select StateCode, sum(Total_Population)
    FROM leastexpensive_yr_nm3
    WHERE BusinessYear = 2015
    GROUP BY StateCode
  ')
write.csv(tmp,"PUF\\tmp.csv", row.names = TRUE)
shell("PUF\\tmp.csv", wait=FALSE)



sqldf('select sum(Total_Population)
    FROM SAHIE_Processed
    WHERE YEAR = 2013
  ')

tmp_plan<-sqldf('
		SELECT PlanId
		  , count(*)
		  , SUM(Cheapest2015+Cheapest2016+Cheapest2017+Cheapest2018+Cheapest2019+Cheapest2020+Cheapest2021) as NumCheapest
		  , SUM(Cheapest2015) as NumCheapest2015, sum(Cheapest2016) as Cheapest2016, sum(Cheapest2017) as Cheapest2017, sum(Cheapest2018) as Cheapest2018, sum(Cheapest2019) as Cheapest2019, sum(Cheapest2020) as Cheapest2020, sum(Cheapest2021) as Cheapest2021
		 , SUM(Cheapest2015*Total_Population) as Pop_Cheapest2015, sum(Cheapest2016*Total_Population) as Pop_Cheapest2016, sum(Cheapest2017*Total_Population) as Pop_Cheapest2017, sum(Cheapest2018*Total_Population) as Pop_Cheapest2018, sum(Cheapest2019*Total_Population) as Pop_Cheapest2019, sum(Cheapest2020*Total_Population) as Pop_Cheapest2020, sum(Cheapest2021*Total_Population) as Pop_Cheapest2021
		From leastexpensive_pln_cnty2 pln
		GROUP BY PlanId
		')
beep()

tmp_le<-sqldf('
		SELECT *
		From leastexpensive_pln_cnty2 pln
		Where PlanId = "11512NC0060028"
		')
  
  

