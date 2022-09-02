{
  inputs,
  cell,
}: {
  id = {
    orig_h = "addr";
    orig_p = "count";
    resp_h = "addr";
    resp_p = "count";
  };
  _path = "string";
  _write_ts = "time";
  ts = "time";
  uid = "string #index=hash";
  proto = "string";
  service = "string";
  duration = "duration";
  orig_bytes = "count";
  resp_bytes = "count";
  conn_state = "string";
  local_orig = "bool";
  local_resp = "bool";
  missed_bytes = "count";
  history = "string";
  orig_pkts = "count";
  orig_ip_bytes = "count";
  resp_pkts = "count";
  resp_ip_bytes = "count";
  tunnel_parents = "list<string>";
  community_id = "string";
}
