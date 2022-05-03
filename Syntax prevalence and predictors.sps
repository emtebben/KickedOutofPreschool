* Encoding: UTF-8.
***2012 sample***

DATASET ACTIVATE DataSet1.

* Complex Samples Frequencies.
CSTABULATE
  /PLAN FILE='C:\Users\tebben.18\OneDrive - The Ohio State University\ESQREM 8725 Capstone\NSECE '+
    'data\2012 simple.csaplan'
  /TABLES VARIABLES=expel
  /CELLS POPSIZE TABLEPCT
  /STATISTICS SE CIN(95) COUNT 
  /MISSING SCOPE=TABLE CLASSMISSING=EXCLUDE.

*Logistic regression, no weighting

LOGISTIC REGRESSION VARIABLES expel
  /METHOD=ENTER turnover hs_pct ccsub_pct pk_pct enroll_tot for_profit non_profit ratio spec_tot 
    iep_pct black_pct group_size fam_serv_tot pd_tot ben_tot 
  /CONTRAST (for_profit)=Indicator(1)
  /CONTRAST (non_profit)=Indicator(1)
  /SAVE=PRED PGROUP RESID ZRESID
  /CLASSPLOT
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

* Complex Samples Logistic Regression.
CSLOGISTIC  expel(LOW) WITH turnover hs_pct ccsub_pct pk_pct enroll_tot for_profit non_profit 
    ratio spec_tot iep_pct black_pct group_size fam_serv_tot pd_tot ben_tot
  /PLAN FILE='C:\Users\tebben.18\OneDrive - The Ohio State University\ESQREM 8725 Capstone\NSECE '+
    'data\2012 simple.csaplan' 
  /MODEL turnover hs_pct ccsub_pct pk_pct enroll_tot for_profit non_profit ratio spec_tot iep_pct 
    black_pct group_size fam_serv_tot pd_tot ben_tot
  /INTERCEPT INCLUDE=YES SHOW=YES
  /STATISTICS PARAMETER SE CINTERVAL TTEST
  /TEST TYPE=F PADJUST=LSD
  /ODDSRATIOS COVARIATE=[for_profit(1)]
  /ODDSRATIOS COVARIATE=[non_profit(1)]
  /ODDSRATIOS COVARIATE=[spec_tot(1)]
  /ODDSRATIOS COVARIATE=[group_size(1)]
  /ODDSRATIOS COVARIATE=[enroll_tot(1)]
  /ODDSRATIOS COVARIATE=[turnover(.1)]
  /ODDSRATIOS COVARIATE=[hs_pct(10)]
  /ODDSRATIOS COVARIATE=[ccsub_pct(10)]
  /SAVE PREDVAL PREDPROB
  /MISSING CLASSMISSING=EXCLUDE
  /CRITERIA MXITER=100 MXSTEP=5 PCONVERGE=[1e-006 RELATIVE] LCONVERGE=[0] CHKSEP=20 CILEVEL=95
  /PRINT SUMMARY CLASSTABLE COVB VARIABLEINFO SAMPLEINFO.

***2019 Sample***

DATASET ACTIVATE    DataSet2.

 *Complex Samples Frequencies.

CSTABULATE
  /PLAN FILE='C:\Users\tebben.18\OneDrive - The Ohio State University\ESQREM 8725 Capstone\NSECE '+
    'data\2019 simple.csaplan'
  /TABLES VARIABLES=expel
  /CELLS POPSIZE TABLEPCT
  /STATISTICS SE CIN(95) COUNT 
  /MISSING SCOPE=TABLE CLASSMISSING=EXCLUDE.

*Logistic regression, no weighting

LOGISTIC REGRESSION VARIABLES expel
  /METHOD=ENTER turnover hs_pct ccsub_pct pk_pct enroll_tot for_profit non_profit ratio spec_tot 
    iep_pct black_pct group_size fam_serv_tot pd_tot ben_tot 
  /CONTRAST (for_profit)=Indicator(1)
  /CONTRAST (non_profit)=Indicator(1)
  /SAVE=PRED PGROUP RESID ZRESID
  /CLASSPLOT
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

* Complex Samples Logistic Regression.
CSLOGISTIC  expel(LOW) WITH turnover hs_pct ccsub_pct pk_pct enroll_tot for_profit non_profit 
    ratio spec_tot iep_pct black_pct group_size fam_serv_tot pd_tot ben_tot
  /PLAN FILE='C:\Users\tebben.18\OneDrive - The Ohio State University\ESQREM 8725 Capstone\NSECE '+
    'data\2019 simple.csaplan' 
  /MODEL turnover hs_pct ccsub_pct pk_pct enroll_tot for_profit non_profit ratio spec_tot iep_pct 
    black_pct group_size fam_serv_tot pd_tot ben_tot
  /INTERCEPT INCLUDE=YES SHOW=YES
  /STATISTICS PARAMETER SE CINTERVAL TTEST
  /TEST TYPE=F PADJUST=LSD
  /ODDSRATIOS COVARIATE=[for_profit(1)]
  /ODDSRATIOS COVARIATE=[non_profit(1)]
  /ODDSRATIOS COVARIATE=[spec_tot(1)]
  /ODDSRATIOS COVARIATE=[group_size(1)]
  /ODDSRATIOS COVARIATE=[enroll_tot(1)]
  /ODDSRATIOS COVARIATE=[turnover(.1)]
  /ODDSRATIOS COVARIATE=[hs_pct(10)]
  /ODDSRATIOS COVARIATE=[ccsub_pct(10)]
  /SAVE PREDVAL PREDPROB
  /MISSING CLASSMISSING=EXCLUDE
  /CRITERIA MXITER=100 MXSTEP=5 PCONVERGE=[1e-006 RELATIVE] LCONVERGE=[0] CHKSEP=20 CILEVEL=95
  /PRINT SUMMARY CLASSTABLE COVB VARIABLEINFO SAMPLEINFO.

