{
  self,
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (self.lib) mkServiceOption;

  cfg = config.sys.services.postgresql;
in
{
  options.sys.services.postgresql = mkServiceOption "postgresql" {
    port = 5432;
  };

  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [ cfg.port ];

    services.postgresql = {
      enable = true;
      package = pkgs.postgresql_18;

      ensureUsers = [
        {
          name = "postgres";
          ensureClauses = {
            superuser = true;
            login = true;
            createrole = true;
            createdb = true;
            replication = true;
          };
        }
      ];

      checkConfig = true;
      enableTCPIP = true;

      authentication = ''
        local all all peer
        host all all 127.0.0.1/32 md5
        host all all ::1/128 md5

        host all all 100.100.10.0/24 md5
        host pocketid pocketid 100.100.20.0/24 md5
      '';

      settings = {
        port = cfg.port;

        # connectivity
        max_connections = 20;
        superuser_reserved_connections = 3;

        # memory
        shared_buffers = "1024 MB";
        work_mem = "32 MB";
        maintenance_work_mem = "320 MB";
        huge_pages = "off";
        effective_cache_size = "3 GB";
        effective_io_concurrency = 100;
        random_page_cost = 1.25;

        # monitoring
        shared_preload_libraries = "pg_stat_statements";
        track_io_timing = "on";
        track_functions = "pl";

        # replication
        wal_level = "replica";
        max_wal_senders = 10;
        synchronous_commit = "on";

        # checkpointing
        checkpoint_timeout = "15 min";
        checkpoint_completion_target = 0.9;
        max_wal_size = "1024 MB";
        min_wal_size = "512 MB";

        # wal archiving
        archive_mode = "on";
        archive_command = "/bin/true";

        # wal writing
        wal_compression = "on";
        wal_buffers = -1;
        wal_writer_delay = "200ms";
        wal_writer_flush_after = "1MB";
        wal_keep_size = "3650 MB";

        # background writer
        bgwriter_delay = "200ms";
        bgwriter_lru_maxpages = 100;
        bgwriter_lru_multiplier = 2.0;
        bgwriter_flush_after = 0;

        # parallel queries
        max_worker_processes = 2;
        max_parallel_workers_per_gather = 1;
        max_parallel_maintenance_workers = 1;
        max_parallel_workers = 2;
        parallel_leader_participation = "on";

        # advanced
        enable_partitionwise_join = "on";
        enable_partitionwise_aggregate = "on";
        jit = "on";
        max_slot_wal_keep_size = "1000 MB";
        track_wal_io_timing = "on";
        maintenance_io_concurrency = 100;
        wal_recycle = "on";
      };
    };
  };
}
