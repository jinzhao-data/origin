SELECT udid
FROM TABLE
WHERE dt >= '20181012'
    AND dt <= '201814'
    AND eventid = 'app_start'
    AND PARAMETERS['from'] = '3'