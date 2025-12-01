-- 1) Daily totals, 7-day rolling average, and day-over-day percent change
WITH daily AS (
  SELECT
    CAST(datetime AS DATE) AS dt,
    SUM("count") AS daily_rentals
  FROM bike_sharing
  GROUP BY 1
),
rolling AS (
  SELECT
    dt,
    daily_rentals,
    AVG(daily_rentals) OVER (ORDER BY dt ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS ma_7d,
    LAG(daily_rentals, 1) OVER (ORDER BY dt) AS prev_day
  FROM daily
)
SELECT
  dt,
  daily_rentals,
  ROUND(ma_7d,2) AS ma_7d,
  CASE 
    WHEN prev_day IS NULL THEN NULL
    WHEN prev_day = 0 THEN NULL
    ELSE ROUND(100.0 * (daily_rentals - prev_day) / prev_day, 2)
  END AS pct_change_vs_prev_day
FROM rolling
ORDER BY dt;

-- 2) Flag days where current 7-day avg < 70% of prior week's 7-day avg (drop >30%)
WITH daily AS (
  SELECT
    CAST(datetime AS DATE) AS dt,
    SUM("count") AS daily_rentals
  FROM bike_sharing
  GROUP BY 1
),
ma AS (
  SELECT
    dt,
    AVG(daily_rentals) OVER (ORDER BY dt ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS ma_7d
  FROM daily
),
ma_lag AS (
  SELECT
    dt,
    ma_7d,
    LAG(ma_7d, 7) OVER (ORDER BY dt) AS ma_prev_week
  FROM ma
)
SELECT
  dt,
  ROUND(ma_7d,2)       AS ma_7d,
  ROUND(ma_prev_week,2) AS ma_7d_prev_week,
  CASE
    WHEN ma_prev_week IS NULL THEN 0
    WHEN ma_prev_week = 0 THEN 0
    WHEN ma_7d < 0.7 * ma_prev_week THEN 1
    ELSE 0
  END AS flag_drop_gt_30pct
FROM ma_lag
WHERE ma_prev_week IS NOT NULL
ORDER BY dt;

-- 3) Top 5 peak hours per season (hour_of_day with highest average rentals)
WITH hourly AS (
  SELECT
    season,
    EXTRACT(HOUR FROM datetime) AS hour_of_day,
    AVG("count") AS avg_rentals
  FROM bike_sharing
  GROUP BY 1,2
),
ranked AS (
  SELECT
    season,
    hour_of_day,
    avg_rentals,
    RANK() OVER (PARTITION BY season ORDER BY avg_rentals DESC) AS rnk
  FROM hourly
)
SELECT season, hour_of_day, ROUND(avg_rentals,2) AS avg_rentals
FROM ranked
WHERE rnk <= 5
ORDER BY season, rnk;

-- 4) Contingency table: counts and seasonal percentage distribution of weather types
WITH ct AS (
  SELECT
    season,
    weather,
    COUNT(*) AS cnt
  FROM bike_sharing
  GROUP BY 1,2
),
season_totals AS (
  SELECT season, SUM(cnt) AS season_total FROM ct GROUP BY 1
)
SELECT
  c.season,
  c.weather,
  c.cnt,
  ROUND(100.0 * c.cnt / s.season_total, 2) AS pct_of_season
FROM ct c
JOIN season_totals s USING (season)
ORDER BY season, weather;

-- 5) Average rentals by workingday and weather (useful for targeted promos)
SELECT
  workingday,
  weather,
  COUNT(*) AS rows,
  ROUND(AVG("count"),2) AS avg_hourly_rentals,
  ROUND(STDDEV_POP("count"),2) AS sd_hourly_rentals
FROM bike_sharing
GROUP BY 1,2
ORDER BY workingday, weather;
