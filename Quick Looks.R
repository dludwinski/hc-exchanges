
setwd("C:\\Users\\dludwin\\OneDrive\\Docs\\Research\\Exchanges\\") 




tmp_RateAnalysisTable<-sqldf('
              SELECT *
              FROM RateAnalysisTable
              WHERE RatingAreaId = "Rating Area 13" and StateCode = "AL"
              Order By BusinessYear, IndividualRate
              ')
View(tmp_RateAnalysisTable)
write.csv(tmp_RateAnalysisTable,"\\TempExports\\tmp_RateAnalysisTable.csv", row.names = TRUE)


tmp_RateCheck<-sqldf('
              SELECT *
              FROM Rate
              WHERE PlanID = "46944AL0630001" and RatingAreaId = "Rating Area 13" and StateCode = "AL"
              ')
tmp_RateCheck<-sqldf('
              SELECT *
              FROM tmp_RateCheck
              WHERE Age = 40 and BusinessYear = 2016
              ')




write.csv(tmp_RateCheck,"TempExports\\tmp_RateCheck.csv", row.names = TRUE)



tmp5<-sqldf('SELECT PartialCounty, count(*) as NumRows FROM Service_Area GROUP BY PartialCounty
            ')

tmp6<-sqldf('SELECT *  FROM Service_Area where PartialCounty = "Yes"
            ')


# Temporary selects


#By Service County
leastexpensive_yr<-sqldf('SELECT rt.BusinessYear, rt.StateCode, sa.County, min(IndividualRate) as MinRate , count(*) as NumRows
                      FROM Rate rt
                      INNER JOIN Plan_Attributes pa
                        on rt.PlanID = pa.StandardComponentId and rt.BusinessYear = pa.BusinessYear
                      INNER JOIN Service_Area_ex sa
                        on pa.ServiceAreaId = sa.ServiceAreaId and pa.IssuerId = sa.IssuerId and pa.BusinessYear = sa.BusinessYear 
                      Where MetalLevel = "Silver" and Age = 40 and IndividualRate>0 and pa.MarketCoverage = "Individual"
                      and rt.StateCode = "AL"
                      GROUP BY rt.BusinessYear, rt.StateCode, sa.County ')


#By Rating Area
leastexpensive_yr<-sqldf('SELECT rt.BusinessYear, rt.StateCode, rt.RatingAreaId, min(rt.IndividualRate) as MinRate , count(*) as NumRows
                      FROM Rate rt
                      INNER JOIN Plan_Attributes pa
                        on rt.PlanID = pa.StandardComponentId and rt.BusinessYear = pa.BusinessYear
                      Where rt.Age = 40 and rt.IndividualRate>0 and pa.MetalLevel = "Silver" and pa.MarketCoverage = "Individual"
                      GROUP BY rt.BusinessYear, rt.StateCode, rt.RatingAreaId ')

leastexpensive_yr_nm<-sqldf('SELECT le.*, rt.IssuerId, rt.PlanId
                      FROM leastexpensive_yr le
                      INNER JOIN Rate rt
                        on rt.IndividualRate = le.MinRate and rt.BusinessYear = le.BusinessYear
                        and rt.StateCode = le.StateCode and rt.RatingAreaId = le.RatingAreaId
                      Where rt.Age = 40
                      ')



tmp3<-sqldf('
              SELECT *
              From RatingAreas
              where year = 2019 and rating_area_id in ("TX26")
              ')

tmp3<-sqldf('
              SELECT *
              From RatingAreas
              where year = 2015 and rating_area_id in ("NC08", "NC16", "NC14")
              ')

tmp3<-sqldf('
              SELECT *
              From RatingAreas
              where  county_name = "Nash County" 
              ')


tmp4<-sqldf('
              SELECT *
              From leastexpensive_yr_cnty
              where FIPS_REVISED = 37127
              ')

#Green county FIPS 37079,  2020-2021 11512NC0060028 vs 73943NC0070014




tmp2<-sqldf('
              SELECT *
              From leastexpensive_yr_nm
              where PlanId in ( "11512NC0060028") and BusinessYear = 2015
              ')

#Rating area 14
#54332NC0030005 vs 11512NC0060028


tmp<-sqldf('
              SELECT *
              From Plan_Attributes
              where StandardComponentId = "11512NC0060028" and BusinessYear = 2015
              ')

tmp<-sqldf('
              SELECT *
              From RateAnalysisTable_cnty2
              where FIPS_REVISED = 37127 and BusinessYear = 2020 and PlanID = "73943NC0070014"
              ')

sqldf('
              SELECT Tobacco, BusinessYear
                , count(*)
              From RateAnalysisTable_cnty2
              GROUP BY Tobacco, BusinessYear
              ')


beep()



tmp<-sqldf('
              SELECT *
              From RateAnalysisTable_cnty2
              where FIPS_REVISED = 37065 and BusinessYear = 2015
              ')



write.csv(tmp3,"TempExports\\tmp3_11.csv", row.names = TRUE)
#RateAnalysisTable




















View(tmp)



write.csv(leastexpensive_yr,"TempExports\\leastexpensive_yr.csv", row.names = TRUE)


tmp_planview<-sqldf('SELECT *
                      FROM Rate rt
                      INNER JOIN Plan_Attributes pa
                        on rt.PlanID = pa.StandardComponentId and rt.BusinessYear = pa.BusinessYear
                      INNER JOIN Service_Area sa
                        on pa.ServiceAreaId = sa.ServiceAreaId and pa.BusinessYear = sa.BusinessYear
                      Where MetalLevel = "Silver" and Age = 40 and IndividualRate>0 and pa.MarketCoverage = "Individual"
                      and rt.BusinessYear = 2019 and rt.StateCode = "AL" and rt.IndividualRate = 477.98
                      ')


tmp_rateview<-sqldf('SELECT rt.*
                      FROM Rate rt
                      Where rt.PlanId = "11512NC0060028" and BusinessYear = 2015 and Age = 40
                      ')
beep()


tmp_rateview<-sqldf('SELECT rt.*
                      FROM RateAnalysisTable_cnty rt
                      Where fips_code ="2013" and StateCode = "AK" and BusinessYear = 2015
                      ')
beep()

tmp_planatr<-sqldf('SELECT rt.*
                      FROM Plan_Attributes_Stan rt
                      Where StandardComponentId ="38344AK0600004" and BusinessYear = 2015
                      ')
beep()

tmp_attributeview<-sqldf('SELECT pa.*
                      FROM Plan_Attributes pa
                      Where pa.StandardComponentId = "54332NC0030005" and pa.BusinessYear = 2015
                      ')
beep()


tmp_serviceareaview<-sqldf('SELECT sa.*
                      FROM Service_Area_ex sa
                      Where sa.ServiceAreaId = "NCS001" and sa.IssuerId = "54332" and sa.BusinessYear = 2015
                      ')
beep()

state_countyfips<-sqldf('SELECT StateCode, County, count(*) as NumRows
                      FROM Service_Area sa
                      GROUP BY StateCode, County
                      ')
write.csv(state_countyfips,"TempExports\\state_countyfips.csv", row.names = TRUE)



Service_Area$County


tmp_planview2<-subset(Rate, Rate.PlanID="46944AL0660001" & Rate.BusinessYear==2019)



tmp<-sqldf('SELECT * FROM Rate where PlanID = "46944AL0660001" AND Age = 40')
write.csv(tmp,"TempExports\\tmp2.csv", row.names = TRUE)

tmp3<-sqldf('SELECT BusinessYear, Count(*) as NumRates FROM Rate GROUP BY BusinessYear')
write.csv(tmp3,"TempExports\\tmp3.csv", row.names = TRUE)




leastexpensive<-sqldf('SELECT rt.BusinessYear, rt.StateCode, RatingAreaId, min(IndividualRate) as MinRate , count(*) as NumRows
                      FROM Rate_PUF rt
                      INNER JOIN Plan_Attributes_PUF pl
                      on rt.PlanID = pl.StandardComponentId
                      Where MetalLevel = "Silver" and Age = 40 and IndividualRate>0 and MarketCoverage = "Individual"
                      GROUP BY rt.BusinessYear, rt.StateCode, RatingAreaId ')
write.csv(leastexpensive,"TempExports\\leastexpensive.csv", row.names = TRUE)


tmp4<-sqldf('SELECT rt.*, pl.*
       FROM Rate_PUF rt
                      INNER JOIN Plan_Attributes_PUF pl
                      on rt.PlanID = pl.StandardComponentId
                      Where MetalLevel = "Silver" and Age = 40 and IndividualRate>0 AND rt.StateCode = "AL" and RatingAreaID ="Rating Area 13"
                      and MarketCoverage = "Individual"
            ')
write.csv(tmp3,"TempExports\\tmp3", row.names = TRUE)

