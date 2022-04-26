SELECT
    e.name,
    a.id,
    c.birthday,
    c.name PATIENTNAME,
    CASE round(((SELECT CURRENT_DATE FROM dual) - c.birthday) / 365.242199)
        when 0 THEN round((((SELECT CURRENT_DATE FROM dual) - c.birthday) / 365.242199)* 12)|| ' MESES'
    else
        to_char(round(((SELECT CURRENT_DATE FROM dual) - c.birthday) / 365.242199))
    end as patientage,
    d.name ENTERPRISENAME
FROM capadmission a 
    INNER JOIN glbpatient b on(a.idpatient = b.id)
    INNER JOIN glbperson c on(b.idperson = c.id)
    INNER JOIN glbenterprise d on(a.identerprise = d.id)
    INNER JOIN GlbHealthProvider e on(a.idhealthprovider = e.id)
WHERE
    round(((SELECT CURRENT_DATE FROM dual) - c.birthday) / 365.242199) < 18
    and a.status = 1
ORDER BY
    e.name,
    d.name,
    c.name