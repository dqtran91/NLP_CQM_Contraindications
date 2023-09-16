-- Create table for vte prophylaxis items
DROP TABLE IF EXISTS vte1prophylaxis_items;
CREATE TABLE IF NOT EXISTS vte1prophylaxis_items AS
SELECT DISTINCT itemid
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
SELECT DISTINCT ndc
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
SELECT icd9_code
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
SELECT icd9_code
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
SELECT DISTINCT icd9_code
FROM d_icd_procedures
WHERE long_title ILIKE '%delivery%'
   OR long_title ILIKE '%cesarean%';
CREATE INDEX idx_obstetrics_icd9code ON obstetrics_icd (icd9_code);
ANALYSE obstetrics_icd;


/* Recreate table for VTE admissions*/
DROP TABLE IF EXISTS vte1_admissions;
CREATE TABLE IF NOT EXISTS vte1_admissions AS
SELECT hadm_id
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
SELECT icd9_code
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
SELECT hadm_id
FROM diagnoses_icd
WHERE icd9_code IN (SELECT icd9_code FROM vte1_icd9);
-- AND seq_num = 1;
CREATE INDEX idx_vte1_principal_diagnosis_hadm_id ON vte1_principal_diagnosis (hadm_id);
ANALYSE vte1_principal_diagnosis;

/* Recreate table for VTE encounters*/
DROP TABLE IF EXISTS vte1_encounters;
CREATE TABLE IF NOT EXISTS vte1_encounters AS
SELECT hadm_id
FROM vte1_admissions
UNION
DISTINCT
SELECT hadm_id
FROM vte1_principal_diagnosis;
CREATE INDEX idx_vte1_encounters_hadmid ON vte1_encounters (hadm_id);
ANALYSE vte1_encounters;

/*
 Recreate table for surgical care improvement project (SCIP) value set
 icd10 to icd9 mappings https://www.cms.gov/medicare/coding/icd10/downloads/icd-10_gem_fact_sheet.pdf
 */
DROP TABLE IF EXISTS scip_codes;
CREATE TABLE IF NOT EXISTS scip_codes AS
    /*
    general surgery value set, for thoracic and abdominal, except for cardiac procedures
    oid: 2.16.840.1.113883.3.117.1.7.1.255
    version: eCQM Update 2022-05-05
    url: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.255/expansion/eCQM%20Update%202022-05-05
    */
SELECT icd9_code
FROM d_icd_procedures
WHERE (long_title ILIKE '%adrenalectomy%' OR long_title ILIKE '%autologous%' OR long_title ILIKE '%coagulation%' OR
       long_title ILIKE '%colostomy%' OR long_title ILIKE '%debridement%' OR long_title ILIKE '%decortication%' OR
       long_title ILIKE '%femoral%' OR long_title ILIKE '%frontal%' OR long_title ILIKE '%laparoscopic%' OR
       long_title ILIKE '%lobe%' OR long_title ILIKE '%marsupialization%' OR long_title ILIKE '%myotomy%' OR
       long_title ILIKE '%neuroplasticity%' OR long_title ILIKE '%resection%' OR long_title ILIKE '%sphincter%' OR
       long_title ILIKE '%surgery%' OR long_title ILIKE '%temporal%' OR long_title ILIKE '%trephination%')
  AND LOWER(short_title) NOT IN ('contrast arteriogram-leg',
                                 'contrast phlebogram-leg',
                                 'extracorporeal circulat',
                                 'hypothermia (systemic) incidental to open heart surgery',
                                 'piercing of ear lobe',
                                 'postop vasc op hem contr');


/*
 Recreate table for surgical care improvement project (SCIP) value set
 note: Used AHRQ (Agency for Healthcare Research and Quality) MapIT to convert ICD-10 to ICD-9 for supplemental value set.
 This is based on the general equivalency mappings (GEMs) from CMS. https://www.cms.gov/medicare/coding/icd10/downloads/icd-10_gem_fact_sheet.pdf
 versions: eCQM Update 2022-05-05 & MU2 Update 2012-10-25
 */
