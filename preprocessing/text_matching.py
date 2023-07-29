import pandas as pd
import numpy as np
import re


class TextMatching:
    # common regex patterns
    common_bt_reg = 'anticoagula(?:nt|tion)|bood thinner|antiplatelets'
    anticoagulant_reg = 'anticoagul|aspirin|lovenox|enoxaparin|heparin'
    blood_thinner_reg = 'argatroban|dabigatran|warfarin|jantoven|coumadin'
    dti_reg = 'direct thrombin inhibitor|refludan|lepirudin|bivalirudin'
    gp_inhibitor_reg = 'iib/iiia inhibitor|abciximab|integrilin,eptifibatide|tirofiban,plavix,clopidogrel'
    xa_inhibitor_reg = 'xa inhibitor|xarelto|rivaroxaban|eliquis|apixaban|arixtra|fondaparinux|savaysa|edoxaban' \
                       '|bevyxxa|betrixaban'
    phys_reg = 'foot pumps|pneumatic compression|compression stockings|sequential compression|ambulation|leg exercise' \
               '|early mobilization'

    refuse_reg = '(?:avoid|declin|refus)(?:e[sd]?|ing)?'
    allergy_reg = 'allerg(?:i(?:es|c)|y)'
    neg_reaction_reg = \
        f'(?:(?<!positive)) (?:serious|negative|{allergy_reg})? ' \
        f'?(?:interaction|reaction|{allergy_reg}|contraindication) (?:with|to)?'

    regEx_inter = {
        'venous thromboembolism': r'(\Wvte\W|venous thromboembolism)',
        'deep vein thrombosis': r'(\Wdvt\W|deep vein thrombosis|deep venous thrombosis)',
        'pulmonary embolism': '(pulmonary embolism|pulmonary arterial embolism)',
        'cerebral venous thrombosis': r'(\Wcvt\W|cerebral venous thrombosis)',
        'arterial thromboembolism': '(arterial (?:thrombo)?embolism)',
        'disseminated intravascular coagulation ': r'(\Wdic\W|disseminated intravascular coagulation )',
        'thromboembolic': '(thromboembolic|thrombotic)',
        'thrombus|embolus|blood clot': '(thromb(?:oembolus|us|os)|blood clot)',
        'superior vena cava obstruction': '(superior vena cava obstruction)',
        'atrial fibrillation': '(atrial fibrillation)',
        'd-dimer': '(d-dimer)',
        'duplex ultrasound': '(duplex ultrasound)',
        'angiography': '(ct|computed tomography|pulmonary) angiography',
        'troponin': '(troponin)',
        'thrombectomy': '(thrombectomy)',
        'prothrombin time': '(prothrombin time)',
        'international normalized ratio': r'(\Winr\W|international normalized ratio)',
        'prophylaxis': r'(\Wppx\W|prophylaxis|prophylactic)',
        'dvt prophylaxis': '(dvt prophylaxis)',
        'CABG|PCI': r'(\Wcabg\W|\Wpci\W|coronary artery bypass grafting|percutaneous coronary intervention)',
        'inferior vena cava': r'(\Wivc\W|inferior vena cava|greenfield filter)',
        'thrombolytic therapy|tissue plasminogen activator': '(thrombolytic| tpa |tissue plasminogen activator)',
        f'{blood_thinner_reg}': f'({blood_thinner_reg})',
        f'{anticoagulant_reg}': f'({anticoagulant_reg})',
        f'{dti_reg}': f'({dti_reg})',
        f'{gp_inhibitor_reg}': f'({gp_inhibitor_reg})',
        f'{xa_inhibitor_reg}': f'({xa_inhibitor_reg})',
        'prophylaxis device': f'({phys_reg})',
        'hip|knee replacement': '((?:hip|knee) replacement)',
        'surgery|procedure': '(surgery|procedure)',
        'denEx:ICU': r'(\Wicu\W)',
        'denEx:surgical care improvement project': r'(\Wscip\W|surgical care improvement project)',
        'denEx:mental disorder': '(mental disorder)',
        'denEx:stroke': '(stroke)',
        'denEx:intervention comfort measures': '(intervention comfort measures)'
    }

    #Plavix
    regEx_neg = {
        'contraindication|negation': '((?:(?<!no ))contraindication|contraindicate|negation)',
        'allergies': f'({allergy_reg})',
        'thrombolytic contraindication|negation':
            '((?:thrombolytic|anticoagulant) (?:was|is) (?:contraindicated|negated))',
        'refuse|decline': f'((?:patient|pt|he|she) (?:ha[s|d])? ?{refuse_reg})',
        'refuse prophylaxis': f'({refuse_reg} (?:dvt|vte)? ?(?:ppx|prophylaxis))',
        'refuse thrombocytopenia': f'({refuse_reg} thrombocytopenia)',
        f'refuse {common_bt_reg}|{anticoagulant_reg}': f'({refuse_reg} (?:{common_bt_reg}|{anticoagulant_reg}))',
        f'refuse {blood_thinner_reg}': f'({refuse_reg} (?:{blood_thinner_reg}))',
        f'refuse {dti_reg}': f'({refuse_reg} (?:{dti_reg}))',
        f'refuse {gp_inhibitor_reg}': f'({refuse_reg} (?:{gp_inhibitor_reg}))',
        f'refuse {xa_inhibitor_reg}': f'({refuse_reg} (?:{xa_inhibitor_reg}))',
        'refuse physical prophylaxis': f'({refuse_reg} (?:{phys_reg}))',
        'did not tolerate': r'((?:did|could)(?: not|n\Wt|nt) tolerate)',
        'negative reaction': f'({neg_reaction_reg})',
        f'negative reaction to {anticoagulant_reg}': f'({neg_reaction_reg} (?:{common_bt_reg}|{anticoagulant_reg}))',
        f'negative reaction to {blood_thinner_reg}': f'({neg_reaction_reg} (?:{blood_thinner_reg}))',
        f'negative reaction to {dti_reg}': f'({neg_reaction_reg} (?:{dti_reg}))',
        f'negative reaction to {gp_inhibitor_reg}': f'({neg_reaction_reg} (?:{gp_inhibitor_reg}))',
        f'negative reaction to {xa_inhibitor_reg}': f'({neg_reaction_reg} (?:{xa_inhibitor_reg}))',
        'negative reaction to physical prophylaxis': f'({neg_reaction_reg} (?:{phys_reg}))',
        'induced thrombocytopenia': '(induced thrombocytopenia)',
        'non-candidate thrombolytic': '(not a candidate for (?:a|the)? ?(?:thrombolytic|anti_?coagulation))',
        'should not have anticoagulation': f'(should (?:not have|should not receive) {anticoagulant_reg})'
    }

    @classmethod
    def apply_reg_ex(cls, _df: pd.DataFrame, text_col: str) -> pd.DataFrame:
        """
        return a dataframe with the applied regex to the text column
        """
        # for each regex pattern, extract all matching capture groups as one string
        _df["regEx_inter"] = ''
        for key, value in cls.regEx_inter.items():
            _df[key] = \
                _df[text_col].str.extractall(value, flags=re.IGNORECASE).groupby(level=0).agg(','.join)
            _df["regEx_inter"] = np.where(_df[key].notnull(), _df["regEx_inter"] + ',' + key,
                                          _df["regEx_inter"])

        _df["regEx_neg"] = ''
        for key, value in cls.regEx_neg.items():
            _df[key] = _df['text'].str.extractall(value, flags=re.IGNORECASE).groupby(level=0).agg(','.join)
            _df["regEx_neg"] = np.where(_df[key].notnull(), _df["regEx_neg"] + ',' + key, _df["regEx_neg"])

        # clean up of new columns by removing initial ','
        _df["regEx_inter"] = _df["regEx_inter"].map(lambda x: x[1:])
        _df["regEx_neg"] = _df["regEx_neg"].map(lambda x: x[1:])

        # clean up of new columns by placing '' with nan
        _df.loc[_df["regEx_inter"] == '', 'regEx_inter'] = np.nan
        _df.loc[_df["regEx_neg"] == '', 'regEx_neg'] = np.nan

        return _df
