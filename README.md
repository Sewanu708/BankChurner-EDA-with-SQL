# BankChurner-EDA-with-SQL 
A business manager of a consumer credit card portfolio is facing the problem of customer churn. They want to analyze the data to find out the reason behind this and leverage the same to predict customers who are likely to drop off.

Customer churn or customer attrition is simply the rate at which customers stop doing business with an entity
## Goal of this Analysis
*Based on the introduction, it’s clear that the goal of this data exploration is to find out the reason behind customer churn so as to prevent further attrition.*
## Data Preparation and Understanding 
Behind the scene, I have my data loaded as **BankChurner** into a database called ***creditbank***, Checked for nulls and duplicates of which none was found.

*Overview of our dataset*
<img width="941" alt="Annotation 2022-09-10 005111" src="https://user-images.githubusercontent.com/99955484/189459880-c8c9e846-385f-4cfd-a14b-c647fe6ce1bc.png">,<img width="850" alt="Annotation 2022-9-10 005149" src="https://user-images.githubusercontent.com/99955484/189459888-6ce999f6-0160-40d8-891a-fa1ca609af14.png">

**Meaning of fields (useful for our analysis) in the table(BankChurner)**
- **CLIENTNUM**: Client number. Unique identifier for the customer holding the account
- **Attrition_Flag**: Shows whether theaccount holder is still active or not 
- **Customer _Age**: Customer’s  age in years
- **Gender**: Customer’s gender. M=Male,F=Female
- **Dependent_Count**: Number of dependents
- **Education_level**: Eduaction qualification of account holder
- **Marital_Status**: Marital status of account holder
- **Income_Category**: Annual income category of account holder 
- **Card_Category**:Type of card possess by the account holder
- **Total_Revolving_Bal**: Total revolving balance on the credit card
- **Avg_Utilization_Ratio**: Average card utilization ratio

## Data Exploration 
First of all let's check for the percentage of attrited customers and existing customers
### Percentage of attrited customers and existing customers
```SQL
Select cast(((cast(count(Attrition_flag) as decimal(10,2))/(select count(*) from Bankchurner))*100) as decimal(10,2)) as [Attrited Customer Percentage],
100-(cast(((cast(count(Attrition_flag) as decimal(10,2))/(select count(*) from Bankchurner))*100) as decimal(10,2))) as [Existing Customer Percentage]
from bankchurner 
where Attrition_Flag='Attrited Customer'
```
*output*

<img width="310" alt="6" src="https://user-images.githubusercontent.com/99955484/189460776-7d84d325-6871-4e6b-9e01-df27603ce988.png">

### Gender
**Contribution of each gender to attrition**
```SQL
--Male
select cast(((cast(count(Gender) as decimal(10,2))/(select count(gender) from Bankchurner where Gender='M'))*100) as decimal(10,2)) as [Attrited Male Customer],
100-(cast(((cast(count(Gender) as decimal(10,2))/(select count(gender) from Bankchurner where Gender='M'))*100) as decimal(10,2))) as [Existing Male Customer]
from Bankchurner
where Gender='M'
and Attrition_Flag='Attrited Customer'

--Female
select cast(((cast(count(Gender) as decimal(10,2))/(select count(gender) from Bankchurner where Gender='F'))*100) as decimal(10,2)) as [Attrited Female Customers],
100-(cast(((cast(count(Gender) as decimal(10,2))/(select count(gender) from Bankchurner where Gender='F'))*100) as decimal(10,2))) as [Existing Female Customers]
from Bankchurner
where Gender='F'
and Attrition_Flag='Attrited Customer'
```
*output*

<img width="282" alt="Annotation 2022-09-10 012659" src="https://user-images.githubusercontent.com/99955484/189461385-9c1d1e4e-f5c0-4d46-99c2-b49a24ff2329.png">


**Insights**
- 16% of 10127 customers haved churned
- The female gender contributed much more to attrition than the male gender and this shows that female gender are expected to churn more than the male gender

### How did Marital Status affects Churning?
The marital status of each customer can either be
- **Single**
- **Married**
- **Divorced** or
- **Unknown**.

let's see how they affect attrition.

```SQL
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
```
*Output*

