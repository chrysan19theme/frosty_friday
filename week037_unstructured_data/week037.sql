create or replace database frosty_friday;
create or replace schema week37;
use database frosty_friday;
use schema week37;

--ストレージ統合の作成
create or replace storage integration week37_si
type = external_stage
storage_provider = 's3'
storage_aws_role_arn = 'arn:aws:iam::184545621756:role/week37'
enabled = true
storage_allowed_locations = ('s3://frostyfridaychallenges/challenge_37/');

--外部ステージの作成
create or replace stage week37_stage
storage_integration = week37_si
url = 's3://frostyfridaychallenges/challenge_37/'
directory = (enable = true);

--ディレクトリテーブルのselect
select * from directory(@week37_stage);

--解答
select
relative_path,
size,
file_url,
build_scoped_file_url(@week37_stage, relative_path) as scoped_url,
build_stage_file_url(@week37_stage, relative_path) as staged_url,
get_presigned_url(@week37_stage, relative_path) as presigned_url
from directory(@week37_stage);