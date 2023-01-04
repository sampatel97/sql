WITH tran_info AS(
    SELECT tran_fact.*, lkp_state_details.population_cnt, lkp_state_details.potential_customer_cnt
    FROM cards_ingest.tran_fact
    INNER JOIN lkp_data.lkp_state_details ON tran_fact.state_cd = lkp_state_details.state_cd
),

remaining_potential_cust_cost AS(
SELECT tran_date, state_cd,population_cnt, potential_customer_cnt, COUNT(DISTINCT cust_id) as count_per_date, (population_cnt - count_per_date) as num_of_target_customer, ((potential_customer_cnt - count_per_date) * 5) as remaining_potential_cost 
FROM tran_info
GROUP BY tran_date, state_cd, population_cnt,potential_customer_cnt
ORDER BY tran_date, state_cd
),

second_highest_state AS
(
SELECT *,
   DENSE_RANK() OVER (ORDER BY remaining_potential_cost Desc) AS Rnk
FROM remaining_potential_cust_cost
)
SELECT *
FROM second_highest_state
WHERE Rnk=2;