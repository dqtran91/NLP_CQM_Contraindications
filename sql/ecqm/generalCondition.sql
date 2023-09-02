-- Create table for vte prophylaxis items
DROP TABLE IF EXISTS vte1prophylaxis_items;
CREATE TABLE IF NOT EXISTS vte1prophylaxis_items AS
SELECT DISTINCT
    itemid
FROM d_items
WHERE label ILIKE '%anti-embolism%' -- graduated compression stockings value set
   OR label ILIKE '%compression%'   -- graduated or pneumatic compression devices value set
   OR label ILIKE '%stocking%'
   OR label ILIKE '%pneumatic%'     -- pneumatic compression devices value set
   OR label ILIKE '%venous foot%'   -- venous foot pumps value set
   OR label ILIKE '%foot pump%'
   OR label ILIKE '%heparin%'       -- heparin value set
   OR label ILIKE '%dalteparin%'
   OR label ILIKE '%fragmin%'       -- brand name for dalteparin
   OR label ILIKE '%enoxaparin%'
   OR label ILIKE '%lovenox%'       -- brand name for enoxaparin
   OR label ILIKE '%warfarin%'      -- warfarin value set
   OR label ILIKE '%coumadin%'      -- brand name for warfarin
   OR label ILIKE '%rivaroxaban%'   -- rivaroxaban value set
   OR label ILIKE '%xarelto%'       -- brand name for rivaroxaban
   OR label ILIKE '%apixaban%'      -- factor xa inhibitor value set
   OR label ILIKE '%eliquis%'       -- brand name for apixaban
   OR label ILIKE '%edoxaban%'
   OR label ILIKE '%lixiana%'       -- brand name for edoxaban
   OR label ILIKE '%fondaparinux%'
   OR label ILIKE '%arixtra%'       -- brand name for fondaparinux
   OR label ILIKE '%argatroban%'    -- direct thrombin inhibitor value set
   OR label ILIKE '%acova%'         -- brand name for argatroban
   OR label ILIKE '%bivalirudin%'
   OR label ILIKE '%angiomax%'      -- brand name for bivalirudin
   OR label ILIKE '%dabigatran%'
   OR label ILIKE '%pradaxa%'       -- brand name for dabigatran
   OR label ILIKE '%abciximab%'     -- glycoprotein IIb/IIIa inhibitor value set
   OR label ILIKE '%reopro%'        -- brand name for abciximab
   OR label ILIKE '%eptifibatide%'
   OR label ILIKE '%integrilin%'    -- brand name for eptifibatide
   OR label ILIKE '%tirofiban%'
   OR label ILIKE '%aggrastat%'; -- brand name for tirofiban;
CREATE INDEX idx_vte1prophylaxis_itemid ON vte1prophylaxis_items (itemid);
ANALYSE vte1prophylaxis_items;

-- Create table for vte prophylaxis drugs
DROP TABLE IF EXISTS vte1prophylaxis_prescriptions;
CREATE TABLE IF NOT EXISTS vte1prophylaxis_prescriptions AS
SELECT DISTINCT
    ndc
FROM prescriptions
WHERE drug ILIKE '%anti-embolism%'
   OR drug ILIKE '%heparin%'
   OR drug ILIKE '%dalteparin%'
   OR drug ILIKE '%fragmin%'
   OR drug ILIKE '%enoxaparin%'
   OR drug ILIKE '%lovenox%'
   OR drug ILIKE '%warfarin%'
   OR drug ILIKE '%coumadin%'
   OR drug ILIKE '%rivaroxaban%'
   OR drug ILIKE '%xarelto%'
   OR drug ILIKE '%apixaban%'
   OR drug ILIKE '%eliquis%'
   OR drug ILIKE '%edoxaban%'
   OR drug ILIKE '%lixiana%'
   OR drug ILIKE '%fondaparinux%'
   OR drug ILIKE '%arixtra%'
   OR drug ILIKE '%argatroban%'
   OR drug ILIKE '%acova%'
   OR drug ILIKE '%bivalirudin%'
   OR drug ILIKE '%angiomax%'
   OR drug ILIKE '%dabigatran%'
   OR drug ILIKE '%pradaxa%'
   OR drug ILIKE '%abciximab%'
   OR drug ILIKE '%reopro%'
   OR drug ILIKE '%eptifibatide%'
   OR drug ILIKE '%integrilin%'
   OR drug ILIKE '%tirofiban%'
   OR drug ILIKE '%aggrastat%';
CREATE INDEX idx_vte1prophylaxis_ndc ON vte1prophylaxis_prescriptions (ndc);
ANALYSE vte1prophylaxis_prescriptions;

-- Recreate table for mental-disorder icd9 codes
DROP TABLE IF EXISTS mentaldisorders_icd;
CREATE TABLE IF NOT EXISTS mentaldisorders_icd AS
SELECT
    icd9_code
FROM d_icd_diagnoses
WHERE (LOWER(short_title) IN ('altered mental status', 'developmental dyslexia',
                              'oth learning difficulty', 'mental problems nec', 'prob with communication',
                              'problems with learning',
                              'reading disorder nos') OR long_title ILIKE '%behavioral problem%' OR
       long_title ILIKE '%developmental%disorder%' OR long_title ILIKE '%developmental delay%' OR
       long_title ILIKE '%developmental handicap%' OR long_title ILIKE '%mental condition%' OR
       long_title ILIKE '%mental disorder%')
  AND long_title NOT ILIKE '%arising from mental factors%';
CREATE INDEX idx_mentaldisorders_icd9code ON mentaldisorders_icd (icd9_code);
ANALYSE mentaldisorders_icd;