<img width="451" alt="Annotation 2022-09-10 013823" src="https://user-images.githubusercontent.com/99955484/189461821-4742ebd9-e010-4796-8fc3-78196e3823e1.png">

**Insights**
- Account holders whose marital status are unknown seems to contribute more to attrition  

### Card Category 
Card category of an account holder can either be **Blue,Gold,Silver or Platinum**

**Which Card have the highest amount of holders?**
```SQL
select  Card_Category, COUNT(card_category)
from Bankchurner
group by Card_Category
order by 2 desc
```
*Output*

<img width="326" alt="Annotation 2022-09-10 015705" src="https://user-images.githubusercontent.com/99955484/189462720-8a755801-36fd-42f3-bfae-8cda4f79573f.png">

*Different cards are issued based on the annual income of an account holder.Those with very high income are given the paltinum card type while those with a very low income are given the Blue card.*

**Percentage Contribution to attrition**
```SQL
select cast((cast((select count(card_category) from Bankchurner where Card_Category='Silver' and Attrition_Flag='Attrited Customer') as decimal(10,2))/count(*))*100.00 as decimal(10,2)) as [Silver's Contribution to Attrition],
cast((cast((select count(card_category) from Bankchurner where Card_Category='Gold' and Attrition_Flag='Attrited Customer') as decimal(10,2))/count(*))*100.00 as decimal(10,2)) as [Gold's Contribution to Attrition],
cast((cast((select count(card_category) from Bankchurner where Card_Category='Platinum' and Attrition_Flag='Attrited Customer') as decimal(10,2))/count(*))*100.00 as decimal(10,2)) as [Platinum's Contribution to Attrition],
cast((cast((select count(card_category) from Bankchurner where Card_Category='Blue' and Attrition_Flag='Attrited Customer') as decimal(10,2))/count(*))*100.00 as decimal(10,2)) as [Blue card Contribution to Attrition]
from Bankchurner
where Attrition_Flag='Attrited Customer'
```
*Output*

<img width="707" alt="Annotation 2022-09-10 020508" src="https://user-images.githubusercontent.com/99955484/189462822-780c4798-7fc8-40a9-b16b-25d5121111c2.png">

**Insights**
- Blue card category have more users compared to others
- Blue card which is the most common card shows a very high contribution to Attrition while Platinum card shows the very least contiribution.

### Eduation Level
Based on this dataset, our customer's eduaction level can either be:
- Doctorate
- Graduate
- Post-Graduate
- College
- High School  
- Uneducated.

Also, some customers education level is Unknown.

**Which Eduacation_Level Contributes the most to attrition?**
##### Doctorate 
```SQL
--Eduaction's Level
select cast(((cast(count(Education_Level) as decimal(10,2))/(select count(Education_Level) from Bankchurner where Education_Level='Doctorate'))*100) as decimal(10,2)) as [Attrited Customers - Doctorate],
100-(cast(((cast(count(Education_Level) as decimal(10,2))/(select count(Education_Level) from Bankchurner where Education_Level='Doctorate'))*100) as decimal(10,2))) as [Existing Customers - Doctorate]
from Bankchurner
where Education_Level='Doctorate'
and Attrition_Flag='Attrited Customer'
```
*Output*

<img width="398" alt="Annotation 2022-09-11 042649" src="https://user-images.githubusercontent.com/99955484/189511100-a0f2d5f1-9931-451d-8a9d-d850728964c1.png">

##### Post-Graduate
```SQL
select cast(((cast(count(Education_Level) as decimal(10,2))/(select count(Education_Level) from Bankchurner where Education_Level='Post-Graduate'))*100) as decimal(10,2)) as [Attrited Customers - Post-Graduate],
100-(cast(((cast(count(Education_Level) as decimal(10,2))/(select count(Education_Level) from Bankchurner where Education_Level='Post-Graduate'))*100) as decimal(10,2))) as [Existing Customers - Post-Graduate]
from Bankchurner
where Education_Level='Post-Graduate'
and Attrition_Flag='Attrited Customer'
```
*Output*

<img width="413" alt="Annotation 2022-09-11 042831" src="https://user-images.githubusercontent.com/99955484/189511127-d2803e47-3b1e-4375-a78d-ecf5c8012fdf.png">

