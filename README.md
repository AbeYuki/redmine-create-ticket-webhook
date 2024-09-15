# redmine-create-ticket-webhook

## Quick Start

変数定義  
定義内容は Redmine API で確認  
```bash
export REDMINE_URL=
export REDMINE_API_KEY=
export REDMINE_PROJECT_ID=
export RDMINE_TRACKER_ID=
```

docker image を build して起動させる
```bash
make build
make run
```

alertmanger の webhook と仮定して redmine のチケット作成

```bash
make test
```

## remote registry push

```bash
make push
```


## Redmine API

プロジェクト確認
```bash
curl -H "X-Redmine-API-Key: ${REDMINE_API_KEY}" \
     -X GET "${REDMINE_URL}/projects.json" | jq
```

トラッカー確認
```bash
curl -H "X-Redmine-API-Key: ${REDMINE_API_KEY}" \
     -X GET "${REDMINE_URL}/projects/${REDMINE_PROJECT_ID}.json?include=trackers" | jq
```

