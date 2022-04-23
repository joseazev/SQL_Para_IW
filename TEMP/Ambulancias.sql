/* 2283 com.iw.visualLayer.report.IwExecReport*/

SELECT
    b.idadmission,
    e.name,
    g.name,
    f.translation,
    l.price,
    to_char(a.startdate,'dd/mm/yyyy') startdate,
    to_char(a.enddate,'dd/mm/yyyy') enddate,
    a.cause,
    a.instructions
FROM capmobileunitevent a 
    INNER JOIN capmobileunitadm b on(a.idmobileunitadm = b.ID)
    INNER JOIN capadmission c on(b.idadmission = c.id)
    INNER JOIN glbpatient d on(c.idpatient = d.id)
    INNER JOIN glbperson e on(d.idperson = e.id)
    INNER JOIN IFRCONSTANTITEM f on(f.keyindex = a.attendtype)
    INNER JOIN glbenterprise g on(c.identerprise = g.id)
    INNER JOIN CTRCONTRACT h on(g.id = h.identerprise)
    LEFT JOIN ctrpricecfg i on(h.id = i.idcontract)
    LEFT JOIN CTRPRICELSTVERSION j on(i.idpricemobunitevt = j.idpricelist)
    LEFT JOIN ctrpricelistitem l on(j.id = l.idpricelstversion)
WHERE
    a.startdate >= TO_DATE('01/02/2021','dd/mm/yyyy')
    and f.idconstant = 92
    and a.scmobileunit = l.sccode
    or a.scmobileunit is null
