{ inputs, cell }:
let
  inherit (cell.config.conn) id;
in
{
  inherit id;
  _path = "string";
  _write_ts = "time";
  ts = "time";
  uid = "string #index=hash";
  trans_depth = "count";
  helo = "string";
  mailfrom = "string";
  start_time = "time";
  end_time = "time";
  duration = "duration";
  rcptto = "list<string>";
  date = "string";
  from = "string";
  to = "list<string>";
  cc = "list<string>";
  reply_to = "string";
  msg_id = "string";
  in_reply_to = "string";
  subject = "string";
  first_received = "string";
  second_received = "string";
  path = "list<addr>";
  user_name = "list<string>";
  service = "list<string>";
  user_password = "list<string>";
  tls = "bool";
  capabilities = "list<string>";
}
