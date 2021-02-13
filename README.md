# aws_cli_tool

# 概要
# コマンドリスト
以下の形式にてaliasとして登録してください。
- `alias <エイリアス名>='bash <本プロジェクトを配置したディレクトリ>/aws_cli_tool/load_aws_cli_tool.sh <AWSサービス名> <コマンド> <オプション>'`
   - 例) `alias serverlist='bash /home/my_user/aws_cli_tool/load_aws_cli_tool.sh ec2 serverlist --vpc'`

| 概要 | AWSサービス名 | コマンド | オプション |
| :-- | :-- | :-- | :-- |
| EC2インスタンスの一覧を表示する | ec2 | serverlist |  |
| 同一VPC上に存在するEC2インスタンスの一覧を表示する | ec2 | serverlist | --vpc |
| 自身のNameタグの値を取得する | ec2 | get_my_instance_name |  |
|  |  |  |  |
