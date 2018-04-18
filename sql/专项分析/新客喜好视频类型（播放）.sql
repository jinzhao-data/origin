select parameters['new_device_tag'] as usertype,
                 parameters['tag_name'] as tag,
                           sum(case
                                   when eventparams['is_rec_play']='Y' then 1
                                   else 0
                               end) as click
from dws_bobo_sdk_all
where dt = '20171226'
    and eventid ='play'
group by parameters['new_device_tag'],parameters['tag_name']