* Encoding: UTF-8.


DATASET ACTIVATE    DataSet1.

* Analysis Preparation Wizard for 2012 NSECE* 

CSPLAN ANALYSIS
  /PLAN FILE='C:\Users\tebben.18\OneDrive - The Ohio State University\ESQREM 8725 Capstone\NSECE '+
    'data\2012 NSECE plan.csaplan'
  /PLANVARS ANALYSISWEIGHT=CB_METH_WEIGHT       
  /SRSESTIMATOR TYPE=WOR
  /PRINT PLAN
  /DESIGN STRATA=CB_METH_VSTRATUM CLUSTER=CB_METH_VPSU 
  /ESTIMATOR TYPE=WR.

Dataset Activate DataSet1. 

* Complex Samples Frequencies 2012.
CSTABULATE
  /PLAN FILE='C:\Users\tebben.18\OneDrive - The Ohio State University\ESQREM 8725 Capstone\NSECE '+
    'data\2012 NSECE plan.csaplan'
  /TABLES VARIABLES=CB_D8_WHYSTOP
  /CELLS POPSIZE TABLEPCT
  /STATISTICS SE CIN(95) DEFFSQRT 
  /MISSING SCOPE=TABLE CLASSMISSING=EXCLUDE.

FREQUENCIES VARIABLES=CB_D8_WHYSTOP
  /STATISTICS=STDDEV VARIANCE SEMEAN
  /ORDER=ANALYSIS.

DATASET ACTIVATE DataSet1.
PRESERVE.
begin program python3.
import tempfile, spss, random, spssaux
try:
    tempdir = tempfile.gettempdir()
    spss.Submit(r"""CD "%s".""" % tempdir)
    spss.Submit("""SET PRINTBACK=OFF MPRINT=OFF.""")
    activeds = spss.ActiveDataset()
    if activeds == "*":
        activeds = "D" + str(random.random())
        spss.Submit("DATASET NAME %s" % activeds)
    spss.Submit(r"""
SPLIT FILE OFF.
OMS
  /SELECT ALL
  /IF COMMANDS=['Descriptives']
  /DESTINATION VIEWER=NO.
OMS
  /SELECT TABLES
  /IF COMMANDS=['Descriptives'] SUBTYPES=['Descriptive Statistics']
  /DESTINATION FORMAT=SAV NUMBERED=TableNumber_
   OUTFILE='PD_temp'.
DATASET DECLARE PD_temp WINDOW=HIDDEN.
DESCRIPTIVES VARIABLES=CB_D8_WHYSTOP
  /STATISTICS=MEAN STDDEV VARIANCE.
OMSEND.
DATASET ACTIVATE PD_temp WINDOW=ASIS.
COMPUTE Std.Deviation=Std.Deviation*SQRT((N-1)/N).
COMPUTE Variance=Variance*((N-1)/N).
VARIABLE LABELS Var1 ' '.
OMS
  /SELECT ALL
  /IF COMMANDS=['Alter Type']
  /DESTINATION VIEWER=NO
  /TAG = 'PD_NoATO'.
ALTER TYPE N (A14)
  /PRINT NONE.
OMSEND TAG=['PD_NoATO'].
DELETE VARIABLES TableNumber_ TO Label_.
OMS
  /SELECT TABLES
  /IF COMMANDS=['Population Descriptives'] SUBTYPES=['Notes']
  /DESTINATION VIEWER=NO
  /TAG = 'PD_NoNotes'.
OMS
  /SELECT TEXTS
  /IF COMMANDS=['Population Descriptives'] LABELS=['Active Dataset']
  /DESTINATION VIEWER=NO
  /TAG = 'PD_NoDSN'.""")
    from spss import CellText
    rlabels=[]
    data=[]
    cur=spss.Cursor()
    for i in range(0,spss.GetCaseCount()):
        datarow=cur.fetchone()
        data.append(datarow[1:])
        rlabels.append(datarow[0])
    cur.close()
    def _flatten(seq):
        for item in seq:
            if spssaux._isseq(item):
                for subitem in _flatten(item):
                    yield subitem
            else:
                yield item
    data=[item for item in _flatten(data)]
    def _blank(seq):
        for item in seq:
            if item is None:
                yield ' '
            else:
                yield item
    data=[item for item in _blank(data)]
    caption=("Std. Deviation and Variance use N rather than N-1 in denominators.")
    spss.StartProcedure("Population Descriptives")
    table1=spss.BasePivotTable("Population Descriptive Statistics",
                                "Population Descriptive Statistics",caption=caption)
    rowlabels=[(CellText.String(rlabels[i])) for i in range(len(rlabels))]
    collabels=[spss.GetVariableLabel(1),spss.GetVariableLabel(2),spss.GetVariableLabel(3), \
                spss.GetVariableLabel(4)]
    table1.SimplePivotTable(rowdim=""" """,
                rowlabels=rowlabels,
                coldim="",
                collabels=collabels,
                cells=data)
    spss.EndProcedure()
finally:
    try:
        spss.Submit("""
OMSEND TAG=['PD_NoNotes'].
OMSEND TAG=['PD_NoDSN'].
DATASET CLOSE PD_temp.
DATASET ACTIVATE %s WINDOW=ASIS""" % activeds)
    except:
        pass
end program.
RESTORE.


