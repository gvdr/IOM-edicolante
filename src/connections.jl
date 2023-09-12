function query_oskar_id(idkeyword)
    query = """
    select  'Ser_'||cast($(idkeyword) as text), 
          cast(dt_date as timestamp), 
          tools.int2real_trunc(vl_x,vl_max) as vl_value
--          vl_x*(1+vl_max)*1/(pow(2.0,15)-1)-1 as old_value,
--          tools.real2int(cast(0 as float), vl_max) as vl_0,
--          vl_x, 
--          vl_max
--  case when vl_weight_hex='NA' then null 
--       else concat('x',vl_weight_hex)::bit(8)::int end as vl_weight
  from 
  (SELECT $(idkeyword),  
    concat(dt_date::text,' ', to_char(hh,'fm00'), ':00:00') as dt_date,
    case  when hh=0 then v00
      when hh=1 then v01 
      when hh=2 then v02
      when hh=3 then v03 
      when hh=4 then v04
      when hh=5 then v05
      when hh=6 then v06 
      when hh=7 then v07 
      when hh=8 then v08 
      when hh=9 then v09 
      when hh=10 then v10 
      when hh=11 then v11 
      when hh=12 then v12 
      when hh=13 then v13 
      when hh=14 then v14 
      when hh=15 then v15 
      when hh=16 then v16 
      when hh=17 then v17 
      when hh=18 then v18
      when hh=19 then v19 
      when hh=20 then v20 
      when hh=21 then v21
      when hh=22 then v22 
      when hh=23 then v23
    end as vl_x, 
     vl_value_max as vl_max
  FROM alarm.ts_data as A,
  (SELECT * FROM generate_series(0, 23) as hh ) as B
  )  as aux00
  WHERE vl_x is not null 
    and $(idkeyword) in ("+whereClause+") 
  order by $(idkeyword), dt_date
  ";
  """ 
  return query
end

function Oskar_string()
    connection_string = "postgres://$(ENV["OSKARUSER"]):$(ENV["OSKARPASSWORD"])@$(ENV["OSKARHOST"]):5432/$(ENV["OSKARNAME"])"
    return connection_string
end