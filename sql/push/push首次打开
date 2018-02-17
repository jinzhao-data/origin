SELECT t12.model,t12.applock,t12.systemlock,count(t12.udid) as c
FROM
  (SELECT t1.udid,t1.model,
          t1.applock,
          t1.systemlock,
          Row_Number() OVER (PARTITION BY t1.udid
                             ORDER BY cast(t1.logtime AS bigint)) AS rank
   FROM
     (SELECT udid,model,
             eventparams['sysOpen'] AS systemlock,
             eventparams['setOpen'] AS applock,
             logtime
      FROM dwv_mp.dwv_mp_lite_sdk
      WHERE dt BETWEEN 20171120 AND 20171126
        AND is_first_test = TRUE
        AND eventid = 'push_arrive' ) t1
   RIGHT JOIN
     (SELECT udid
      FROM dwmf_bobo.dwm_bobo_sdk_new_device
      WHERE dt BETWEEN 20171120 AND 20171126 ) t2 ON t1.udid = t2.udid) t12
WHERE t12.rank = 1
GROUP BY t12.model,t12.applock,t12.systemlock