DATASET ACTIVATE DataSet3.
* Analysis Preparation Wizard for 2019 NSECE* 

CSPLAN ANALYSIS
  /PLAN FILE='C:\Users\tebben.18\OneDrive - The Ohio State University\ESQREM 8725 Capstone\NSECE '+
    'data\2019 NSECE plan.csaplan'
  /PLANVARS ANALYSISWEIGHT=CB9_METH_WEIGHT       
  /SRSESTIMATOR TYPE=WOR
  /PRINT PLAN
  /DESIGN STRATA=CB9_METH_VSTRATUMPU CLUSTER=CB9_METH_VPSUPU 
  /ESTIMATOR TYPE=WR.


DATASET ACTIVATE DataSet3.
* Complex Samples Frequencies.
CSTABULATE
  /PLAN FILE='C:\Users\tebben.18\OneDrive - The Ohio State University\ESQREM 8725 Capstone\NSECE '+
    'data\2019 NSECE plan.csaplan'
  /TABLES VARIABLES=CB9_ENRL_DENY_BEHAVIOR
  /CELLS POPSIZE TABLEPCT
  /STATISTICS SE CIN(95) DEFF 
  /MISSING SCOPE=TABLE CLASSMISSING=EXCLUDE.

FREQUENCIES VARIABLES=CB9_ENRL_DENY_BEHAVIOR
  /STATISTICS=STDDEV VARIANCE SEMEAN
  /ORDER=ANALYSIS.


DATASET ACTIVATE DataSet3.
PRESERVE.
begin program python3.
import tempfile, spss, random, spssaux
try:
    tempdir = tempfile.gettempdir()
    spss.Submit(r"""CD "%s".""" % tempdir)
    spss.Submit("""SET PRINTBACK=OFF MPRINT=OFF.""")
    activeds = spss.ActiveDataset()
    if activeds == "*":
        activeds = "D" + str(random.random())
        spss.Submit("DATASET NAME %s" % activeds)
    spss.Submit(r"""
SPLIT FILE OFF.
OMS
  /SELECT ALL
  /IF COMMANDS=['Descriptives']
  /DESTINATION VIEWER=NO.
OMS
  /SELECT TABLES
  /IF COMMANDS=['Descriptives'] SUBTYPES=['Descriptive Statistics']
  /DESTINATION FORMAT=SAV NUMBERED=TableNumber_
   OUTFILE='PD_temp'.
DATASET DECLARE PD_temp WINDOW=HIDDEN.
DESCRIPTIVES VARIABLES=CB9_ENRL_DENY_BEHAVIOR
  /STATISTICS=MEAN STDDEV VARIANCE.
OMSEND.
DATASET ACTIVATE PD_temp WINDOW=ASIS.
COMPUTE Std.Deviation=Std.Deviation*SQRT((N-1)/N).
COMPUTE Variance=Variance*((N-1)/N).
VARIABLE LABELS Var1 ' '.
OMS
  /SELECT ALL
  /IF COMMANDS=['Alter Type']
  /DESTINATION VIEWER=NO
  /TAG = 'PD_NoATO'.
ALTER TYPE N (A14)
  /PRINT NONE.
OMSEND TAG=['PD_NoATO'].
DELETE VARIABLES TableNumber_ TO Label_.
OMS
  /SELECT TABLES
  /IF COMMANDS=['Population Descriptives'] SUBTYPES=['Notes']
  /DESTINATION VIEWER=NO
  /TAG = 'PD_NoNotes'.
OMS
  /SELECT TEXTS
  /IF COMMANDS=['Population Descriptives'] LABELS=['Active Dataset']
  /DESTINATION VIEWER=NO
  /TAG = 'PD_NoDSN'.""")
    from spss import CellText
    rlabels=[]
    data=[]
    cur=spss.Cursor()
    for i in range(0,spss.GetCaseCount()):
        datarow=cur.fetchone()
        data.append(datarow[1:])
        rlabels.append(datarow[0])
    cur.close()
    def _flatten(seq):
        for item in seq:
            if spssaux._isseq(item):
                for subitem in _flatten(item):
                    yield subitem
            else:
                yield item
    data=[item for item in _flatten(data)]
    def _blank(seq):
        for item in seq:
            if item is None:
                yield ' '
            else:
                yield item
    data=[item for item in _blank(data)]
    caption=("Std. Deviation and Variance use N rather than N-1 in denominators.")
    spss.StartProcedure("Population Descriptives")
    table1=spss.BasePivotTable("Population Descriptive Statistics",
                                "Population Descriptive Statistics",caption=caption)
    rowlabels=[(CellText.String(rlabels[i])) for i in range(len(rlabels))]
    collabels=[spss.GetVariableLabel(1),spss.GetVariableLabel(2),spss.GetVariableLabel(3), \
                spss.GetVariableLabel(4)]
    table1.SimplePivotTable(rowdim=""" """,
                rowlabels=rowlabels,
                coldim="",
                collabels=collabels,
                cells=data)
    spss.EndProcedure()
finally:
    try:
        spss.Submit("""
OMSEND TAG=['PD_NoNotes'].
OMSEND TAG=['PD_NoDSN'].
DATASET CLOSE PD_temp.
DATASET ACTIVATE %s WINDOW=ASIS""" % activeds)
    except:
        pass
end program.
RESTORE.
