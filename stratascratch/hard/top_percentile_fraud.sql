-- We want to identify the most suspicious claims in each state. 
-- We'll consider the top 5 percentile of claims with the highest
-- fraud scores in each state as potentially fraudulent.

-- Your output should include the policy number, state, claim cost,
-- and fraud score.

with percentiles as 
(select 
    state,
    percentile_cont(0.05) within group(order by fraud_score desc) as percentile
from fraud_score
group by state
)

select 
    f.policy_num,
    f.state,
    f.claim_cost,
    f.fraud_score 
from percentiles p join fraud_score f
    on p.state = f.state
where p.state = f.state and f.fraud_score >= p.percentile
