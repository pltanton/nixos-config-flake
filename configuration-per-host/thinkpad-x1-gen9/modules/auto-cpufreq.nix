{pkgs, config, ...}: {
    services.auto-cpufreq = {
        enable = true;
    };
}