SELECT DISTINCT icd9_code
FROM d_icd_procedures
WHERE icd9_code IN (
    /*
    hip replacement surgery value set
    oid: 2.16.840.1.113883.3.117.1.7.1.259
    url: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.259/expansion/
    */
                    '0070',
                    '0071',
                    '0072',
                    '0073',
                    '0074',
                    '0075',
                    '0076',
                    '0077',
                    '0080',
                    '0081',
                    '0082',
                    '0083',
                    '0084',
                    '0085',
                    '0086',
                    '0087',
                    '7609',
                    '7970',
                    '8000',
                    '8001',
                    '8002',
                    '8003',
                    '8004',
                    '8005',
                    '8006',
                    '8007',
                    '8008',
                    '8009',
                    '8010',
                    '8015',
                    '8054',
                    '8151',
                    '8152',
                    '8153',
                    '8196',
                    '8303',
                    '8394',
                    '8459',
                    '8466',
                    '8467',
                    '8468',
    /*
    intracranial neurosurgery value set
    oid: 2.16.840.1.113883.3.117.1.7.1.260
    url: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.260/expansion/
    */
                    '0101',
                    '0109',
                    '0111',
                    '0112',
                    '0113',
                    '0114',
                    '0115',
                    '0118',
                    '0121',
                    '0122',
                    '0123',
                    '0124',
                    '0125',
                    '0128',
                    '0131',
                    '0132',
                    '0139',
                    '0141',
                    '0142',
                    '0151',
                    '0152',
                    '0153',
                    '0159',
                    '016',
                    '0201',
                    '0206',
                    '0207',
                    '0214',
                    '0221',
                    '0222',
                    '0231',
                    '0232',
                    '0233',
                    '0234',
                    '0235',
                    '0239',
                    '0242',
                    '0243',
                    '0293',
                    '0294',
                    '0295',
                    '0301',
                    '1651',
                    '2095',
                    '240',
                    '2412',
                    '244',
                    '247',
                    '2732',
                    '7601',
                    '7609',
                    '7611',
                    '762',
                    '7639',
                    '7645',
                    '8000',
                    '8010',
                    '8030',
                    '8080',
                    '8090',
                    '9359',
                    '9395',
                    '9736',
                    '9923',
    /*
     knee replacement surgery value set
     oid: 2.16.840.1.113883.3.117.1.7.1.261
     url: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.261/expansion/
     */
                    '0070',
                    '0071',
                    '0072',
                    '0073',
                    '0080',
                    '0081',
                    '0082',
                    '0083',
                    '0084',
                    '7609',
                    '7840',
                    '7846',
                    '7860',
                    '7866',
                    '7900',
                    '7920',
                    '7970',
                    '7990',
                    '7999',
                    '8000',
                    '8001',
                    '8002',
                    '8003',
                    '8004',
                    '8005',
                    '8006',
                    '8007',
                    '8008',
                    '8009',
                    '8010',
                    '8016',
                    '8054',
                    '8154',
                    '8155',
                    '8196',
                    '8303',
                    '8394',
                    '8457',
                    '8459',
                    '8466',
                    '8467',
                    '8468',
    /*
     urological surgery value set
     oid: 2.16.840.1.113883.3.117.1.7.1.272
     url: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.272/expansion/
     */
                    '3001',
                    '3342',
                    '3471',
                    '3472',
                    '3473',
                    '3479',
                    '3483',
                    '3985',
                    '3994',
                    '3998',
                    '4284',
                    '4439',
                    '4440',
                    '4441',
                    '4442',
                    '4449',
                    '445',
                    '4461',
                    '4462',
                    '4463',
                    '4468',
                    '4469',
                    '4499',
                    '4531',
                    '4533',
                    '4541',
                    '4550',
                    '4551',
                    '4552',
                    '4561',
                    '4562',
                    '4571',
                    '4576',
                    '4579',
                    '4602',
                    '4604',
                    '4640',
                    '4641',
                    '4642',
                    '4643',
                    '4650',
                    '4651',
                    '4652',
                    '4671',
                    '4672',
                    '4673',
                    '4674',
                    '4675',
                    '4676',
                    '4679',
                    '4693',
                    '4694',
                    '4699',
                    '4792',
                    '4840',
                    '4843',
                    '4849',
                    '4850',
                    '4852',
                    '4861',
                    '4862',
                    '4863',
                    '4864',
                    '4865',
                    '4869',
                    '4871',
                    '4872',
                    '4873',
                    '4879',
                    '4893',
                    '4899',
                    '5136',
                    '5191',
                    '5192',
                    '5193',
                    '5251',
                    '527',
                    '5343',
                    '5349',
                    '5351',
                    '5359',
                    '539',
                    '543',
                    '544',
                    '5461',
                    '5462',
                    '5463',
                    '5464',
                    '5471',
                    '5472',
                    '5473',
                    '5474',
                    '5475',
                    '5499',
                    '5501',
                    '5502',
                    '5503',
                    '5511',
                    '5531',
                    '5532',
                    '5533',
                    '5534',
                    '5535',
                    '5539',
                    '554',
                    '5551',
                    '5552',
                    '5553',
                    '5554',
                    '5581',
                    '5582',
                    '5583',
                    '5587',
                    '5589',
                    '5592',
                    '5599',
                    '5640',
                    '5642',
                    '5651',
                    '5652',
                    '5662',
                    '5671',
                    '5672',
                    '5673',
                    '5674',
                    '5675',
                    '5679',
                    '5682',
                    '5683',
                    '5684',
                    '5686',
                    '5699',
                    '5722',
                    '5759',
                    '576',
                    '5771',
                    '5779',
                    '5781',
                    '5782',
                    '5783',
                    '5784',
                    '5785',
                    '5786',
                    '5787',
                    '5788',
                    '5789',
                    '5793',
                    '5799',
                    '5831',
                    '5839',
                    '5841',
                    '5842',
                    '5843',
                    '5844',
                    '5847',
                    '5849',
                    '5892',
                    '5899',
                    '5900',
                    '5902',
                    '5909',
                    '5979',
                    '5991',
                    '5992',
                    '5999',
                    '6021',
                    '6029',
                    '603',
                    '604',
                    '605',
                    '6069',
                    '6073',
                    '6094',
                    '6498',
                    '6521',
                    '6551',
                    '6561',
                    '6591',
                    '6651',
                    '6731',
                    '674',
                    '6761',
                    '6762',
                    '6769',
                    '6839',
                    '6849',
                    '6869',
                    '688',
                    '689',
                    '6941',
                    '6942',
                    '6949',
                    '6999',
                    '704',
                    '7061',
                    '7062',
                    '7071',
                    '7072',
                    '7073',
                    '7074',
                    '7075',
                    '7079',
                    '7091',
                    '7171',
                    '7172',
                    '7550',
                    '7551',
                    '7552',
                    '7561',
                    '7562',
                    '7569',
                    '758',
                    '7710',
                    '843',
                    '8492',
                    '8493',
                    '8499',
                    '8625',
                    '8628',
                    '8659',
                    '8689',
                    '9625',
                    '9999'
    );

