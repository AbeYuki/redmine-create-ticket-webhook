import os
import requests
from flask import Flask, request

app = Flask(__name__)

# 環境変数から Redmine の URL、API キー、プロジェクト ID を取得
REDMINE_URL = os.getenv('REDMINE_URL')
REDMINE_API_KEY = os.getenv('REDMINE_API_KEY')
REDMINE_PROJECT_ID = os.getenv('REDMINE_PROJECT_ID')
REDMINE_TRACKER_ID = os.getenv('REDMINE_TRACKER_ID', 1)

@app.route('/create_ticket', methods=['POST'])
def create_ticket():
    alert = request.json
    
    # アラート内容を基にチケットのタイトルと説明を作成
    subject = f"Alert: {alert['alerts'][0]['labels']['alertname']}"
    description = alert['alerts'][0]['annotations']['description']

    # Redmine チケット作成のためのデータを作成
    ticket_data = {
        'issue': {
            'project_id': REDMINE_PROJECT_ID,
            'tracker_id': REDMINE_TRACKER_ID,
            'subject': subject,
            'description': description,
            'priority_id': 2    
        }
    }

    # Redmine API にチケット作成リクエストを送信
    response = requests.post(
        f"{REDMINE_URL}/issues.json",
        json=ticket_data,
        headers={'X-Redmine-API-Key': REDMINE_API_KEY}
    )
    if response.status_code == 201:
        return 'チケット作成に成功した', 201
    else:
        return 'チケット作成に失敗した', response.status_code

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
