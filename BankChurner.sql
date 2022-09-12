select * from Bankchurner
--Check for nulls
select * from Bankchurner 
where Marital_Status is null

--Checking for duplicate record
select count(distinct clientnum)
from Bankchurner
--No duplicate record since the number of unique clientnum is same as the total records

--EDA
Select cast(((cast(count(Attrition_flag) as decimal(10,2))/(select count(*) from Bankchurner))*100) as decimal(10,2)) as [Attrited Customer Percentage],
100-(cast(((cast(count(Attrition_flag) as decimal(10,2))/(select count(*) from Bankchurner))*100) as decimal(10,2))) as [Existing Customer Percentage]
from bankchurner 
where Attrition_Flag='Attrited Customer'
--16% of our customers have churned
--What's the Contribution of each gender to attrition?
select cast(((cast(count(Gender) as decimal(10,2))/(select count(Attrition_Flag) from Bankchurner where Attrition_Flag='Attrited Customer'))*100) as decimal(10,2)) as[Male's Contribution to Attrition],
100-(cast(((cast(count(Gender) as decimal(10,2))/(select count(Attrition_Flag) from Bankchurner where Attrition_Flag='Attrited Customer'))*100) as decimal(10,2))) as [Female's Contribution to Attrition]
from Bankchurner
where Gender='M'
and Attrition_Flag='Attrited Customer'
--Percentage of male and female customers
select cast(((cast(count(Gender) as decimal(10,2))/(select count(*) from Bankchurner))*100) as decimal(10,2)) as [Male's Percentage],
100-(cast(((cast(count(Attrition_flag) as decimal(10,2))/(select count(*) from Bankchurner))*100) as decimal(10,2))) as [Female's Percentage]
from Bankchurner
where Gender='M'


EXACT CONTRIBUTIN OF EACH GENDER TO ATTRITION
select cast(((cast(count(Gender) as decimal(10,2))/(select count(gender) from Bankchurner where Gender='M'))*100) as decimal(10,2)) as [Attrited Male Customer],
100-(cast(((cast(count(Gender) as decimal(10,2))/(select count(gender) from Bankchurner where Gender='M'))*100) as decimal(10,2))) as [Existing Male Customer]
from Bankchurner
where Gender='M'
and Attrition_Flag='Attrited Customer'


select cast(((cast(count(Gender) as decimal(10,2))/(select count(gender) from Bankchurner where Gender='F'))*100) as decimal(10,2)) as [Attrited Female Customers],
100-(cast(((cast(count(Gender) as decimal(10,2))/(select count(gender) from Bankchurner where Gender='F'))*100) as decimal(10,2))) as [Existing Female Customers]
from Bankchurner
where Gender='F'
and Attrition_Flag='Attrited Customer'




--Contribution of marital status
select cast(((cast(count(Marital_Status) as decimal(10,2))/(select count(Marital_Status) from Bankchurner where Marital_Status='Married'))*100) as decimal(10,2)) as [Attrited Married Customers],
100-(cast(((cast(count(Marital_Status) as decimal(10,2))/(select count(Marital_Status) from Bankchurner where Marital_Status='Married'))*100) as decimal(10,2))) as [Existing Married Customers]
from Bankchurner
where Marital_Status='Married'
and Attrition_Flag='Attrited Customer'

--Contribution of marital status
select cast(((cast(count(Marital_Status) as decimal(10,2))/(select count(Marital_Status) from Bankchurner where Marital_Status='Single'))*100) as decimal(10,2)) as [Attrited Single Customers],
100-(cast(((cast(count(Marital_Status) as decimal(10,2))/(select count(Marital_Status) from Bankchurner where Marital_Status='Single'))*100) as decimal(10,2))) as [Existing Single Customers]
from Bankchurner
where Marital_Status='Single'
and Attrition_Flag='Attrited Customer'

--Contribution of marital status
select cast(((cast(count(Marital_Status) as decimal(10,2))/(select count(Marital_Status) from Bankchurner where Marital_Status='Unknown'))*100) as decimal(10,2)) as [Attrited Customers with Marital status unknown],
100-(cast(((cast(count(Marital_Status) as decimal(10,2))/(select count(Marital_Status) from Bankchurner where Marital_Status='Unknown'))*100) as decimal(10,2))) as [Existing Customers with marital status unknown]
from Bankchurner
where Marital_Status='Unknown'
and Attrition_Flag='Attrited Customer'

select cast(((cast(count(Marital_Status) as decimal(10,2))/(select count(Marital_Status) from Bankchurner where Marital_Status='Divorced'))*100) as decimal(10,2)) as [Attrited Divorced Customers],
100-(cast(((cast(count(Marital_Status) as decimal(10,2))/(select count(Marital_Status) from Bankchurner where Marital_Status='Divorced'))*100) as decimal(10,2))) as [Existing Divorced Customers]
from Bankchurner
where Marital_Status='Divorced'
and Attrition_Flag='Attrited Customer'

--Credit Card Category 
select  Card_Category, COUNT(card_category)
from Bankchurner
group by Card_Category
order by 2 desc

select cast((cast((select count(card_category) from Bankchurner where Card_Category='Silver' and Attrition_Flag='Attrited Customer') as decimal(10,2))/count(*))*100.00 as decimal(10,2)) as [Silver's Contribution to Attrition],
cast((cast((select count(card_category) from Bankchurner where Card_Category='Gold' and Attrition_Flag='Attrited Customer') as decimal(10,2))/count(*))*100.00 as decimal(10,2)) as [Gold's Contribution to Attrition],
cast((cast((select count(card_category) from Bankchurner where Card_Category='Platinum' and Attrition_Flag='Attrited Customer') as decimal(10,2))/count(*))*100.00 as decimal(10,2)) as [Platinum's Contribution to Attrition],
cast((cast((select count(card_category) from Bankchurner where Card_Category='Blue' and Attrition_Flag='Attrited Customer') as decimal(10,2))/count(*))*100.00 as decimal(10,2)) as [Blue card Contribution to Attrition]
from Bankchurner
where Attrition_Flag='Attrited Customer'
--Blue card which is the most common card shows a very high contribution to Attrition while Platinum card shows the very least contiribution

--Utilization ratio of each card type

--Eduaction's Level
select cast(((cast(count(Education_Level) as decimal(10,2))/(select count(Education_Level) from Bankchurner where Education_Level='Doctorate'))*100) as decimal(10,2)) as [Attrited Customers - Doctorate],
100-(cast(((cast(count(Education_Level) as decimal(10,2))/(select count(Education_Level) from Bankchurner where Education_Level='Doctorate'))*100) as decimal(10,2))) as [Existing Customers - Doctorate]
from Bankchurner
where Education_Level='Doctorate'
and Attrition_Flag='Attrited Customer'

select cast(((cast(count(Education_Level) as decimal(10,2))/(select count(Education_Level) from Bankchurner where Education_Level='Post-Graduate'))*100) as decimal(10,2)) as [Attrited Customers - Post-Graduate],
100-(cast(((cast(count(Education_Level) as decimal(10,2))/(select count(Education_Level) from Bankchurner where Education_Level='Post-Graduate'))*100) as decimal(10,2))) as [Existing Customers - Post-Graduate]
from Bankchurner
where Education_Level='Post-Graduate'
and Attrition_Flag='Attrited Customer'

select cast(((cast(count(Education_Level) as decimal(10,2))/(select count(Education_Level) from Bankchurner where Education_Level='Graduate'))*100) as decimal(10,2)) as [Attrited Customers - Graduate],
100-(cast(((cast(count(Education_Level) as decimal(10,2))/(select count(Education_Level) from Bankchurner where Education_Level='Graduate'))*100) as decimal(10,2))) as [Existing Customers - Graduate]
from Bankchurner
where Education_Level='Graduate'
and Attrition_Flag='Attrited Customer'

select cast(((cast(count(Education_Level) as decimal(10,2))/(select count(Education_Level) from Bankchurner where Education_Level='College'))*100) as decimal(10,2)) as [Attrited Customers - College],
100-(cast(((cast(count(Education_Level) as decimal(10,2))/(select count(Education_Level) from Bankchurner where Education_Level='College'))*100) as decimal(10,2))) as [Existing Customers - College]
from Bankchurner
where Education_Level='College'
and Attrition_Flag='Attrited Customer'

select cast(((cast(count(Education_Level) as decimal(10,2))/(select count(Education_Level) from Bankchurner where Education_Level='High School'))*100) as decimal(10,2)) as [Attrited Customers - High School],
100-(cast(((cast(count(Education_Level) as decimal(10,2))/(select count(Education_Level) from Bankchurner where Education_Level='High School'))*100) as decimal(10,2))) as [Existing Customers - High School]
from Bankchurner
where Education_Level='High School'
and Attrition_Flag='Attrited Customer'

select cast(((cast(count(Education_Level) as decimal(10,2))/(select count(Education_Level) from Bankchurner where Education_Level='Uneducated'))*100) as decimal(10,2)) as [Attrited Customers - Uneducated],
100-(cast(((cast(count(Education_Level) as decimal(10,2))/(select count(Education_Level) from Bankchurner where Education_Level='Uneducated'))*100) as decimal(10,2))) as [Existing Customers - Uneducated]
from Bankchurner
where Education_Level='Uneducated'
and Attrition_Flag='Attrited Customer'

select cast(((cast(count(Education_Level) as decimal(10,2))/(select count(Education_Level) from Bankchurner where Education_Level='Unknown'))*100) as decimal(10,2)) as [Attrited Customers - Unknown],
100-(cast(((cast(count(Education_Level) as decimal(10,2))/(select count(Education_Level) from Bankchurner where Education_Level='Unknown'))*100) as decimal(10,2))) as [Existing Customers - Unknown]
from Bankchurner
where Education_Level='Unknown'
and Attrition_Flag='Attrited Customer'

--Income Category
select cast(((cast(count(Income_Category) as decimal(10,2))/(select count(Income_Category) from Bankchurner where Income_Category='Less than $40K'))*100) as decimal(10,2)) as [Attrited Customers - Post-Graduate],
100-(cast(((cast(count(Income_Category) as decimal(10,2))/(select count(Income_Category) from Bankchurner where Income_Category='Less than $40K'))*100) as decimal(10,2))) as [Existing Customers - Post-Graduate]
from Bankchurner
where Income_Category='Less than $40K'
and Attrition_Flag='Attrited Customer'

select cast(((cast(count(Income_Category) as decimal(10,2))/(select count(Income_Category) from Bankchurner where Income_Category='$40K - $60K'))*100) as decimal(10,2)) as [Attrited Customers - $40K - $60K],
100-(cast(((cast(count(Income_Category) as decimal(10,2))/(select count(Income_Category) from Bankchurner where Income_Category='$40K - $60K'))*100) as decimal(10,2))) as [Existing Customers - $40K - $60K]
from Bankchurner
where Income_Category='$40K - $60K'
and Attrition_Flag='Attrited Customer'

select cast(((cast(count(Income_Category) as decimal(10,2))/(select count(Income_Category) from Bankchurner where Income_Category='$60K - $80K'))*100) as decimal(10,2)) as [Attrited Customers - $60K - $80K],
100-(cast(((cast(count(Income_Category) as decimal(10,2))/(select count(Income_Category) from Bankchurner where Income_Category='$60K - $80K'))*100) as decimal(10,2))) as [Existing Customers - $60K - $80K]
from Bankchurner
where Income_Category='$60K - $80K'
and Attrition_Flag='Attrited Customer'

select cast(((cast(count(Income_Category) as decimal(10,2))/(select count(Income_Category) from Bankchurner where Income_Category='$80K - $120K'))*100) as decimal(10,2)) as [Attrited Customers - $80K - $120K],
100-(cast(((cast(count(Income_Category) as decimal(10,2))/(select count(Income_Category) from Bankchurner where Income_Category='$80K - $120K'))*100) as decimal(10,2))) as [Existing Customers - $80K - $120K]
from Bankchurner
where Income_Category='$80K - $120K'
and Attrition_Flag='Attrited Customer'

select cast(((cast(count(Income_Category) as decimal(10,2))/(select count(Income_Category) from Bankchurner where Income_Category='$120K +'))*100) as decimal(10,2)) as [Attrited Customers - $120K +],
100-(cast(((cast(count(Income_Category) as decimal(10,2))/(select count(Income_Category) from Bankchurner where Income_Category='$120K +'))*100) as decimal(10,2))) as [Existing Customers - $120K +]
from Bankchurner
where Income_Category='$120K +'
and Attrition_Flag='Attrited Customer'

select cast(((cast(count(Income_Category) as decimal(10,2))/(select count(Income_Category) from Bankchurner where Income_Category='Unknown'))*100) as decimal(10,2)) as [Attrited Customers - Unknown],
100-(cast(((cast(count(Income_Category) as decimal(10,2))/(select count(Income_Category) from Bankchurner where Income_Category='Unknown'))*100) as decimal(10,2))) as [Existing Customers - Unknown]
from Bankchurner
where Income_Category='Unknown'
and Attrition_Flag='Attrited Customer'

--Grouping of age and knowing each group's contribution to attrition
alter table Bankchurner
add  [grouped age] varchar(20)

update Bankchurner
set [grouped age]= 
(case when Customer_Age < 30 then '<30'
when Customer_Age >=30 and Customer_Age <= 40 then '30-40'
when Customer_Age >40 and Customer_Age <=50 then '41-50'
else '>50' end) from Bankchurner

--Age
select cast(((cast(count([grouped age]) as decimal(10,2))/(select count([grouped age]) from Bankchurner where [grouped age]='>50'))*100) as decimal(10,2)) as [Attrited Customers - >50],
100-(cast(((cast(count([grouped age]) as decimal(10,2))/(select count([grouped age]) from Bankchurner where [grouped age]='>50'))*100) as decimal(10,2))) as [Existing Customers - >50] 
from Bankchurner
where [grouped age]='>50'
and Attrition_Flag='Attrited Customer'

select cast(((cast(count([grouped age]) as decimal(10,2))/(select count([grouped age]) from Bankchurner where [grouped age]='41-50'))*100) as decimal(10,2)) as [Attrited Customers 41-50],
100-(cast(((cast(count([grouped age]) as decimal(10,2))/(select count([grouped age]) from Bankchurner where [grouped age]='41-50'))*100) as decimal(10,2))) as [Existing Customers 41-50] 
from Bankchurner
where [grouped age]='41-50'
and Attrition_Flag='Attrited Customer'
          
select cast(((cast(count([grouped age]) as decimal(10,2))/(select count([grouped age]) from Bankchurner where [grouped age]='30-40'))*100) as decimal(10,2)) as [Attrited Customers - 30-40],
100-(cast(((cast(count([grouped age]) as decimal(10,2))/(select count([grouped age]) from Bankchurner where [grouped age]='30-40'))*100) as decimal(10,2))) as [Existing Customers - 30-40] 
from Bankchurner
where [grouped age]='30-40'
and Attrition_Flag='Attrited Customer'

select cast(((cast(count([grouped age]) as decimal(10,2))/(select count([grouped age]) from Bankchurner where [grouped age]='<30'))*100) as decimal(10,2)) as [Attrited Customers - <30],
100-(cast(((cast(count([grouped age]) as decimal(10,2))/(select count([grouped age]) from Bankchurner where [grouped age]='<30'))*100) as decimal(10,2))) as [Existing Customers - <30] 
from Bankchurner
where [grouped age]='<30'
and Attrition_Flag='Attrited Customer'

          
 --Dependent_count vs avg_utilization_ratio 
select Dependent_count ,AVG(Avg_Utilization_Ratio) from Bankchurner where Attrition_Flag='Attrited Customer' GROUP BY Dependent_count order by 1
 


 select count(*) from Bankchurner