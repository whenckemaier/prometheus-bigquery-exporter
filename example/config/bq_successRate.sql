SELECT
    endpoint,
    ROUND(SAFE_DIVIDE((totalSuccess * 100), totalRequests), 3) value
  FROM (
    SELECT
      COUNT(1) AS totalRequests,
      COUNTIF(Success = "X") AS totalSuccess,
      Endpoint AS endpoint
    FROM
      prd-subscription.log.ProductMonitorLogV2
    WHERE
      LogDateTime >= TIMESTAMP_SUB(current_timestamp(), INTERVAL 10 MINUTE)
      AND LogDateTime <= CURRENT_TIMESTAMP()
      AND LogDate = CURRENT_DATE
      AND Type = "FINISH_LOG"
    GROUP BY Endpoint)