{...}: {
  services.home-assistant.config = {
    notify = [
      {
        platform = "telegram";
        name = "telegram";
        chat_id = "!secret tg_notifications_channel";
      }

      {
        platform = "group";
        name = "everyone";
        services = [
          {action = "telegram";}
          {action = "mobile_app_anton_mi_11t_pro";}
          {action = "mobile_app_2107113sg";}
        ];
      }
    ];

    automation = [
      {
        alias = "CO2 Level warning";
        triggers = [
          {
            trigger = "numeric_state";
            entity_id = "sensor.cgllc_cgd1st_38aa_co2_density";
            above = 1500;
            for.minutes = 5;
          }
        ];
        actions = [
          {
            action = "notify.everyone";
            data = {
              title = "🍃 Высокий уровень CO2";
              message = "Пора проветрить, уровень CO2 {{ states.sensor.cgllc_cgd1st_38aa_co2_density.state }}🔻";
              data = {
                clickAction = "entityId:sensor.cgllc_cgd1st_38aa_co2_density";
              };
            };
          }
        ];
      }
    ];
  };
}
