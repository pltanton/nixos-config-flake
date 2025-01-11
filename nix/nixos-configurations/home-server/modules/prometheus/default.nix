{...}: {
  imports = [./exporters];

  services = {
    prometheus = {
      custom-exporters.smart.enable = true;
      exporters = {
        node = {
          enable = true;
          enabledCollectors = ["textfile"];
          extraFlags = ["--collector.textfile.directory=/var/lib/node_exporter/textfile_collector"];
        };
      };
    };
  };
}