##### Graduate
```SQL
select cast(((cast(count(Education_Level) as decimal(10,2))/(select count(Education_Level) from Bankchurner where Education_Level='Graduate'))*100) as decimal(10,2)) as [Attrited Customers - Graduate],
100-(cast(((cast(count(Education_Level) as decimal(10,2))/(select count(Education_Level) from Bankchurner where Education_Level='Graduate'))*100) as decimal(10,2))) as [Existing Customers - Graduate]
from Bankchurner
where Education_Level='Graduate'
and Attrition_Flag='Attrited Customer'
```

*Ouput*

<img width="536" alt="Annotation 2022-09-11 042931" src="https://user-images.githubusercontent.com/99955484/189511160-71169db1-d66f-4355-9caa-8d4432f16af7.png">

##### College
```SQL
select cast(((cast(count(Education_Level) as decimal(10,2))/(select count(Education_Level) from Bankchurner where Education_Level='College'))*100) as decimal(10,2)) as [Attrited Customers - College],
100-(cast(((cast(count(Education_Level) as decimal(10,2))/(select count(Education_Level) from Bankchurner where Education_Level='College'))*100) as decimal(10,2))) as [Existing Customers - College]
from Bankchurner
where Education_Level='College'
and Attrition_Flag='Attrited Customer'
```

*Output*

<img width="377" alt="Annotation 2022-09-11 043053" src="https://user-images.githubusercontent.com/99955484/189511194-a657c64c-1c75-4c08-9bea-9ee0b13f15cd.png">

##### High-School

```SQL
select cast(((cast(count(Education_Level) as decimal(10,2))/(select count(Education_Level) from Bankchurner where Education_Level='High School'))*100) as decimal(10,2)) as [Attrited Customers - High School],
100-(cast(((cast(count(Education_Level) as decimal(10,2))/(select count(Education_Level) from Bankchurner where Education_Level='High School'))*100) as decimal(10,2))) as [Existing Customers - High School]
from Bankchurner
where Education_Level='High School'
and Attrition_Flag='Attrited Customer'
```
*Output*

<img width="392" alt="Annotation 2022-09-11 043253" src="https://user-images.githubusercontent.com/99955484/189511252-80ee82f9-941b-4e45-9efa-f8b30dbed29d.png">

##### Uneduacted
```SQL
select cast(((cast(count(Education_Level) as decimal(10,2))/(select count(Education_Level) from Bankchurner where Education_Level='Uneducated'))*100) as decimal(10,2)) as [Attrited Customers - Uneducated],
100-(cast(((cast(count(Education_Level) as decimal(10,2))/(select count(Education_Level) from Bankchurner where Education_Level='Uneducated'))*100) as decimal(10,2))) as [Existing Customers - Uneducated]
from Bankchurner
where Education_Level='Uneducated'
and Attrition_Flag='Attrited Customer'

```
*Output* 

<img width="356" alt="Annotation 2022-09-11 043354" src="https://user-images.githubusercontent.com/99955484/189511291-8985b912-0dea-4790-9c67-684563d24176.png">

##### Unknown
```SQL
select cast(((cast(count(Education_Level) as decimal(10,2))/(select count(Education_Level) from Bankchurner where Education_Level='Unknown'))*100) as decimal(10,2)) as [Attrited Customers - Unknown],
100-(cast(((cast(count(Education_Level) as decimal(10,2))/(select count(Education_Level) from Bankchurner where Education_Level='Unknown'))*100) as decimal(10,2))) as [Existing Customers - Unknown]
from Bankchurner
where Education_Level='Unknown'
and Attrition_Flag='Attrited Customer'
```
*Output*

<img width="323" alt="Annotation 2022-09-11 043603" src="https://user-images.githubusercontent.com/99955484/189511331-e2e296f0-c8e0-4c16-a0c3-4b974ae3aec0.png">

**Insights**
- Attrition seems to be directly proportional to eduacation level. As Education level decreases, Attrition decreases also.
-- 

### Income Category
This section deals with how the annual income category of account holders affect attrition.

```SQL
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
```

*Output*

<img width="419" alt="Annotation 2022-09-11 045117" src="https://user-images.githubusercontent.com/99955484/189511659-821fdb95-5c65-4bcc-95c1-92b4ae50b401.png">


















