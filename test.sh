#!/bin/bash

# 現在時刻を ISO 8601 形式で生成
STARTS_AT=$(TZ=Asia/Tokyo date +"%Y-%m-%dT%H:%M:%S%z")

# curl コマンドで POST リクエストを送信
curl -X POST http://localhost:5000/create_ticket \
     -H "Content-Type: application/json" \
     -d '{
           "alerts": [
             {
               "labels": {
                 "alertname": "TestAlert",
                 "severity": "critical"
               },
               "annotations": {
                 "summary": "test",
                 "description": "test"
               },
               "startsAt": "'"$STARTS_AT"'"
             }
           ]
         }'
