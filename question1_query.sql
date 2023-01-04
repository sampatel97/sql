WITH tran_info AS(
    SELECT tran_fact.*, lkp_state_details.population_cnt, lkp_state_details.potential_customer_cnt
    FROM cards_ingest.tran_fact
    INNER JOIN lkp_data.lkp_state_details ON tran_fact.state_cd = lkp_state_details.state_cd
)

SELECT tran_date, state_cd,population_cnt, COUNT(DISTINCT cust_id) as count_per_date, (population_cnt - count_per_date) as num_of_target_customer
FROM tran_info
GROUP BY tran_date, state_cd, population_cnt
ORDER BY tran_date, state_cd;