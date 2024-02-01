/*
 Denominator:

 "Initial Population"

  Reference:
    Electronic Clinical Quality Improvement. (May 17, 2023). Venous Thromboembolism Prophylaxis. Population Criteria section. https://ecqi.healthit.gov/sites/default/files/ecqm/measures/CMS108v11.html
 */
CREATE VIEW cms108.denominator AS
SELECT * FROM cms108.initial_population;