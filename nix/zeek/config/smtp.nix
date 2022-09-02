{
  inputs,
  cell,
}: {
  id = {
    orig_h = "addr";
    orig_p = "port";
    resp_h = "addr";
    resp_p = "port";
  };
  _path = "string";
  _write_ts = "time";
  ts = "timestamp";
  uid = "string #index=hash";
}
