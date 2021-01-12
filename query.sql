select 
    i.*, 
    a.postalcode,
    c.causeofactiontype, 
    c.interestfromdate, 
    c.amount, 
    e.eventname, 
    e.fileddate as eventfileddate, 
    e.feetype, 
    e.filingpartiesroles, 
    e.answertype,
    --date_trunc('week', i.fileddate)::date as week,
    case when (
    court in 	(
                'New York County Civil Court', 
                'Kings County Civil Court',
                'Queens County Civil Court',
                'Bronx County Civil Court',
                'Richmond County Civil Court',
                'Redhook Community Justice Center',
                'Harlem Community Justice Center'
                )
    )
    then 'NYC' 
    else 'Outside NYC' end as region,
    case when ( court = 'New York County Civil Court') 
    then 'Manhattan' else 'Not Manhattan' end as manhattan
from oca_index i 
left join oca_causes c on c.indexnumberid = i.indexnumberid
left join oca_events e on e.indexnumberid = i.indexnumberid 
left join oca_addresses a on a.indexnumberid = i.indexnumberid
where i.fileddate >= '03-23-2020' and i.classification = any('{Holdover,Non-Payment}') 
order by i.fileddate asc 