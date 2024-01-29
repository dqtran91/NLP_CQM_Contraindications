/*optimize postgresql*/
-- DB Version: 15
-- OS Type: windows
-- DB Type: desktop
-- Total Memory (RAM): 32 GB
-- CPUs num: 1
-- Connections num: 20
-- Data Storage: ssd

ALTER SYSTEM SET
    max_connections = '20';
ALTER SYSTEM SET
    shared_buffers = '2GB';
ALTER SYSTEM SET
    effective_cache_size = '8GB';
ALTER SYSTEM SET
    maintenance_work_mem = '2047MB';
ALTER SYSTEM SET
    checkpoint_completion_target = '0.9';
ALTER SYSTEM SET
    wal_buffers = '16MB';
ALTER SYSTEM SET
    default_statistics_target = '100';
ALTER SYSTEM SET
    RANDOM_PAGE_COST = '1.1';
ALTER SYSTEM SET
    work_mem = '43690kB';
ALTER SYSTEM SET
    min_wal_size = '100MB';
ALTER SYSTEM SET
    max_wal_size = '2GB';