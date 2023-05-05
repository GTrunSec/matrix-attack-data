{
  inputs,
  cell,
}: {
  nixago =
    builtins.mapAttrs (
      n: v:
        inputs.std.lib.dev.mkNixago {
          data = v;
          output = "data/phishing/${n}.json";
          format = "json";
          hook.mode = "copy"; # already useful before entering the devshell
        }
    )
    (cell.config // cell.jsonschemas);
}
