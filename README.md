# aws_cli_tool

# 概要
# コマンドリスト
## 実行コマンド
`bash <本プロジェクトを配置したディレクトリ>/aws_cli_tool/load_aws_cli_tool.sh <AWSサービス名> <コマンド> <オプション>`

### 推奨
- 以下の形式にてaliasとして登録することを推奨します。
   - `alias aws_cli_tool='bash <本プロジェクトを配置したディレクトリ>/aws_cli_tool/load_aws_cli_tool.sh'`
      - 上記の場合の実行コマンド：`aws_cli_tool <AWSサービス名> <コマンド> <オプション>`
         - 例：`aws_cli_tool ec2 serverlist --vpc --with-status`

## オプション
| AWSサービス名 | コマンド | 概要 | オプション | オプション説明 |
| :-- | :-- | :-- | :-- | :-- |
| ec2 | serverlist | EC2インスタンスの一覧を表示する<br>Nameタグ・プライベートIPアドレス | --vpc | 同一VPC上に存在するEC2インスタンスを対象とする |
|  |  |  | --with-status | 以下を追加で表示する<br>ステータス・起動時刻 |
|  |  |  | --sort | 表示項目をソートする |
|  | get_my_instance_name | 自身のNameタグの値を取得する | | |
| cli | command_list | awsコマンドの`command`と`subcommand`の一覧を表示する | --reload | キャッシュファイルを削除する |
|  |  |  |  |  |
