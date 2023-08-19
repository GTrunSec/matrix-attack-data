{ inputs, cell }:
{
  inherit (cell.config.conn) id;
  _path = "string";
  _write_ts = "time";
  ts = "time";
  uid = "string #index=hash";
  trans_depth = "count";
  helo = "string";
  mailfrom = "string";
  rcptto = "list<string>";
  date = "string";
  from = "string";
  to = "list<string>";
  cc = "list<string>";
  reply_to = "string";
  msg_id = "string";
  in_reply_to = "string";
  subject = "string";
  x_originating_ip = "addr";
  first_received = "string";
  process_pop3_headers = "bool";
  entity_count = "count";
  second_received = "string";
  last_reply = "string";
  path = "list<addr>";
  user_agent = "string";
  tls = "bool";
  fuids = "list<string>";
  is_webmail = "bool";
}
