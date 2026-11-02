SELECT ad_date, campaign_id, adset_id, spend, impressions, reach, clicks, leads, value, url_parameters, total
FROM public.facebook_ads_basic_daily;

SELECT adset_id, adset_name
FROM public.facebook_adset;

SELECT campaign_id, campaign_name
FROM public.facebook_campaign;

SELECT ad_date, campaign_name, adset_name, spend, impressions, reach, clicks, leads, value, url_parameters
FROM public.google_ads_basic_daily;


---- facebook_ads_basic_daily --> f
---- google_ads_basic_daily --> g


with facebook_data as 
(
select 
	f.ad_date, 
	f.url_parameters, 
	coalesce(f.spend, 0) as spend,
	coalesce(f.impressions, 0) as impressions,
	coalesce(f.reach, 0) as reach,
	coalesce(f.clicks, 0) as clicks,
	coalesce(f.leads, 0) as leads,
	coalesce(f.value, 0) as value,
	'facebook ads' as media_source
from public.facebook_ads_basic_daily as f
),

google_data as
(
select 
	g.ad_date,
	g.url_parameters,
	coalesce(g.spend, 0) as spend,
	coalesce(g.impressions, 0) as impressions,
	coalesce(g.reach, 0) as reach,
	coalesce(g.clicks, 0) as clicks,
	coalesce(g.leads, 0) as leads,
	coalesce(g.value, 0) as value,
	 'google ads' as media_source
from public.google_ads_basic_daily as g	
),
combined as 
(
select *
from facebook_data
union
select *
from google_data
)

select ad_date, 

---- utm_campaign küçük harf, 'nan' ise NULL
case
	when lower(substring(url_parameters from 'utm_campaign=([^&]*)')) = 'nan' then null
	else lower(substring(url_parameters from 'utm_campaign=([^&]*)'))
end as utm_campaign,

---- Toplam metrikler
sum(spend) as total_spend,
sum(impressions) as total_impressions,
sum(clicks) as total_clicks,
sum(value) as total_value,


---- Hesaplanan metrikler (CASE ile sıfıra bölme engeli)
case when sum(impressions) = 0 then 0 else sum(clicks)::decimal / sum(impressions) end as CTR,
case when sum(clicks) = 0 then 0 else sum(spend)::decimal / sum(clicks) end as CPC,
case when sum(impressions) = 0 then 0 else sum(spend)::decimal / sum(impressions) * 1000 end as CPM,
case when sum(spend) = 0 then 0 else sum(value)::decimal / sum(spend) end as ROMI

from combined
group by ad_date,
case 
	when lower(substring(url_parameters from 'utm_campaign=([^&]*)')) = 'nan' then null
    else lower(substring(url_parameters from 'utm_campaign=([^&]*)'))
end

order by ad_date;