-- Create table for stroke icd9 codes  https://www.ncbi.nlm.nih.gov/books/NBK559173/
DROP TABLE IF EXISTS stroke_icd;
CREATE TABLE IF NOT EXISTS stroke_icd AS
SELECT
    icd9_code
FROM d_icd_diagnoses
WHERE (long_title ILIKE '%cerebrovascular%' OR short_title ILIKE '%w infrct%' OR
       LOWER(short_title) = 'nonpyogen thrombos sinus')
  AND long_title NOT ILIKE '%late effects of cerebrovascular%'
  AND LOWER(short_title) NOT IN
      ('nontraum extradural hem', 'subdural hemorrhage', 'intracranial hemorr nos', 'cerebrovascular anomaly',
       'family hx-stroke');
CREATE INDEX idx_stroke_icd9code ON stroke_icd (icd9_code);
ANALYSE stroke_icd;

/* Recreate table for Obstetrics*/
DROP TABLE IF EXISTS obstetrics_icd;
CREATE TABLE IF NOT EXISTS obstetrics_icd AS
SELECT DISTINCT
    icd9_code
FROM d_icd_procedures
WHERE long_title ILIKE '%delivery%'
   OR long_title ILIKE '%cesarean%';
CREATE INDEX idx_obstetrics_icd9code ON obstetrics_icd (icd9_code);
ANALYSE obstetrics_icd;


/* Recreate table for VTE admissions*/
DROP TABLE IF EXISTS vte1_admissions;
CREATE TABLE IF NOT EXISTS vte1_admissions AS
SELECT
    hadm_id
FROM admissions
WHERE (diagnosis ILIKE '%embol%' OR diagnosis ILIKE '%thromb%')
  AND diagnosis NOT ILIKE '%acute renal failure%'
  AND diagnosis NOT ILIKE '%anemia%'
  AND diagnosis NOT ILIKE '%chemo embolization%'
  AND diagnosis NOT ILIKE '%chemoembolization%'
  AND diagnosis NOT ILIKE '%fever;thrombocytopenia%'
  AND diagnosis NOT ILIKE '%hypothrombonemia%'
  AND diagnosis NOT ILIKE '%idiopathic thrombocytopenic purpura%'
  AND LOWER(diagnosis) NOT IN ('anemia/thrombocytopneia/fever',
                               'chron''s disease;thromboctopenia;cvid',
                               'dyspnea;thrombocytopenia',
                               'epistaxis;thrombocytopenia',
                               'fractures;thrombocytopenia',
                               'gastrointestinal bleed/thrombocytopenia',
                               'heparin induced thrombocytopenia',
                               'likely thrombocytopenia',
                               'neutropenia;thrombocytopenia',
                               'pneumonia; ams; thrombocytopenia',
                               'renal cell met''s\ cerebral embolication/sda',
                               'sepsis;thrombocytopenia;mental status changes',
                               'thrombocytopenia',
                               'thrombocytopenia; bipolar;depressed;leukocytosis',
                               'thrombocytopenia\epistaxis',
                               'thrombocytopenia,hypoxia',
                               'thrombocytopenia;malaria;telemetry',
                               'thrombocytopenia;neutropenia',
                               'thrombocytopenia;syncope',
                               'thrombocytopenic purpura');
CREATE INDEX idx_vte1_admissions_hadm_id ON vte1_admissions (hadm_id);
ANALYSE vte1_admissions;

/* Recreate table for VTE diagnosis codes*/
DROP TABLE IF EXISTS vte1_icd9;
CREATE TABLE IF NOT EXISTS vte1_icd9 AS
SELECT
    icd9_code
FROM d_icd_diagnoses
WHERE (long_title ILIKE '%embol%' OR long_title ILIKE '%thromb%')
  AND long_title NOT ILIKE '%abortion%'
  AND long_title NOT ILIKE '%antepartum%'
  AND long_title NOT ILIKE '%obstetrical%'
  AND long_title NOT ILIKE '%personal history%'
  AND long_title NOT ILIKE '%pregnancy%'
  AND long_title NOT ILIKE '%with cerebral infarction%'
  AND LOWER(short_title) NOT IN ('essntial thrombocythemia',
                                 'heparin-indu thrombocyto',
                                 'immune thrombocyt purpra',
                                 'lng use antiplte/thrmbtc',
                                 'neonatal thrombocytopen',
                                 'prim thrombocytopen nec',
                                 'purpura nos',
                                 'sec thrombocytpenia nec',
                                 'thromboangiit obliterans',
                                 'thrombocytopenia nos');
CREATE INDEX idx_vte1_icd9code ON vte1_icd9 (icd9_code);
ANALYSE vte1_icd9;

/* Recreate table for principal VTE diagnosis*/
DROP TABLE IF EXISTS vte1_principal_diagnosis;
CREATE TABLE IF NOT EXISTS vte1_principal_diagnosis AS
SELECT
    hadm_id
FROM diagnoses_icd
WHERE icd9_code IN (SELECT icd9_code FROM vte1_icd9);
-- AND seq_num = 1;
CREATE INDEX idx_vte1_principal_diagnosis_hadm_id ON vte1_principal_diagnosis (hadm_id);
ANALYSE vte1_principal_diagnosis;

/* Recreate table for VTE encounters*/
DROP TABLE IF EXISTS vte1_encounters;
CREATE TABLE IF NOT EXISTS vte1_encounters AS
SELECT
    hadm_id
FROM vte1_admissions
UNION
DISTINCT
SELECT
    hadm_id
FROM vte1_principal_diagnosis;
CREATE INDEX idx_vte1_encounters_hadmid ON vte1_encounters (hadm_id);
ANALYSE vte1_encounters;

/* */




