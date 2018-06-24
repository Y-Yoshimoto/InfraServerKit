FROM redmine
MAINTAINER redmine_custom

# プラグインを導入する
## チケットのテンプレートを追加
RUN git clone https://github.com/akiko-pusu/redmine_issue_templates /usr/src/redmine/plugins/redmine_issue_templates

## 反映されない場合にexecし、以下を実行する
# RUN rake redmine:plugins:migrate RAILS_ENV=production

# テーマを導入する
RUN git clone https://github.com/tsi/redmine-theme-flat.git /usr/src/redmine/public/themes/redmine-theme-flat

# 設定ファイルをコピーする
COPY configuration.yml /usr/src/redmine/config/configuration.yml
