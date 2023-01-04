WITH tran_info AS(
    SELECT tran_fact.*, lkp_state_details.population_cnt, lkp_state_details.potential_customer_cnt
    FROM cards_ingest.tran_fact
    INNER JOIN lkp_data.lkp_state_details ON tran_fact.state_cd = lkp_state_details.state_cd
)

SELECT * FROM tran_info 
ORDER BY state_cd, tran_date;
